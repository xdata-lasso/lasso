#!/usr/bin/env python3
"""
XData / XDataPublic Non-Empty Data Generation Evaluator.

Evaluates XData on benchmark suites stored in benchmarks/<benchmark_name>/DDL.sql and queries.txt.

Usage:
  python3 evaluate_xdata.py [--tool xdata|xdatapublic] [--benchmark <name|all>] [--queries <q1,q2>] [--timeout <sec>]
"""

import os
import sys
import time
import csv
import json
import re
import sqlite3
import argparse
import tempfile
import sqlglot
from typing import Optional, List, Tuple, Dict, Any

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
EXPERIMENTS_DIR = os.path.abspath(os.path.join(SCRIPT_DIR, ".."))
REPO_ROOT = os.path.abspath(os.path.join(EXPERIMENTS_DIR, ".."))
BENCHMARKS_DIR = os.path.join(SCRIPT_DIR, "benchmarks")
RESULTS_DIR = os.path.join(SCRIPT_DIR, "results")

sys.path.insert(0, os.path.join(REPO_ROOT, "src"))
sys.path.insert(0, EXPERIMENTS_DIR)

try:
    from evaluate_xdata import (
        ensure_xdata_bridge_ready,
        prepare_postgres_ddl,
        generate_xdata_with_timeout,
    )
except ImportError:
    ensure_xdata_bridge_ready = None
    prepare_postgres_ddl = None
    generate_xdata_with_timeout = None


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

    sample_data = None
    sample_path = os.path.join(bench_dir, "sample_data.sql")
    if not os.path.exists(sample_path) and "beaver" in bench_dir:
        cand = os.path.join(EXPERIMENTS_DIR, "originals", "beaver_tests", "sample_data.sql")
        if os.path.exists(cand):
            sample_path = cand
        else:
            sample_path = os.path.join(EXPERIMENTS_DIR, "beaver_tests", "sample_data.sql")
    if os.path.exists(sample_path):
        with open(sample_path, "r", encoding="utf-8") as f:
            sample_data = f.read().strip()

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
        "sample_data": sample_data,
        "queries": queries
    }


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


def run_benchmark(bench_dir: str, tool_name: str, query_filter: Optional[set], timeout: int) -> Dict[str, Any]:
    bench_data = load_benchmark_from_dir(bench_dir)
    if not bench_data:
        raise ValueError(f"Could not load benchmark from {bench_dir}")

    bench_name = bench_data["benchmark"]
    schema_sql = bench_data["ddl"]
    sample_data_sql = bench_data.get("sample_data")
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

    tool_dir_name = f"results_{tool_name.lower()}"
    out_bench_dir = os.path.join(RESULTS_DIR, bench_name, tool_dir_name)
    datasets_dir = os.path.join(out_bench_dir, "datasets")
    os.makedirs(datasets_dir, exist_ok=True)

    print("\n" + "=" * 65)
    print(f"{tool_name.upper()} Non-Empty Data Generation: {bench_name}")
    print(f"Testing {len(queries)} query/queries (timeout: {timeout}s per query)")
    print("=" * 65)

    if ensure_xdata_bridge_ready is None:
        print("[ERROR] evaluate_xdata module could not be imported from experiments.")
        return {"benchmark": bench_name, "total": len(queries), "passed": 0, "time": 0.0}

    os.environ["XDATA_TOOL_NAME"] = tool_name.lower()
    ensure_xdata_bridge_ready()

    temp_sample_file = None
    if sample_data_sql:
        temp_sf = tempfile.NamedTemporaryFile("w", suffix=".sql", delete=False, encoding="utf-8")
        temp_sf.write(sample_data_sql)
        temp_sf.close()
        temp_sample_file = temp_sf.name

    pg_ddl = prepare_postgres_ddl(schema_sql) if prepare_postgres_ddl else schema_sql

    passed = 0
    total_start = time.perf_counter()
    summary = {}

    for q in queries:
        q_id = q["id"]
        q_sql = q["sql"]
        t0 = time.perf_counter()

        try:
            pg_query = sqlglot.transpile(q_sql, read="sqlite", write="postgres")[0]
        except Exception:
            pg_query = q_sql

        datasets, meta, bridge_status = generate_xdata_with_timeout(
            pg_ddl,
            temp_sample_file,
            pg_query,
            timeout
        )

        status = "EMPTY"
        row_count = 0
        num_inserts = 0
        gen_sql = ""
        err = meta.get("error_message", "") if isinstance(meta, dict) else ""

        if bridge_status == "TIMEOUT":
            status = "TIMEOUT"
            print(f"  {q_id:<10}: [TIMEOUT] {err or 'Timeout'} ({time.perf_counter() - t0:.3f}s)", flush=True)
        elif bridge_status != "SUCCESS":
            status = "ERROR"
            print(f"  {q_id:<10}: [ERROR] {err or 'Bridge error'} ({time.perf_counter() - t0:.3f}s)", flush=True)
        elif datasets:
            gen_sql = "\n".join(ds.get("sql", "") for ds in datasets if isinstance(ds, dict) and ds.get("sql"))
            if gen_sql.strip():
                num_inserts = len([line for line in gen_sql.splitlines() if line.strip().upper().startswith("INSERT")])
                dataset_path = os.path.join(datasets_dir, f"{q_id}.sql")
                with open(dataset_path, "w", encoding="utf-8") as df:
                    df.write(gen_sql + "\n")

                rows, exec_err = execute_sqlite_in_memory(schema_sql, gen_sql, q_sql)
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
                print(f"  {q_id:<10}: [EMPTY] 0 rows ({time.perf_counter() - t0:.3f}s)", flush=True)
        else:
            status = "EMPTY"
            print(f"  {q_id:<10}: [EMPTY] 0 rows ({time.perf_counter() - t0:.3f}s)", flush=True)

        elapsed = time.perf_counter() - t0
        summary[q_id] = {
            "query_id": q_id,
            "status": status,
            "row_count": row_count,
            "elapsed_seconds": round(elapsed, 4),
            "dataset_file": f"datasets/{q_id}.sql" if (gen_sql and gen_sql.strip()) else "",
            "num_insert_statements": num_inserts,
            "error_message": err or ""
        }

    if temp_sample_file and os.path.exists(temp_sample_file):
        try:
            os.remove(temp_sample_file)
        except Exception:
            pass

    total_time = time.perf_counter() - total_start
    pct = (passed / len(queries) * 100.0) if queries else 0.0
    print("-" * 65)
    print(f"Benchmark Summary ({bench_name}): {passed}/{len(queries)} non-empty ({pct:.1f}%) in {total_time:.2f}s")
    print(f"Saved results to: {out_bench_dir}")
    print("-" * 65)

    csv_file = os.path.join(out_bench_dir, "results.csv")
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
        for q_id, q_data in sorted(summary.items()):
            writer.writerow({
                "query_id": q_id,
                "status": q_data["status"],
                "row_count": q_data["row_count"],
                "elapsed_seconds": q_data["elapsed_seconds"],
                "dataset_file": q_data["dataset_file"],
                "num_insert_statements": q_data["num_insert_statements"],
                "error_message": q_data["error_message"]
            })

    return {
        "benchmark": bench_name,
        "total": len(queries),
        "passed": passed,
        "time": total_time,
        "csv_path": csv_file
    }


def main():
    parser = argparse.ArgumentParser(description="Evaluate XData on non-empty data generation benchmarks")
    parser.add_argument("--tool", type=str, default="xdata", choices=["xdata", "xdatapublic"], help="XData engine (default: xdata)")
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
        res = run_benchmark(bd, args.tool, q_filter, args.timeout)
        overall_passed += res["passed"]
        overall_total += res["total"]

    print("\n" + "=" * 65)
    print(f"{args.tool.upper()} TOTAL NON-EMPTY DATA GENERATION: {overall_passed}/{overall_total} passed")
    print("=" * 65 + "\n")


if __name__ == "__main__":
    main()
