#!/usr/bin/env python3
"""
Gemini LLM Non-Empty Data Generation Evaluator.

Evaluates Gemini on benchmark suites stored in benchmarks/<benchmark_name>/DDL.sql and queries.txt.

Usage:
  python3 evaluate_gemini.py [--benchmark <name|all>] [--queries <q1,q2>] [--timeout <sec>] [--model <model_name>]
"""

import os
import sys
import time
import csv
import json
import re
import sqlite3
import argparse
import urllib.request
import urllib.error
from typing import Optional, List, Tuple, Dict, Any

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
EXPERIMENTS_DIR = os.path.abspath(os.path.join(SCRIPT_DIR, ".."))
REPO_ROOT = os.path.abspath(os.path.join(EXPERIMENTS_DIR, ".."))
BENCHMARKS_DIR = os.path.join(SCRIPT_DIR, "benchmarks")
RESULTS_DIR = os.path.join(SCRIPT_DIR, "results")

try:
    from timeout_utils import run_with_timeout
except ImportError:
    run_with_timeout = None


def resolve_benchmark_dir(b_token: str) -> Optional[str]:
    """Resolves benchmark directory across name variations and dialects."""
    target = os.path.join(BENCHMARKS_DIR, b_token)
    if os.path.isdir(target) and os.path.exists(os.path.join(target, "DDL.sql")):
        return target
    target_sq = os.path.join(BENCHMARKS_DIR, "sqlite", b_token)
    if os.path.isdir(target_sq) and os.path.exists(os.path.join(target_sq, "DDL.sql")):
        return target_sq
    norm = b_token.replace("-", "").replace("_", "").lower()
    for base in [BENCHMARKS_DIR, os.path.join(BENCHMARKS_DIR, "sqlite")]:
        if not os.path.exists(base):
            continue
        for item in sorted(os.listdir(base)):
            if item in ["sqlite", "mysql", "postgres", "stats", "__pycache__"]:
                continue
            item_norm = item.replace("-", "").replace("_", "").lower()
            if item_norm == norm:
                cand = os.path.join(base, item)
                if os.path.isdir(cand) and os.path.exists(os.path.join(cand, "DDL.sql")):
                    return cand
    return None


def load_benchmark_from_dir(bench_dir: str) -> Optional[Dict[str, Any]]:
    """Loads benchmark from a directory containing DDL.sql and queries.txt / queries.json."""
    ddl_path = os.path.join(bench_dir, "DDL.sql")
    if not os.path.exists(ddl_path):
        ddl_path = os.path.join(bench_dir, "schema.sql")

    queries_path = os.path.join(bench_dir, "queries.txt")
    queries_json_path = os.path.join(bench_dir, "queries.json")

    if not os.path.exists(ddl_path) or (not os.path.exists(queries_path) and not os.path.exists(queries_json_path)):
        return None

    with open(ddl_path, "r", encoding="utf-8") as f:
        ddl = f.read().strip()

    queries = []
    if os.path.exists(queries_json_path):
        try:
            with open(queries_json_path, "r", encoding="utf-8") as f:
                data = json.load(f)
            for idx, item in enumerate(data):
                if isinstance(item, dict) and "sql" in item:
                    qid = item.get("id", f"q{idx+1:02d}")
                    sql = item["sql"].strip()
                    queries.append({
                        "id": qid,
                        "sql": sql,
                        "min_rows_required": item.get("min_rows_required"),
                        "complexity": item.get("complexity")
                    })
        except Exception:
            queries = []

    if not queries and os.path.exists(queries_path):
        with open(queries_path, "r", encoding="utf-8") as f:
            for idx, line in enumerate(f):
                line_s = line.strip()
                if not line_s or line_s.startswith("--"):
                    continue
                if "|" in line_s and not line_s.upper().startswith("SELECT") and not line_s.upper().startswith("WITH"):
                    parts = line_s.split("|", 1)
                    qid = parts[0].strip()
                    sql = parts[1].strip()
                else:
                    qid = f"q{idx+1:02d}"
                    sql = line_s
                queries.append({"id": qid, "sql": sql})

    bench_name = os.path.basename(os.path.normpath(bench_dir))
    return {
        "benchmark": bench_name,
        "name": bench_name,
        "ddl": ddl,
        "queries": queries
    }


def get_api_key() -> str:
    """Retrieve Gemini API key from environment variables or shell profile."""
    api_key = os.environ.get("GEMINI_API_KEY") or os.environ.get("GOOGLE_API_KEY")
    if api_key:
        return api_key.strip()

    home_dir = os.path.expanduser("~")
    for fname in [".bashrc", ".profile", ".zshrc"]:
        path = os.path.join(home_dir, fname)
        if os.path.exists(path):
            with open(path, "r", encoding="utf-8", errors="ignore") as f:
                for line in f:
                    match = re.search(r'export\s+(?:GEMINI_API_KEY|GOOGLE_API_KEY)=["\']?([^"\'\s#]+)["\']?', line)
                    if match:
                        return match.group(1).strip()
    return ""


def execute_sqlite_in_memory(schema_sql: str, dataset_sql: str, query_sql: str) -> Tuple[Optional[List[Tuple]], Optional[str]]:
    """Execute schema, dataset inserts, and query directly in an in-memory SQLite database."""
    conn = sqlite3.connect(":memory:")
    try:
        cur = conn.cursor()
        cur.executescript(schema_sql)
        if dataset_sql and dataset_sql.strip():
            cur.executescript(dataset_sql)
        cur.execute(query_sql)
        rows = cur.fetchall()
        return rows, None
    except Exception as e:
        return None, str(e)
    finally:
        conn.close()


def query_gemini_api(api_key: str, model: str, prompt: str, timeout: int = 30) -> str:
    """Send prompt to Gemini API via HTTP request."""
    url = f"https://generativelanguage.googleapis.com/v1beta/models/{model}:generateContent?key={api_key}"
    headers = {"Content-Type": "application/json"}
    body = {
        "contents": [{"parts": [{"text": prompt}]}],
        "generationConfig": {"temperature": 0.0, "maxOutputTokens": 4096}
    }
    req = urllib.request.Request(url, data=json.dumps(body).encode("utf-8"), headers=headers, method="POST")
    try:
        with urllib.request.urlopen(req, timeout=timeout) as response:
            res_data = json.loads(response.read().decode("utf-8"))
            candidates = res_data.get("candidates", [])
            if candidates:
                parts = candidates[0].get("content", {}).get("parts", [])
                if parts:
                    return parts[0].get("text", "")
            return ""
    except urllib.error.HTTPError as e:
        detail = e.read().decode("utf-8", errors="ignore")
        try:
            detail = json.loads(detail).get("error", {}).get("message", detail)
        except ValueError:
            pass
        raise RuntimeError(f"Gemini API request failed: HTTP {e.code}: {detail}")
    except Exception as e:
        raise RuntimeError(f"Gemini API request failed: {e}")


def extract_sql_inserts(response_text: str) -> List[str]:
    """Extract complete INSERT statements from Markdown code blocks or plain text.

    Statements are delimited with sqlite3.complete_statement so that multi-line
    INSERTs (e.g. column list and VALUES on separate lines) are kept intact.
    """
    pattern = r"```(?:sql)?\s*([\s\S]*?)```"
    matches = re.findall(pattern, response_text, re.IGNORECASE)
    if matches:
        combined = "\n".join(matches)
    else:
        combined = response_text

    inserts = []
    buffer = ""
    for line in combined.splitlines():
        if not buffer and not line.strip():
            continue
        buffer += line + "\n"
        if sqlite3.complete_statement(buffer):
            stmt = buffer.strip()
            buffer = ""
            if stmt.upper().startswith("INSERT"):
                inserts.append(stmt)
    return inserts


def run_benchmark(bench_dir: str, api_key: str, model: str, query_filter: Optional[set], timeout: int) -> Dict[str, Any]:
    bench_data = load_benchmark_from_dir(bench_dir)
    if not bench_data:
        raise ValueError(f"Could not load benchmark from {bench_dir}")

    bench_name = bench_data["benchmark"]
    schema_sql = bench_data["ddl"]
    all_queries = bench_data["queries"]

    if query_filter:
        queries = [
            q for idx, q in enumerate(all_queries)
            if q.get("id", "").lower() in query_filter
            or str(idx) in query_filter
            or str(idx + 1) in query_filter
            or f"q{idx + 1}" in query_filter
            or f"q{idx + 1:02d}" in query_filter
            or f"many_rows_{idx+1:02d}" in query_filter
        ]
    else:
        queries = all_queries

    out_bench_dir = os.path.join(RESULTS_DIR, bench_name, "results_gemini")
    datasets_dir = os.path.join(out_bench_dir, "datasets")
    os.makedirs(datasets_dir, exist_ok=True)

    print("\n" + "=" * 65)
    print(f"GEMINI ({model}) Non-Empty Data Generation: {bench_name}")
    print(f"Testing {len(queries)} query/queries (timeout: {timeout}s per query)")
    print("=" * 65)

    passed = 0
    total_start = time.perf_counter()
    summary = {}

    for q in queries:
        q_id = q["id"]
        q_sql = q["sql"]
        t0 = time.perf_counter()

        prompt = f"""You are an expert database test data generator.
Given the following SQLite schema DDL and target query, generate valid SQL INSERT statements
to populate the tables such that executing the query returns at least one non-empty result row.
All foreign key and domain constraints must be satisfied. Output only SQL INSERT statements.

SCHEMA:
{schema_sql}

TARGET QUERY:
{q_sql}
"""
        status = "EMPTY"
        row_count = 0
        dataset_sql = ""
        num_inserts = 0
        err = ""

        try:
            if run_with_timeout:
                resp_text = run_with_timeout(query_gemini_api, timeout, api_key, model, prompt, timeout=timeout)
            else:
                resp_text = query_gemini_api(api_key, model, prompt, timeout=timeout)
            insert_stmts = extract_sql_inserts(resp_text)
            dataset_sql = "\n".join(insert_stmts)
            num_inserts = len(insert_stmts)

            if dataset_sql.strip():
                dataset_path = os.path.join(datasets_dir, f"{q_id}.sql")
                with open(dataset_path, "w", encoding="utf-8") as df:
                    df.write(dataset_sql + "\n")

                rows, exec_err = execute_sqlite_in_memory(schema_sql, dataset_sql, q_sql)
                if exec_err:
                    status = "ERROR"
                    err = exec_err
                    print(f"  {q_id:<10}: [ERROR] {err} ({time.perf_counter() - t0:.3f}s)", flush=True)
                elif rows and len(rows) > 0:
                    status = "OK"
                    row_count = len(rows)
                    passed += 1
                    print(f"  {q_id:<10}: [OK] {row_count} row(s) ({time.perf_counter() - t0:.3f}s, {num_inserts} inserts)", flush=True)
                else:
                    status = "EMPTY"
                    print(f"  {q_id:<10}: [EMPTY] 0 rows ({time.perf_counter() - t0:.3f}s, {num_inserts} inserts)", flush=True)
            else:
                status = "EMPTY"
                print(f"  {q_id:<10}: [EMPTY] No INSERT statements generated ({time.perf_counter() - t0:.3f}s)", flush=True)

        except Exception as e:
            elapsed = time.perf_counter() - t0
            err = str(e)
            if isinstance(e, TimeoutError) or "timed out" in err.lower() or "timeout" in err.lower():
                status = "TIMEOUT"
                print(f"  {q_id:<10}: [TIMEOUT] {err} ({elapsed:.3f}s)", flush=True)
            else:
                status = "ERROR"
                print(f"  {q_id:<10}: [ERROR] {err} ({elapsed:.3f}s)", flush=True)

        elapsed = time.perf_counter() - t0
        summary[q_id] = {
            "query_id": q_id,
            "status": status,
            "row_count": row_count,
            "elapsed_seconds": round(elapsed, 4),
            "dataset_file": f"datasets/{q_id}.sql" if dataset_sql.strip() else "",
            "num_insert_statements": num_inserts,
            "error_message": err or ""
        }

        csv_file = os.path.join(out_bench_dir, "results.csv")
        existing_rows = {}
        if query_filter and os.path.exists(csv_file):
            try:
                with open(csv_file, "r", encoding="utf-8") as f:
                    for row in csv.DictReader(f):
                        if row.get("query_id"):
                            existing_rows[row["query_id"]] = row
            except Exception:
                pass
        for k_id, q_data in summary.items():
            existing_rows[k_id] = {
                "query_id": k_id,
                "status": q_data["status"],
                "row_count": q_data["row_count"],
                "elapsed_seconds": q_data["elapsed_seconds"],
                "dataset_file": q_data["dataset_file"],
                "num_insert_statements": q_data["num_insert_statements"],
                "error_message": q_data["error_message"]
            }
        with open(csv_file, "w", newline="", encoding="utf-8") as f:
            writer = csv.DictWriter(
                f,
                fieldnames=[
                    "query_id",
                    "status",
                    "row_count",
                    "elapsed_seconds",
                    "dataset_file",
                    "num_insert_statements",
                    "error_message"
                ]
            )
            writer.writeheader()
            for k_id, row_data in sorted(existing_rows.items()):
                writer.writerow(row_data)

    total_time = time.perf_counter() - total_start
    pct = (passed / len(queries) * 100.0) if queries else 0.0
    print("-" * 65)
    print(f"Benchmark Summary ({bench_name}): {passed}/{len(queries)} non-empty ({pct:.1f}%) in {total_time:.2f}s")
    print(f"Saved results to: {out_bench_dir}")
    print("-" * 65)

    csv_file = os.path.join(out_bench_dir, "results.csv")

    return {
        "benchmark": bench_name,
        "total": len(queries),
        "passed": passed,
        "time": total_time,
        "csv_path": csv_file
    }


def main():
    parser = argparse.ArgumentParser(description="Evaluate Gemini LLM on non-empty data generation benchmarks")
    parser.add_argument("--benchmark", type=str, default="all", help="Benchmark name (e.g. 'beaver', 'tpch', 'all')")
    parser.add_argument("--queries", type=str, default="", help="Comma-separated query IDs (default: all)")
    parser.add_argument("--timeout", type=int, default=30, help="Timeout in seconds per query (default: 30)")
    parser.add_argument("--model", type=str, default="gemini-3.8-flash", help="Gemini model name")
    args = parser.parse_args()

    api_key = get_api_key()
    if not api_key:
        print("Error: GEMINI_API_KEY environment variable not set.")
        sys.exit(1)

    q_filter = {q.strip().lower() for q in args.queries.split(",") if q.strip()} if args.queries else None

    # Discover available benchmark folders
    bench_dirs = []
    tokens = [b.strip() for b in re.split(r'[, ]+', args.benchmark) if b.strip()]
    if any(t.lower() == "all" for t in tokens):
        for item in sorted(os.listdir(BENCHMARKS_DIR)):
            if item in ["sqlite", "mysql", "postgres", "stats", "__pycache__"]:
                continue
            item_path = os.path.join(BENCHMARKS_DIR, item)
            if os.path.isdir(item_path) and os.path.exists(os.path.join(item_path, "DDL.sql")):
                bench_dirs.append(item_path)
    else:
        for b in tokens:
            target = resolve_benchmark_dir(b)
            if not target:
                print(f"Error: Benchmark directory for '{b}' not found. Run build_benchmarks.py first.")
                sys.exit(1)
            bench_dirs.append(target)

    overall_passed = 0
    overall_total = 0
    for bd in bench_dirs:
        res = run_benchmark(bd, api_key, args.model, q_filter, args.timeout)
        overall_passed += res["passed"]
        overall_total += res["total"]

    print("\n" + "=" * 65)
    print(f"GEMINI TOTAL NON-EMPTY DATA GENERATION: {overall_passed}/{overall_total} passed")
    print("=" * 65 + "\n")


if __name__ == "__main__":
    main()
