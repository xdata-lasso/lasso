import os
import sys
import time
import csv
import json
import sqlite3
import argparse
from typing import Optional, List, Tuple

CURR_DIR = os.path.dirname(os.path.abspath(__file__))
EXPERIMENTS_DIR = os.path.abspath(os.path.join(CURR_DIR, ".."))
REPO_ROOT = os.path.abspath(os.path.join(CURR_DIR, "..", ".."))

sys.path.insert(0, os.path.join(REPO_ROOT, "src"))

from parser import parse_ddl_to_schema, parse_sql_to_ast
from dataset_generator import generate_base_dataset, ensure_dataset_uniqueness
from dataset_generator.augmentation import repair_orphan_rows
from dataset_generator.value_generator import DataFactory
from sql_serializer import generate_inserts
from models import Dataset


def execute_sqlite_in_memory(schema_sql: str, dataset_sql: str, query_sql: str) -> Tuple[Optional[List[Tuple]], Optional[str]]:
    """Execute schema, dataset inserts, and query directly in an in-memory SQLite database."""
    conn = sqlite3.connect(":memory:")
    try:
        cur = conn.cursor()
        cur.executescript(schema_sql)
        if dataset_sql.strip():
            cur.executescript(dataset_sql)
        cur.execute(query_sql)
        rows = cur.fetchall()
        return rows, None
    except Exception as e:
        return None, str(e)
    finally:
        conn.close()

SCHEMA_FILE = os.path.join(CURR_DIR, "schema.sql")
QUERIES_FILE = os.path.join(CURR_DIR, "top10_queries.json")

def load_schema():
    with open(SCHEMA_FILE, "r", encoding="utf-8") as f:
        return f.read()

def load_queries():
    with open(QUERIES_FILE, "r", encoding="utf-8") as f:
        data = json.load(f)
    return {q["id"]: q["sql"] for q in data}

def parse_args():
    parser = argparse.ArgumentParser(description="LASSO Beaver (dw schema) Runner")
    parser.add_argument("--queries", type=str, default="", help="Comma-separated query IDs (default: all)")
    parser.add_argument("--timeout", type=int, default=30, help="Timeout in seconds per query (default: 30)")
    return parser.parse_args()

def main():
    args = parse_args()
    schema_sql = load_schema()
    queries = load_queries()
    schema = parse_ddl_to_schema(schema_sql)

    if args.queries:
        selected = {q.strip().lower() for q in args.queries.split(",") if q.strip()}
        test_queries = {qid: sql for qid, sql in queries.items() if qid.lower() in selected}
    else:
        test_queries = queries
    
    results_dir = os.path.join(CURR_DIR, "results_lasso")
    datasets_dir = os.path.join(results_dir, "datasets")
    os.makedirs(datasets_dir, exist_ok=True)

    print("=" * 65)
    print("LASSO Beaver (dw schema) Test Data Generation & Non-Empty Execution")
    print(f"Testing {len(test_queries)} query/queries")
    print("=" * 65)

    passed = 0
    total_start = time.perf_counter()
    results_summary = {}

    for q_id, q_sql in sorted(test_queries.items()):
        t0 = time.perf_counter()
        DataFactory.get_instance().reset(42)
        DataFactory.get_instance().clear_uniqueness()

        status = "EMPTY"
        row_count = 0
        dataset_sql = ""
        num_inserts = 0
        err = ""
        try:
            t0 = time.perf_counter()
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
            elapsed = time.perf_counter() - t0

            dataset_sql = "\n".join(base_ds.insert_statements)
            num_inserts = len(base_ds.insert_statements)

            # Save dataset SQL
            dataset_file = os.path.join(datasets_dir, f"{q_id}.sql")
            with open(dataset_file, "w", encoding="utf-8") as f:
                f.write(dataset_sql + "\n")

            # Run in-memory SQLite execution test
            gold_res, err = execute_sqlite_in_memory(
                schema_sql=schema_sql,
                dataset_sql=dataset_sql,
                query_sql=q_sql
            )

            if err:
                status = "ERROR"
                print(f"{q_id}: [ERROR] {err} ({elapsed:.3f}s)", flush=True)
            elif gold_res and len(gold_res) > 0:
                status = "OK"
                row_count = len(gold_res)
                passed += 1
                print(f"{q_id}: [OK] {row_count} row(s) ({elapsed:.3f}s)", flush=True)
            else:
                status = "EMPTY"
                print(f"{q_id}: [EMPTY] 0 rows ({elapsed:.3f}s)", flush=True)

        except Exception as e:
            elapsed = time.perf_counter() - t0
            status = "EXCEPTION"
            err = str(e)
            print(f"{q_id}: [EXCEPTION] {err} ({elapsed:.3f}s)", flush=True)

        results_summary[q_id] = {
            "status": status,
            "row_count": row_count,
            "elapsed_seconds": round(elapsed, 4),
            "dataset_file": f"datasets/{q_id}.sql" if dataset_sql else "",
            "num_insert_statements": num_inserts,
            "error_message": err or "",
            "result_sample": [list(r) for r in gold_res[:5]] if gold_res else [],
        }

    total_time = time.perf_counter() - total_start
    total_q = len(queries)
    pass_pct = (passed / total_q * 100) if total_q else 0.0

    print("=" * 65)
    print(f"Summary: {passed}/{total_q} non-empty ({pass_pct:.1f}%) in {total_time:.2f}s")
    print(f"Saved results to: {results_dir}")
    print("=" * 65)

    results_csv_path = os.path.join(results_dir, "results.csv")
    with open(results_csv_path, "w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(
            f,
            fieldnames=[
                "query_id",
                "status",
                "row_count",
                "elapsed_seconds",
                "dataset_file",
                "num_insert_statements",
                "error_message",
            ],
        )
        writer.writeheader()
        for q_id, q_data in sorted(results_summary.items()):
            writer.writerow({
                "query_id": q_id,
                "status": q_data["status"],
                "row_count": q_data["row_count"],
                "elapsed_seconds": q_data["elapsed_seconds"],
                "dataset_file": q_data["dataset_file"],
                "num_insert_statements": q_data["num_insert_statements"],
                "error_message": q_data["error_message"],
            })

if __name__ == "__main__":
    main()
