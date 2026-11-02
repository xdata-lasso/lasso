#!/usr/bin/env python3
"""
LASSO Non-Empty Data Generation Evaluator.

Evaluates LASSO's base dataset generation capability on benchmark suites
stored in benchmarks/<benchmark_name>/DDL.sql and queries.txt.

Usage:
  python3 evaluate_lasso.py [--benchmark <name|all>] [--queries <q1,q2>] [--timeout <sec>]
"""

import os
import sys
import time
import csv
import json
import re
import sqlite3
import argparse
import concurrent.futures
from typing import Optional, List, Tuple, Dict, Any

from timeout_utils import run_with_timeout

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
EXPERIMENTS_DIR = os.path.abspath(os.path.join(SCRIPT_DIR, ".."))
REPO_ROOT = os.path.abspath(os.path.join(EXPERIMENTS_DIR, ".."))
BENCHMARKS_DIR = os.path.join(SCRIPT_DIR, "benchmarks")
RESULTS_DIR = os.path.join(SCRIPT_DIR, "results")

sys.path.insert(0, os.path.join(REPO_ROOT, "src"))

from parser import parse_ddl_to_schema, parse_sql_to_ast
from dataset_generator import generate_base_dataset, ensure_dataset_uniqueness
from dataset_generator.augmentation import repair_orphan_rows
from dataset_generator.value_generator import DataFactory
from sql_serializer import generate_inserts
from models import Dataset


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


def generate_and_test_single_query(schema, schema_sql: str, q_sql: str) -> Tuple[str, int, str, int, Optional[str], List]:
    """Generate base dataset and test non-empty query execution."""
    DataFactory.get_instance().reset(42)
    DataFactory.get_instance().clear_uniqueness()

    parsed_q = parse_sql_to_ast(q_sql)
    base_data = generate_base_dataset(schema, parsed_q)
    base_ds = Dataset(
        strategy_name="BaseDatasetStrategy",
        data=base_data,
        tags=["base_dataset"],
        description="Attempts to yield a non-empty result for the query."
    )
    base_ds.data = ensure_dataset_uniqueness(schema, base_ds.data)
    repair_orphan_rows(schema, base_ds.data)
    base_ds.insert_statements = generate_inserts(schema, base_ds)

    dataset_sql = "\n".join(base_ds.insert_statements)
    num_inserts = len(base_ds.insert_statements)

    rows, err = execute_sqlite_in_memory(schema_sql, dataset_sql, q_sql)
    if err:
        return "ERROR", 0, dataset_sql, num_inserts, err, []
    if rows and len(rows) > 0:
        return "OK", len(rows), dataset_sql, num_inserts, None, [list(r) for r in rows[:5]]
    return "EMPTY", 0, dataset_sql, num_inserts, None, []


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

    schema = parse_ddl_to_schema(schema_sql)

    out_bench_dir = os.path.join(RESULTS_DIR, bench_name, "results_lasso")
    datasets_dir = os.path.join(out_bench_dir, "datasets")
    os.makedirs(datasets_dir, exist_ok=True)

    print("\n" + "=" * 65)
    print(f"LASSO Non-Empty Data Generation: {bench_name}")
    print(f"Testing {len(queries)} query/queries (timeout: {timeout}s per query)")
    print("=" * 65)

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
        err = None
        res_sample = []

        try:
            status, row_count, dataset_sql, num_inserts, err, res_sample = run_with_timeout(
                generate_and_test_single_query, timeout, schema, schema_sql, q_sql
            )
        except TimeoutError:
            status = "TIMEOUT"
            err = f"Execution exceeded {timeout}s limit"
        except Exception as e:
            status = "ERROR"
            err = str(e)

        elapsed = time.perf_counter() - t0

        if dataset_sql:
            dataset_path = os.path.join(datasets_dir, f"{q_id}.sql")
            with open(dataset_path, "w", encoding="utf-8") as df:
                df.write(dataset_sql + "\n")

        if status == "OK":
            passed += 1
            print(f"  {q_id:<10}: [OK] {row_count} row(s) ({elapsed:.3f}s, {num_inserts} inserts)", flush=True)
        elif status == "EMPTY":
            print(f"  {q_id:<10}: [EMPTY] 0 rows ({elapsed:.3f}s, {num_inserts} inserts)", flush=True)
        elif status == "TIMEOUT":
            print(f"  {q_id:<10}: [TIMEOUT] ({elapsed:.3f}s)", flush=True)
        else:
            print(f"  {q_id:<10}: [ERROR] {err} ({elapsed:.3f}s)", flush=True)

        summary[q_id] = {
            "query_id": q_id,
            "status": status,
            "row_count": row_count,
            "elapsed_seconds": round(elapsed, 4),
            "dataset_file": f"datasets/{q_id}.sql" if dataset_sql else "",
            "num_insert_statements": num_inserts,
            "error_message": err or "",
            "result_sample": res_sample
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
    parser = argparse.ArgumentParser(description="Evaluate LASSO on non-empty data generation benchmarks")
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

    if not bench_dirs:
        print("No benchmark directories found with DDL.sql and queries.txt. Run 'python3 build_benchmarks.py' first.")
        sys.exit(1)

    overall_passed = 0
    overall_total = 0
    for bd in bench_dirs:
        res = run_benchmark(bd, q_filter, args.timeout)
        overall_passed += res["passed"]
        overall_total += res["total"]

    print("\n" + "=" * 65)
    print(f"LASSO TOTAL NON-EMPTY DATA GENERATION: {overall_passed}/{overall_total} passed")
    print("=" * 65 + "\n")


if __name__ == "__main__":
    main()
