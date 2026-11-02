import os
import sys
import time
import csv
import json
import uuid
import sqlite3
import argparse

CURR_DIR = os.path.dirname(os.path.abspath(__file__))
EXPERIMENTS_DIR = os.path.abspath(os.path.join(CURR_DIR, ".."))
REPO_ROOT = os.path.abspath(os.path.join(CURR_DIR, "..", ".."))

sys.path.insert(0, EXPERIMENTS_DIR)
sys.path.insert(0, os.path.join(EXPERIMENTS_DIR, "ParSEval", "src"))
sys.path.insert(0, os.path.join(REPO_ROOT, "sql-execution-tester"))

from parseval import instantiate_db
from timeout_utils import run_with_timeout

SCHEMA_FILE = os.path.join(CURR_DIR, "schema.sql")
QUERIES_FILE = os.path.join(CURR_DIR, "top10_queries.json")

def load_schema():
    with open(SCHEMA_FILE, "r", encoding="utf-8") as f:
        return f.read()

def load_queries():
    with open(QUERIES_FILE, "r", encoding="utf-8") as f:
        data = json.load(f)
    return {q["id"]: q["sql"] for q in data}

def dump_sqlite_inserts(db_path):
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

def parse_args():
    parser = argparse.ArgumentParser(description="ParSEval Beaver (dw schema) Runner")
    parser.add_argument("--queries", type=str, default="", help="Comma-separated query IDs (default: all)")
    parser.add_argument("--timeout", type=int, default=30, help="Timeout in seconds per query (default: 30)")
    return parser.parse_args()

def main():
    args = parse_args()
    schema_sql = load_schema()
    queries = load_queries()

    if args.queries:
        selected = {q.strip().lower() for q in args.queries.split(",") if q.strip()}
        test_queries = {qid: sql for qid, sql in queries.items() if qid.lower() in selected}
    else:
        test_queries = queries

    results_dir = os.path.join(CURR_DIR, "results_parseval")
    datasets_dir = os.path.join(results_dir, "datasets")
    os.makedirs(datasets_dir, exist_ok=True)

    print("=" * 65)
    print("ParSEval Beaver (dw schema) Test Data Generation & Non-Empty Execution")
    print(f"Testing {len(test_queries)} query/queries (timeout: {args.timeout}s)")
    print("=" * 65)

    passed = 0
    total_start = time.perf_counter()
    results_summary = {}

    for q_id, q_sql in sorted(test_queries.items()):
        t0 = time.perf_counter()
        status = "EMPTY"
        row_count = 0
        dataset_sql = ""
        num_inserts = 0
        err = ""
        res_sample = []
        db_path = f"/tmp/parseval_beaver_{uuid.uuid4().hex}.db"
        conn_str = f"sqlite:///{db_path}"

        try:
            result = run_with_timeout(
                instantiate_db,
                args.timeout,
                sql=q_sql,
                schema=schema_sql,
                connection_string=conn_str,
                dialect="sqlite",
                timeout=args.timeout,
            )

            elapsed = time.perf_counter() - t0

            if not result.success:
                status = "ERROR"
                err = result.error_msg or (result.generation.error_msg if result.generation else "Unknown error")
                print(f"{q_id}: [ERROR] {err} ({elapsed:.3f}s)", flush=True)
            else:
                # Extract dataset SQL
                dataset_sql = dump_sqlite_inserts(db_path)
                num_inserts = result.generation.rows_generated if result.generation else len(dataset_sql.splitlines())

                # Check query execution result
                if result.q_result and not result.q_result.is_error:
                    rows = result.q_result.rows or []
                    row_count = len(rows)
                    if row_count > 0:
                        status = "OK"
                        passed += 1
                        res_sample = [list(r) for r in rows[:5]]
                        print(f"{q_id}: [OK] {row_count} row(s) ({elapsed:.3f}s, {num_inserts} inserted)", flush=True)
                    else:
                        status = "EMPTY"
                        print(f"{q_id}: [EMPTY] 0 rows ({elapsed:.3f}s, {num_inserts} inserted)", flush=True)
                elif result.q_result and result.q_result.is_error:
                    status = "ERROR"
                    err = result.q_result.error_msg or "Query execution failed"
                    print(f"{q_id}: [ERROR] {err} ({elapsed:.3f}s)", flush=True)
                else:
                    status = "EMPTY"
                    print(f"{q_id}: [EMPTY] 0 rows ({elapsed:.3f}s)", flush=True)

            if dataset_sql:
                dataset_file = os.path.join(datasets_dir, f"{q_id}.sql")
                with open(dataset_file, "w", encoding="utf-8") as f:
                    f.write(dataset_sql + "\n")

        except TimeoutError:
            elapsed = time.perf_counter() - t0
            status = "TIMEOUT"
            err = f"Timeout after {args.timeout}s"
            print(f"{q_id}: [TIMEOUT] ({elapsed:.3f}s)", flush=True)
        except Exception as e:
            elapsed = time.perf_counter() - t0
            status = "EXCEPTION"
            err = str(e)
            print(f"{q_id}: [EXCEPTION] {err} ({elapsed:.3f}s)", flush=True)
        finally:
            if os.path.exists(db_path):
                try:
                    os.remove(db_path)
                except Exception:
                    pass

        results_summary[q_id] = {
            "status": status,
            "row_count": row_count,
            "elapsed_seconds": round(elapsed, 4),
            "dataset_file": f"datasets/{q_id}.sql" if dataset_sql else "",
            "num_insert_statements": num_inserts,
            "error_message": err or "",
            "result_sample": res_sample,
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
