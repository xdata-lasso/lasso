import os
import sys
import time
import csv
import json
import sqlite3
import argparse
import sqlglot
from typing import Optional, List, Tuple

CURR_DIR = os.path.dirname(os.path.abspath(__file__))
EXPERIMENTS_DIR = os.path.abspath(os.path.join(CURR_DIR, ".."))
REPO_ROOT = os.path.abspath(os.path.join(CURR_DIR, "..", ".."))

sys.path.insert(0, os.path.join(REPO_ROOT, "src"))
sys.path.insert(0, EXPERIMENTS_DIR)

from evaluate_xdata import (
    ensure_xdata_bridge_ready,
    prepare_postgres_ddl,
    generate_xdata_with_timeout,
)


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
SAMPLE_DATA_FILE = os.path.join(CURR_DIR, "sample_data.sql")

def load_schema():
    with open(SCHEMA_FILE, "r", encoding="utf-8") as f:
        return f.read()

def load_queries():
    with open(QUERIES_FILE, "r", encoding="utf-8") as f:
        data = json.load(f)
    return {q["id"]: q["sql"] for q in data}

def parse_args():
    parser = argparse.ArgumentParser(description="Beaver dw Test Data Generation for XData / xdatapublic")
    parser.add_argument("--tool", type=str, default="xdata", choices=["xdata", "xdatapublic"], help="Which xdata engine to test (default: xdata)")
    parser.add_argument("--queries", type=str, default="", help="Comma-separated query IDs (default: all)")
    parser.add_argument("--timeout", type=int, default=60, help="Timeout in seconds per query (default: 60)")
    return parser.parse_args()

def main():
    args = parse_args()
    
    # Configure tool environment if testing xdatapublic
    if args.tool == "xdatapublic":
        os.environ["XDATA_TOOL_NAME"] = "xdatapublic"
        os.environ["XDATA_ROOT"] = os.path.join(EXPERIMENTS_DIR, "xdatapublic")
        os.environ["XDATA_BIN_DIR"] = os.path.join(EXPERIMENTS_DIR, "xdatapublic", "bin")
        os.environ["XDATA_JARS_DIR"] = os.path.join(EXPERIMENTS_DIR, "xdatapublic", "xdata", "jars")
        os.environ["XDATA_Z3_LIB_DIR"] = os.path.join(EXPERIMENTS_DIR, "xdatapublic", "xdata", "z3")
        results_dir = os.path.join(CURR_DIR, "results_xdatapublic")
    else:
        os.environ["XDATA_TOOL_NAME"] = "xdata"
        results_dir = os.path.join(CURR_DIR, "results_xdata")

    datasets_dir = os.path.join(results_dir, "datasets")
    os.makedirs(datasets_dir, exist_ok=True)

    schema_sql = load_schema()
    queries = load_queries()

    if args.queries:
        selected = {q.strip().lower() for q in args.queries.split(",") if q.strip()}
        test_queries = {qid: sql for qid, sql in queries.items() if qid.lower() in selected}
    else:
        test_queries = queries

    ensure_xdata_bridge_ready()
    pg_ddl = prepare_postgres_ddl(schema_sql)

    if not os.path.exists(SAMPLE_DATA_FILE):
        print(f"Error: Sample data not found at {SAMPLE_DATA_FILE}")
        sys.exit(1)

    print("=" * 65)
    print(f"Running {args.tool.upper()} Beaver (dw schema) Benchmark")
    print(f"Testing {len(test_queries)} query/queries (timeout: {args.timeout}s per query)")
    print(f"Sample data: {SAMPLE_DATA_FILE}")
    print("=" * 65)

    passed = 0
    total_start = time.perf_counter()
    results_summary = {}

    for q_id, q_sql in sorted(test_queries.items()):
        t0 = time.perf_counter()

        try:
            pg_sql = sqlglot.transpile(q_sql, read="mysql", write="postgres")[0]
        except Exception:
            try:
                pg_sql = sqlglot.transpile(q_sql, read="sqlite", write="postgres")[0]
            except Exception:
                pg_sql = q_sql

        datasets, meta, bridge_status = generate_xdata_with_timeout(
            pg_ddl=pg_ddl,
            sample_data_path=SAMPLE_DATA_FILE,
            query_sql_pg=pg_sql,
            timeout_sec=args.timeout,
        )

        elapsed = time.perf_counter() - t0
        num_generated = len(datasets)
        err = meta.get("error_message", "")

        status = "EMPTY"
        row_count = 0
        best_dataset_name = ""
        best_dataset_sql = ""
        best_num_inserts = 0
        best_res = None

        if bridge_status == "TIMEOUT":
            status = "TIMEOUT"
            err = err or f"Timeout after {args.timeout}s"
            print(f"{q_id}: [TIMEOUT] ({elapsed:.3f}s) - {err}", flush=True)
        elif bridge_status == "NO_DATASETS" or not datasets:
            status = "NO_DATASETS"
            output_lines = []
            if err and err != "No test datasets generated":
                output_lines.append(err)
            if meta.get("stderr", "").strip():
                output_lines.append(meta.get("stderr", "").strip())
            if meta.get("stdout", "").strip():
                output_lines.append(meta.get("stdout", "").strip())
            
            raw_output = "\n".join(output_lines).strip()
            err = raw_output or "No test datasets generated"
            print(f"{q_id}: [NO_DATASETS] ({elapsed:.3f}s)", flush=True)
            if raw_output:
                print("  --- Java Output / Error ---", flush=True)
                for line in raw_output.splitlines():
                    print(f"  {line}", flush=True)
                print("  ---------------------------", flush=True)
        elif bridge_status != "SUCCESS":
            status = "ERROR"
            output_lines = []
            if err:
                output_lines.append(err)
            if meta.get("stderr", "").strip():
                output_lines.append(meta.get("stderr", "").strip())
            if meta.get("stdout", "").strip():
                output_lines.append(meta.get("stdout", "").strip())
            
            raw_output = "\n".join(output_lines).strip()
            err = raw_output or f"XData failed with status {bridge_status}"
            print(f"{q_id}: [ERROR] ({elapsed:.3f}s)", flush=True)
            if raw_output:
                print("  --- Java Output / Error ---", flush=True)
                for line in raw_output.splitlines():
                    print(f"  {line}", flush=True)
                print("  ---------------------------", flush=True)
        else:
            # Detect the base dataset DS0 for XData
            ds0_item = next((ds for ds in datasets if ds.get("name") == "DS0"), None)
            target_ds_item = ds0_item if ds0_item is not None else datasets[0]
            
            ds_name = target_ds_item.get("name", "DS0")
            ds_sql = target_ds_item.get("sql", "").strip()
            best_dataset_name = ds_name
            best_dataset_sql = ds_sql
            best_num_inserts = len([s for s in ds_sql.split(";") if s.strip()])

            # Run in-memory SQLite execution test
            gold_res, exec_err = execute_sqlite_in_memory(
                schema_sql=schema_sql,
                dataset_sql=ds_sql,
                query_sql=q_sql
            )

            if exec_err:
                status = "EXEC_ERROR"
                err = exec_err
                print(f"{q_id}: [EXEC_ERROR] ({elapsed:.3f}s) - {ds_name}: {err}", flush=True)
            elif gold_res and len(gold_res) > 0:
                status = "OK"
                row_count = len(gold_res)
                passed += 1
                best_res = gold_res
                print(f"{q_id}: [OK] {row_count} row(s) ({elapsed:.3f}s) - {num_generated} dataset(s) (base: {best_dataset_name})", flush=True)
            else:
                status = "EMPTY"
                print(f"{q_id}: [EMPTY] 0 rows ({elapsed:.3f}s) - {num_generated} dataset(s) (base: {best_dataset_name})", flush=True)

        if best_dataset_sql:
            dataset_file = os.path.join(datasets_dir, f"{q_id}.sql")
            with open(dataset_file, "w", encoding="utf-8") as f:
                f.write(best_dataset_sql + "\n")
            dataset_rel = f"datasets/{q_id}.sql"
        else:
            dataset_rel = ""

        results_summary[q_id] = {
            "status": status,
            "row_count": row_count,
            "elapsed_seconds": round(elapsed, 4),
            "num_datasets_generated": num_generated,
            "best_dataset_name": best_dataset_name,
            "dataset_file": dataset_rel,
            "num_insert_statements": best_num_inserts,
            "error_message": err or "",
            "result_sample": [list(r) for r in best_res[:5]] if best_res else [],
        }

    total_time = time.perf_counter() - total_start
    total_q = len(test_queries)
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
                "num_datasets_generated",
                "best_dataset_name",
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
                "num_datasets_generated": q_data["num_datasets_generated"],
                "best_dataset_name": q_data["best_dataset_name"],
                "dataset_file": q_data["dataset_file"],
                "num_insert_statements": q_data["num_insert_statements"],
                "error_message": q_data["error_message"],
            })

if __name__ == "__main__":
    main()
