#!/usr/bin/env python3
"""
ParSEval-TDG: ParSEval Test Data Generator Evaluator (Single-Query Mode)
========================================================================

Unlike pairwise equivalence refutation (which generates test data targeting two queries),
ParSEval-TDG generates test databases looking solely at the single Gold / Reference query
using ParSEval's coverage-driven SymbolicEngine.

1. Generates test datasets from the Gold query and database schema DDL across diverse
   coverage thresholds (NULL branches, false branches, duplicate detection, distinct projection).
2. Executes candidate prediction / mutant queries against these synthesized datasets using
   execution_test_batch.
3. Refutes a mutant as soon as any generated dataset causes the mutant's output to diverge
   from the Gold query (NEQ or NEQ_SCO).
4. Records structured results, reproducible counterexamples, and data generation statistics.
"""

import argparse
import contextlib
import csv
import json
import os
import sys
import time
import uuid
from collections import Counter
from typing import Any, Dict, List, Optional, Tuple

from tqdm import tqdm

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, SCRIPT_DIR)
sys.path.insert(0, os.path.abspath(os.path.join(SCRIPT_DIR, '../src')))
sys.path.insert(0, os.path.abspath(os.path.join(SCRIPT_DIR, '../sql-execution-tester')))

parseval_src = os.path.join(SCRIPT_DIR, 'originals', 'ParSEval', 'src')
if not os.path.exists(parseval_src):
    parseval_src = os.path.join(SCRIPT_DIR, 'ParSEval', 'src')
sys.path.insert(0, os.path.abspath(parseval_src))

try:
    from execution_tester import execution_test_batch, generate_reproducible_sql
except ImportError as e:
    print(f"Error importing execution_tester: {e}")
    sys.exit(1)

try:
    from parseval.main import instantiate_db
except ImportError as e:
    print(f"Error importing ParSEval instantiate_db: {e}")
    sys.exit(1)

import csv_utils
import benchmark_loader

# Benchmarks available in the evaluation suite
SUPPORTED_BENCHMARKS = {'bird', 'calcite', 'cubes', 'largejoin', 'leetcode', 'literature', 'tpch', 'xdata', 'lasso-bm', 'mm-bm', 'mmo-bm', 'mmro-bm', 'manymutantsbm'}

# Load global schemas
SCHEMAS_DATA_GLOBAL = benchmark_loader.get_schemas(base_dir=SCRIPT_DIR)


def get_ddl(database_id: str) -> str:
    """Retrieve DDL from schemas.json for the given database ID."""
    if database_id in SCHEMAS_DATA_GLOBAL:
        return SCHEMAS_DATA_GLOBAL[database_id].get("ddl", "")
    return ""


def generate_parseval_datasets(
    ddl_content: str,
    gold_sql: str,
    max_datasets: int = 5,
    dialect: str = "sqlite",
    timeout: int = 60
) -> Tuple[List[str], float, str]:
    """
    Generate test dataset for a single gold query using ParSEval's instantiate_db.
    Returns (datasets, elapsed_time, error_message).
    """
    import sqlite3
    import tempfile

    t0 = time.perf_counter()
    with tempfile.NamedTemporaryFile(suffix=".db", delete=False) as tf:
        db_path = tf.name

    try:
        conn_str = f"sqlite:///{db_path}"
        res = instantiate_db(
            sql=gold_sql,
            schema=ddl_content,
            connection_string=conn_str,
            dialect=dialect,
            timeout=timeout
        )
        elapsed = time.perf_counter() - t0
        if not res.success:
            return [], elapsed, res.error_msg or "ParSEval instantiate_db failed"

        conn = sqlite3.connect(db_path)
        inserts = [line for line in conn.iterdump() if line.startswith("INSERT INTO")]
        conn.close()

        if not inserts:
            return [], elapsed, "ParSEval generated 0 rows"

        dataset_sql = "\n".join(inserts)
        return [dataset_sql], elapsed, ""
    except Exception as e:
        return [], time.perf_counter() - t0, str(e)
    finally:
        if os.path.exists(db_path):
            try:
                os.remove(db_path)
            except Exception:
                pass


def process_instance(
    item: Dict[str, Any],
    dialect: str = "sqlite",
    max_datasets: int = 5,
    results_dir: str = "results",
    tool_prefix: str = "parseval_tdg",
    existing_records: Optional[Dict[str, Dict[str, str]]] = None,
    retry: bool = False
) -> Tuple[List[Dict[str, Any]], Dict[str, Any]]:
    """Process an instance: generate ParSEval test datasets for gold query, then test mutants."""
    db_id = item.get('schema_id') or item.get('database_id')
    raw_instance_id = item.get('id') or item.get('instance_id') or db_id
    instance_id = str(raw_instance_id).strip()
    safe_instance_id = instance_id.replace('/', '_').replace('\\', '_')

    gold_sql = item.get(f'gold_sql_{dialect}', item.get('gold_sql', '')).strip()
    predictions = item.get('predictions', [])

    eval_results: List[Dict[str, Any]] = []
    datagen_record: Dict[str, Any] = {
        "instance_id": instance_id,
        "query_id": "gold",
        "query_type": "gold",
        "data_gen_time": 0.0,
        "num_datasets": 0,
        "error_message": ""
    }

    if not gold_sql or not predictions:
        return eval_results, datagen_record

    ddl_content = get_ddl(db_id)
    if not ddl_content:
        for p_idx, pred in enumerate(predictions):
            pid = pred.get('prediction_id', f"{instance_id}_pred_{p_idx}")
            eval_results.append({
                "instance_id": instance_id,
                "prediction_id": pid,
                "raw_tool_status": "SKIPPED_NO_DDL",
                "EXTEST_STATUS": "SKIPPED_NO_DDL",
                "reproducible_cex": "",
                "time_taken": 0.0,
                "error_message": f"Schema DDL not found for {db_id}",
                "gold_sql_result": "",
                "prediction_sql_result": "",
                "num_datasets": 0
            })
        return eval_results, datagen_record

    # Check which predictions need evaluation
    preds_to_eval = []
    for p_idx, pred in enumerate(predictions):
        pid = pred.get('prediction_id', f"{instance_id}_pred_{p_idx}")
        if existing_records and pid in existing_records:
            prev = existing_records[pid]
            prev_status = prev.get('EXTEST_STATUS', '')
            if not retry and prev_status:
                eval_results.append(prev)
                continue
            if retry and prev_status in ('NEQ', 'EQ', 'EQ_EXEC', 'NEQ_SCO'):
                eval_results.append(prev)
                continue
        preds_to_eval.append((pid, pred))

    if not preds_to_eval:
        return eval_results, datagen_record

    # Step 1: Synthesize test datasets for the Gold query using ParSEval
    datasets, gen_time, gen_err = generate_parseval_datasets(
        ddl_content=ddl_content,
        gold_sql=gold_sql,
        max_datasets=max_datasets,
        dialect=dialect
    )

    datagen_record["data_gen_time"] = round(gen_time, 4)
    datagen_record["num_datasets"] = len(datasets)
    datagen_record["error_message"] = gen_err

    if not datasets:
        for pid, pred in preds_to_eval:
            eval_results.append({
                "instance_id": instance_id,
                "prediction_id": pid,
                "raw_tool_status": "ERROR_DATASET_GENERATION",
                "EXTEST_STATUS": "ERROR_DATASET_GENERATION",
                "reproducible_cex": "",
                "time_taken": round(gen_time, 4),
                "error_message": gen_err,
                "gold_sql_result": "",
                "prediction_sql_result": "",
                "num_datasets": 0
            })
        return eval_results, datagen_record

    # Step 2: Evaluate mutant predictions across generated datasets
    pids = [pid for pid, _ in preds_to_eval]
    pred_queries = {pid: pred.get(f'prediction_sql_{dialect}', pred.get('prediction_sql', '')).strip() for pid, pred in preds_to_eval}

    pred_states: Dict[str, Dict[str, Any]] = {
        pid: {
            "status": "unrefuted",
            "execution_result": None,
            "dataset_sql": "",
            "error_message": ""
        }
        for pid in pids
    }

    unrefuted_pids = list(pids)
    for ds_idx, dataset_sql in enumerate(datasets):
        if not unrefuted_pids:
            break

        current_queries = [pred_queries[p] for p in unrefuted_pids]
        with open(os.devnull, 'w') as devnull, contextlib.redirect_stdout(devnull):
            test_results = execution_test_batch(
                schema=ddl_content,
                dataset=dataset_sql,
                gold_sql=gold_sql,
                prediction_sqls=current_queries,
                dialect=dialect
            )

        still_unrefuted = []
        for i, res in enumerate(test_results):
            pid = unrefuted_pids[i]
            exec_status = res.get("status", "")

            if not pred_states[pid]["execution_result"]:
                pred_states[pid]["execution_result"] = res
                pred_states[pid]["dataset_sql"] = dataset_sql
                if exec_status.startswith("ERROR"):
                    pred_states[pid]["status"] = exec_status
                    pred_states[pid]["error_message"] = res.get("error_message", "")

            if exec_status.startswith("NEQ"):
                pred_states[pid]["status"] = exec_status
                pred_states[pid]["execution_result"] = res
                pred_states[pid]["dataset_sql"] = dataset_sql
            else:
                if exec_status.startswith("ERROR") and not pred_states[pid]["status"].startswith("NEQ"):
                    pred_states[pid]["status"] = exec_status
                    pred_states[pid]["execution_result"] = res
                    pred_states[pid]["dataset_sql"] = dataset_sql
                    pred_states[pid]["error_message"] = res.get("error_message", "")
                still_unrefuted.append(pid)

        unrefuted_pids = still_unrefuted

    # Finalize status for each mutant prediction
    for pid, pred in preds_to_eval:
        st = pred_states[pid]["status"]
        exec_res = pred_states[pid]["execution_result"]
        ds_sql = pred_states[pid]["dataset_sql"]
        err_msg = pred_states[pid]["error_message"]

        if st == "unrefuted":
            final_status = "EQ_EXEC" if (exec_res and exec_res.get("status") in ("EQ", "EMPTY_RESULT")) else (exec_res.get("status") if exec_res else "EQ_EXEC")
        else:
            final_status = st

        gold_res_str = ""
        pred_res_str = ""
        reproducible_cex_path = ""

        if exec_res:
            gold_res_str = str(exec_res.get("gold_sql_result", "")).replace('\n', '\\n')
            pred_res_str = str(exec_res.get("prediction_sql_result", "")).replace('\n', '\\n')
            if not err_msg:
                err_msg = exec_res.get("error_message", "")

            # If refuted (NEQ), save reproducible counterexample SQL file
            if final_status.startswith("NEQ") and ds_sql:
                try:
                    repro_cex_content = generate_reproducible_sql(
                        schema=ddl_content,
                        dataset=ds_sql,
                        gold_sql=gold_sql,
                        prediction_sql=pred_queries[pid],
                        dialect=dialect
                    )
                    cex_dir = os.path.join(results_dir, 'reproducible_cex', tool_prefix)
                    os.makedirs(cex_dir, exist_ok=True)
                    rel_path = f"reproducible_cex/{tool_prefix}/{safe_instance_id}_{pid}.sql"
                    with open(os.path.join(results_dir, rel_path), "w", encoding="utf-8") as rf:
                        rf.write(repro_cex_content)
                    reproducible_cex_path = rel_path
                except Exception:
                    pass

        eval_results.append({
            "instance_id": instance_id,
            "prediction_id": pid,
            "raw_tool_status": final_status,
            "EXTEST_STATUS": final_status,
            "reproducible_cex": reproducible_cex_path,
            "time_taken": round(gen_time, 4),
            "error_message": str(err_msg).replace('\n', ' ') if err_msg else "",
            "gold_sql_result": gold_res_str,
            "prediction_sql_result": pred_res_str,
            "num_datasets": len(datasets)
        })

    return eval_results, datagen_record


def main():
    parser = argparse.ArgumentParser(description="ParSEval-TDG: Single-Query Test Data Generator Evaluator")
    parser.add_argument('--benchmark', type=str, default='all', help="Benchmark to evaluate")
    parser.add_argument('--max-datasets', type=int, default=5, help="Number of datasets to generate per query")
    parser.add_argument('--resume', action='store_true', help="Resume from last saved item in CSV")
    parser.add_argument('--retry', action='store_true', help="Retry evaluation for failed/error cases")
    parser.add_argument('--target-dialect', type=str, default='sqlite', choices=['native', 'sqlite', 'mysql', 'postgresql'])
    parser.add_argument('--instance-id', type=str, default=None, help="Filter to specific instance ID")
    parser.add_argument('--input-file', type=str, default=None, help="Input queries JSON file")
    parser.add_argument('--results-dir', type=str, default=None, help="Output results directory")
    args = parser.parse_args()

    results_dir = os.path.abspath(args.results_dir) if args.results_dir else os.path.join(SCRIPT_DIR, 'results')
    os.makedirs(results_dir, exist_ok=True)

    input_file = args.input_file or os.environ.get('INPUT_FILE')
    data, loaded_schemas = benchmark_loader.load_benchmark_data(
        benchmark=args.benchmark,
        input_file=input_file,
        base_dir=SCRIPT_DIR
    )

    global SCHEMAS_DATA_GLOBAL
    if loaded_schemas:
        SCHEMAS_DATA_GLOBAL = loaded_schemas

    if not data:
        print(f"No queries found to evaluate for benchmark '{args.benchmark}'.")
        return

    if args.instance_id:
        data = [it for it in data if str(it.get('id') or it.get('instance_id')) == str(args.instance_id)]

    norm_bench = benchmark_loader.normalize_benchmark_name(args.benchmark)
    eval_csv_path = os.path.join(results_dir, f"parseval_tdg_{norm_bench}.csv")
    datagen_csv_path = os.path.join(results_dir, f"parseval_tdg_datagen_{norm_bench}.csv")

    eval_fieldnames = [
        'instance_id', 'prediction_id', 'raw_tool_status', 'EXTEST_STATUS',
        'reproducible_cex', 'time_taken', 'error_message',
        'gold_sql_result', 'prediction_sql_result', 'num_datasets'
    ]
    datagen_fieldnames = ['instance_id', 'query_id', 'query_type', 'data_gen_time', 'num_datasets', 'error_message']

    existing_records: Dict[str, Dict[str, str]] = {}
    if os.path.exists(eval_csv_path) and (args.resume or args.retry):
        with open(eval_csv_path, 'r', encoding='utf-8') as f:
            reader = csv.DictReader(f)
            for row in reader:
                pid = row.get('prediction_id')
                if pid:
                    existing_records[pid] = row

    print("=" * 70)
    print("ParSEval-TDG: Single-Query ParSEval Test Data Generation Evaluator")
    print(f"Output Directory: {results_dir}")
    print(f"Benchmark: {norm_bench}")
    print(f"Total instances: {len(data)}")
    print(f"Total prediction pairs: {sum(len(it.get('predictions', [])) for it in data)}")
    print("=" * 70)

    # Initialize CSV files if not exists
    if not os.path.exists(eval_csv_path) or not (args.resume or args.retry):
        with open(eval_csv_path, 'w', newline='', encoding='utf-8') as f:
            writer = csv.DictWriter(f, fieldnames=eval_fieldnames)
            writer.writeheader()

    if not os.path.exists(datagen_csv_path) or not (args.resume or args.retry):
        with open(datagen_csv_path, 'w', newline='', encoding='utf-8') as f:
            writer = csv.DictWriter(f, fieldnames=datagen_fieldnames)
            writer.writeheader()

    status_counter = Counter()

    with tqdm(total=sum(len(it.get('predictions', [])) for it in data), desc="Evaluating with ParSEval-TDG") as pbar:
        for item in data:
            results, dg_rec = process_instance(
                item=item,
                dialect='sqlite',
                max_datasets=args.max_datasets,
                results_dir=results_dir,
                tool_prefix="parseval_tdg",
                existing_records=existing_records,
                retry=args.retry
            )

            # Append datagen record
            with open(datagen_csv_path, 'a', newline='', encoding='utf-8') as f:
                writer = csv.DictWriter(f, fieldnames=datagen_fieldnames)
                writer.writerow(dg_rec)

            # Append evaluation records
            with open(eval_csv_path, 'a', newline='', encoding='utf-8') as f:
                writer = csv.DictWriter(f, fieldnames=eval_fieldnames)
                for res in results:
                    writer.writerow(res)
                    status_counter[res['EXTEST_STATUS']] += 1
                    pbar.set_postfix(**{k: v for k, v in status_counter.items() if k in ('NEQ', 'EQ_EXEC', 'ERROR')})
                    pbar.update(1)

    print("\nDone. All results saved in", results_dir)
    print(f"\n--- Status Statistics for {norm_bench.upper()} (ParSEval-TDG) ---")
    for st, count in status_counter.most_common():
        print(f"{st}: {count}")
    neq_count = sum(v for k, v in status_counter.items() if k.startswith('NEQ'))
    total_pairs = sum(status_counter.values())
    if total_pairs > 0:
        print(f"Refutation Rate (NEQ): {neq_count}/{total_pairs} ({neq_count/total_pairs*100:.1f}%)")


if __name__ == '__main__':
    main()
