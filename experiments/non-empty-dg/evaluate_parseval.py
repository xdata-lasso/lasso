#!/usr/bin/env python3
"""
ParSEval Non-Empty Data Generation Evaluator.

Evaluates ParSEval on benchmark suites stored in benchmarks/<benchmark_name>/DDL.sql and queries.txt.

Usage:
  python3 evaluate_parseval.py [--benchmark <name|all>] [--queries <q1,q2>] [--timeout <sec>]
"""

import os
import sys
import time
import csv
import json
import re
import uuid
import sqlite3
import argparse
from typing import Optional, List, Dict, Any

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
EXPERIMENTS_DIR = os.path.abspath(os.path.join(SCRIPT_DIR, ".."))
REPO_ROOT = os.path.abspath(os.path.join(EXPERIMENTS_DIR, ".."))
BENCHMARKS_DIR = os.path.join(SCRIPT_DIR, "benchmarks")
RESULTS_DIR = os.path.join(SCRIPT_DIR, "results")

sys.path.insert(0, EXPERIMENTS_DIR)
sys.path.insert(0, os.path.join(EXPERIMENTS_DIR, "originals", "ParSEval", "src"))
sys.path.insert(0, os.path.join(EXPERIMENTS_DIR, "ParSEval", "src"))
sys.path.insert(0, os.path.join(REPO_ROOT, "sql-execution-tester"))

try:
    from parseval import instantiate_db
except ImportError:
    instantiate_db = None

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


def dump_sqlite_inserts(db_path: str) -> str:
    """Dump INSERT statements from SQLite DB."""
    if not os.path.exists(db_path):
        return ""
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
    tables = [r[0] for r in cursor.fetchall() if not r[0].startswith("sqlite_")]
    inserts = []
    for tbl in tables:
        cursor.execute(f"SELECT * FROM \"{tbl}\";")
        rows = cursor.fetchall()
        if not rows:
            continue
        cursor.execute(f"PRAGMA table_info(\"{tbl}\");")
        cols = [col[1] for col in cursor.fetchall()]
        cols_str = ", ".join([f"\"{c}\"" for c in cols])
        for row in rows:
            vals = []
            for v in row:
                if v is None:
                    vals.append("NULL")
                elif isinstance(v, (int, float)):
                    vals.append(str(v))
                else:
                    escaped = str(v).replace("'", "''")
                    vals.append(f"'{escaped}'")
            inserts.append(f"INSERT INTO \"{tbl}\" ({cols_str}) VALUES ({', '.join(vals)});")
    conn.close()
    return "\n".join(inserts)


def run_benchmark(bench_dir: str, query_filter: Optional[set], timeout: int) -> Dict[str, Any]:
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

    out_bench_dir = os.path.join(RESULTS_DIR, bench_name, "results_parseval")
    datasets_dir = os.path.join(out_bench_dir, "datasets")
    os.makedirs(datasets_dir, exist_ok=True)

    print("\n" + "=" * 65)
    print(f"ParSEval Non-Empty Data Generation: {bench_name}")
    print(f"Testing {len(queries)} query/queries (timeout: {timeout}s per query)")
    print("=" * 65)

    if instantiate_db is None:
        print("[ERROR] ParSEval modules not found. Ensure .parseval_venv is activated or installed.")
        return {"benchmark": bench_name, "total": len(queries), "passed": 0, "time": 0.0}

    passed = 0
    total_start = time.perf_counter()
    summary = {}

    for q in queries:
        q_id = q["id"]
        q_sql = q["sql"]
        t0 = time.perf_counter()

        status = "EMPTY"
        row_count = 0
        dataset_sql = ""
        num_inserts = 0
        err = ""
        db_path = f"/tmp/parseval_{bench_name}_{uuid.uuid4().hex}.db"
        conn_str = f"sqlite:///{db_path}"

        try:
            if run_with_timeout:
                result = run_with_timeout(
                    instantiate_db,
                    timeout,
                    sql=q_sql,
                    schema=schema_sql,
                    connection_string=conn_str,
                    dialect="sqlite",
                    timeout=timeout,
                )
            else:
                result = instantiate_db(
                    sql=q_sql,
                    schema=schema_sql,
                    connection_string=conn_str,
                    dialect="sqlite",
                    timeout=timeout,
                )

            elapsed = time.perf_counter() - t0

            if not result.success:
                status = "ERROR"
                err = result.error_msg or (result.generation.error_msg if result.generation else "Unknown error")
                print(f"  {q_id:<10}: [ERROR] {err} ({elapsed:.3f}s)", flush=True)
            else:
                dataset_sql = dump_sqlite_inserts(db_path)
                num_inserts = result.generation.rows_generated if result.generation else len(dataset_sql.splitlines())

                if result.q_result and not result.q_result.is_error:
                    rows = result.q_result.rows or []
                    row_count = len(rows)
                    if row_count > 0:
                        status = "OK"
                        passed += 1
                        print(f"  {q_id:<10}: [OK] {row_count} row(s) ({elapsed:.3f}s, {num_inserts} inserts)", flush=True)
                    else:
                        status = "EMPTY"
                        print(f"  {q_id:<10}: [EMPTY] 0 rows ({elapsed:.3f}s, {num_inserts} inserts)", flush=True)
                elif result.q_result and result.q_result.is_error:
                    status = "ERROR"
                    err = result.q_result.error_msg or "Query execution failed"
                    print(f"  {q_id:<10}: [ERROR] {err} ({elapsed:.3f}s)", flush=True)
                else:
                    status = "EMPTY"
                    print(f"  {q_id:<10}: [EMPTY] 0 rows ({elapsed:.3f}s, {num_inserts} inserts)", flush=True)

            if dataset_sql:
                dataset_file = os.path.join(datasets_dir, f"{q_id}.sql")
                with open(dataset_file, "w", encoding="utf-8") as f:
                    f.write(dataset_sql + "\n")

        except TimeoutError:
            elapsed = time.perf_counter() - t0
            status = "TIMEOUT"
            err = f"Execution exceeded {timeout}s limit"
            print(f"  {q_id:<10}: [TIMEOUT] ({elapsed:.3f}s)", flush=True)
        except Exception as e:
            elapsed = time.perf_counter() - t0
            status = "ERROR"
            err = str(e)
            print(f"  {q_id:<10}: [ERROR] {err} ({elapsed:.3f}s)", flush=True)
        finally:
            if os.path.exists(db_path):
                try:
                    os.remove(db_path)
                except Exception:
                    pass

        summary[q_id] = {
            "query_id": q_id,
            "status": status,
            "row_count": row_count,
            "elapsed_seconds": round(elapsed, 4),
            "dataset_file": f"datasets/{q_id}.sql" if dataset_sql else "",
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
    parser = argparse.ArgumentParser(description="Evaluate ParSEval on non-empty data generation benchmarks")
    parser.add_argument("--benchmark", type=str, default="all", help="Benchmark name (e.g. 'beaver', 'tpch', 'all')")
    parser.add_argument("--queries", type=str, default="", help="Comma-separated query IDs (default: all)")
    parser.add_argument("--timeout", type=int, default=30, help="Timeout in seconds per query (default: 30)")
    args = parser.parse_args()

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
        res = run_benchmark(bd, q_filter, args.timeout)
        overall_passed += res["passed"]
        overall_total += res["total"]

    print("\n" + "=" * 65)
    print(f"ParSEval TOTAL NON-EMPTY DATA GENERATION: {overall_passed}/{overall_total} passed")
    print("=" * 65 + "\n")


if __name__ == "__main__":
    main()
