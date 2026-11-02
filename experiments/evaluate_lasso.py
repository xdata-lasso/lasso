import json
import argparse
import os
import sys
import time
import csv
from collections import Counter
from timeout_utils import run_with_timeout
import csv_utils
import benchmark_loader

script_dir = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.abspath(os.path.join(script_dir, '../src')))
sys.path.insert(0, os.path.abspath(os.path.join(script_dir, '../sql-execution-tester')))

try:
    from main import generate_test_data_with_meta
except ImportError as e:
    print(f"Error importing modules: {e}")
    sys.exit(1)

schemas_data_global = benchmark_loader.get_schemas(base_dir=script_dir)

def get_ddl(database_id, dialect='sqlite'):
    if database_id in schemas_data_global:
        schema_entry = schemas_data_global[database_id]
        if dialect in ('postgres', 'postgresql'):
            return schema_entry.get("ddl_postgres") or schema_entry.get("ddl_postgresql") or schema_entry.get("ddl", "")
        return schema_entry.get("ddl", "")
    return ""

def is_base_dataset(ds):
    tags = getattr(ds, "tags", []) or []
    strategy_name = getattr(ds, "strategy_name", "") or ""
    return "base_dataset" in tags or "BaseDatasetStrategy" in strategy_name

def sort_base_first(datasets):
    base_ds = [ds for ds in datasets if is_base_dataset(ds)]
    other_ds = [ds for ds in datasets if not is_base_dataset(ds)]
    return base_ds + other_ds

def generate_test_data_with_timeout(ddl_content: str, query_sql: str, timeout_sec: int):
    """
    Executes generate_test_data_with_meta with a per-call timeout.
    """
    start_time = time.time()
    try:
        datasets, meta = run_with_timeout(generate_test_data_with_meta, timeout_sec, ddl_content, query_sql)
        return datasets, meta
    except TimeoutError:
        meta = {
            "data_gen_time": float(timeout_sec),
            "num_datasets": 0,
            "attack_strategies": "",
            "error_message": f"Timeout after {timeout_sec}s"
        }
        return [], meta
    except Exception as e:
        elapsed = time.time() - start_time
        meta = {
            "data_gen_time": elapsed,
            "num_datasets": 0,
            "attack_strategies": "",
            "error_message": str(e)
        }
        return [], meta

def log_datagen_start(query_label: str, query_sql: str):
    """
    Prints a concise one-line log before data generation starts.
    """
    clean_sql = " ".join(query_sql.strip().split())
    if len(clean_sql) > 80:
        clean_sql = clean_sql[:77] + "..."
    msg = f"[DataGen] Generating for {query_label}: {clean_sql}"
    try:
        from tqdm import tqdm
        tqdm.write(msg)
    except Exception:
        print(msg, flush=True)

def lasso_worker(ddl_content, gold_sql, prediction_queries, dialect, timeout=30, instance_id=None):
    """
    Unified Gold + Optimized N-Way Data Generation Worker.
    1. Generates test datasets for Gold query and tests all prediction queries.
    2. For any prediction query remaining unrefuted, executes optimized N-Way
       cross-mutant data generation: generates datasets for unrefuted mutants and
       batch-tests against all remaining unrefuted queries with early termination.
    Each data generation call is bounded by `timeout` seconds.
    """
    import contextlib
    from execution_tester import execution_test_batch

    datagen_records = []
    pred_states = {}
    pids = list(prediction_queries.keys())

    for pid in pids:
        pred_states[pid] = {
            "status": "unrefuted",
            "execution_result": None,
            "dataset_sql": "",
            "dataset_source": "",
            "dataset_strategy": "",
            "dataset_tags": "",
            "num_datasets": 0,
            "timeout": False,
            "error_message": ""
        }

    # 1. GOLD QUERY DATA GENERATION
    query_label = f"{instance_id} (gold)" if instance_id else "gold"
    log_datagen_start(query_label, gold_sql)
    gold_datasets, gold_meta = generate_test_data_with_timeout(ddl_content, gold_sql, timeout)
    gold_datasets = sort_base_first(gold_datasets)
    gold_meta["query_id"] = "gold"
    gold_meta["query_type"] = "gold"
    datagen_records.append(gold_meta)

    unrefuted_pids = list(pids)

    if not gold_meta.get("error_message"):
        for idx, dataset in enumerate(gold_datasets):
            if not unrefuted_pids:
                break

            dataset_sql = "\n".join(dataset.insert_statements)
            current_queries = [prediction_queries[pid] for pid in unrefuted_pids]

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
                status = res["status"]

                if not pred_states[pid]["execution_result"]:
                    pred_states[pid]["execution_result"] = res
                    pred_states[pid]["status"] = status
                    pred_states[pid]["dataset_sql"] = dataset_sql
                    pred_states[pid]["dataset_strategy"] = getattr(dataset, "strategy_name", "")
                    pred_states[pid]["dataset_tags"] = "; ".join(dataset.tags) if isinstance(getattr(dataset, "tags", None), list) else str(getattr(dataset, "tags", ""))
                    pred_states[pid]["num_datasets"] = len(gold_datasets)

                if status == "NEQ":
                    pred_states[pid]["status"] = status
                    pred_states[pid]["execution_result"] = res
                    pred_states[pid]["dataset_sql"] = dataset_sql
                    pred_states[pid]["dataset_source"] = "gold"
                    pred_states[pid]["dataset_strategy"] = getattr(dataset, "strategy_name", "")
                    pred_states[pid]["dataset_tags"] = "; ".join(dataset.tags) if isinstance(getattr(dataset, "tags", None), list) else str(getattr(dataset, "tags", ""))
                    pred_states[pid]["num_datasets"] = len(gold_datasets)
                elif status.startswith("NEQ"):
                    if not pred_states[pid]["status"].startswith("NEQ"):
                        pred_states[pid]["status"] = status
                        pred_states[pid]["execution_result"] = res
                        pred_states[pid]["dataset_sql"] = dataset_sql
                        pred_states[pid]["dataset_source"] = "gold"
                        pred_states[pid]["dataset_strategy"] = getattr(dataset, "strategy_name", "")
                        pred_states[pid]["dataset_tags"] = "; ".join(dataset.tags) if isinstance(getattr(dataset, "tags", None), list) else str(getattr(dataset, "tags", ""))
                        pred_states[pid]["num_datasets"] = len(gold_datasets)
                    still_unrefuted.append(pid)
                else:
                    if status.startswith("ERROR") and not pred_states[pid]["status"].startswith("NEQ"):
                        pred_states[pid]["status"] = status
                        pred_states[pid]["execution_result"] = res
                        pred_states[pid]["dataset_sql"] = dataset_sql
                        pred_states[pid]["dataset_source"] = "gold"
                        pred_states[pid]["dataset_strategy"] = getattr(dataset, "strategy_name", "")
                        pred_states[pid]["dataset_tags"] = "; ".join(dataset.tags) if isinstance(getattr(dataset, "tags", None), list) else str(getattr(dataset, "tags", ""))
                    still_unrefuted.append(pid)

            unrefuted_pids = still_unrefuted

    # 2. OPTIMIZED N-WAY DATA GENERATION FOR UNREFUTED QUERIES
    for pid in list(unrefuted_pids):
        if pid not in unrefuted_pids:
            continue

        pred_sql = prediction_queries[pid]
        query_label = pid if (instance_id and pid.startswith(str(instance_id))) else (f"{instance_id} ({pid})" if instance_id else pid)
        log_datagen_start(query_label, pred_sql)
        pred_datasets, pred_meta = generate_test_data_with_timeout(ddl_content, pred_sql, timeout)
        pred_datasets = sort_base_first(pred_datasets)
        pred_meta["query_id"] = pid
        pred_meta["query_type"] = "pred"
        datagen_records.append(pred_meta)

        if pred_meta.get("error_message"):
            if "Timeout after" in pred_meta["error_message"]:
                pred_states[pid]["timeout"] = True
                pred_states[pid]["error_message"] = pred_meta["error_message"]
            else:
                pred_states[pid]["error_message"] = pred_meta["error_message"]
            continue

        for idx, dataset in enumerate(pred_datasets):
            if not unrefuted_pids:
                break

            dataset_sql = "\n".join(dataset.insert_statements)
            current_queries = [prediction_queries[p] for p in unrefuted_pids]

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
                p = unrefuted_pids[i]
                status = res["status"]

                if not pred_states[p]["execution_result"]:
                    pred_states[p]["execution_result"] = res
                    pred_states[p]["status"] = status
                    pred_states[p]["dataset_sql"] = dataset_sql
                    pred_states[p]["dataset_source"] = "pred"
                    pred_states[p]["dataset_strategy"] = getattr(dataset, "strategy_name", "")
                    pred_states[p]["dataset_tags"] = "; ".join(dataset.tags) if isinstance(getattr(dataset, "tags", None), list) else str(getattr(dataset, "tags", ""))
                    pred_states[p]["num_datasets"] = len(pred_datasets)

                if status == "NEQ":
                    pred_states[p]["status"] = status
                    pred_states[p]["execution_result"] = res
                    pred_states[p]["dataset_sql"] = dataset_sql
                    pred_states[p]["dataset_source"] = "pred"
                    pred_states[p]["dataset_strategy"] = getattr(dataset, "strategy_name", "")
                    pred_states[p]["dataset_tags"] = "; ".join(dataset.tags) if isinstance(getattr(dataset, "tags", None), list) else str(getattr(dataset, "tags", ""))
                    pred_states[p]["num_datasets"] = len(pred_datasets)
                elif status.startswith("NEQ"):
                    if not pred_states[p]["status"].startswith("NEQ"):
                        pred_states[p]["status"] = status
                        pred_states[p]["execution_result"] = res
                        pred_states[p]["dataset_sql"] = dataset_sql
                        pred_states[p]["dataset_source"] = "pred"
                        pred_states[p]["dataset_strategy"] = getattr(dataset, "strategy_name", "")
                        pred_states[p]["dataset_tags"] = "; ".join(dataset.tags) if isinstance(getattr(dataset, "tags", None), list) else str(getattr(dataset, "tags", ""))
                        pred_states[p]["num_datasets"] = len(pred_datasets)
                    still_unrefuted.append(p)
                else:
                    if status.startswith("ERROR") and not pred_states[p]["status"].startswith("NEQ"):
                        pred_states[p]["status"] = status
                        pred_states[p]["execution_result"] = res
                        pred_states[p]["dataset_sql"] = dataset_sql
                        pred_states[p]["dataset_source"] = "pred"
                        pred_states[p]["dataset_strategy"] = getattr(dataset, "strategy_name", "")
                        pred_states[p]["dataset_tags"] = "; ".join(dataset.tags) if isinstance(getattr(dataset, "tags", None), list) else str(getattr(dataset, "tags", ""))
                    still_unrefuted.append(p)

            unrefuted_pids = still_unrefuted

    return {
        "predictions": pred_states,
        "datagen_records": datagen_records,
        "gold_meta": gold_meta
    }

def process_item(item, target_dialect='native', timeout=30, results_dir=None):
    db_id = item.get('schema_id', item.get('database_id'))
    dialect = target_dialect if target_dialect != 'native' else item.get('dialect', 'sqlite')
    exec_dialect = 'postgres' if dialect == 'postgresql' else dialect
    instance_id = str(item.get('id') or item.get('instance_id') or db_id)
    ddl_content = get_ddl(db_id, dialect=exec_dialect)
    base_dir = os.path.dirname(os.path.abspath(__file__))
    if results_dir is None:
        results_dir = csv_utils.get_results_dir(base_dir, dialect)
    
    if not ddl_content:
        out = []
        for pred in item.get('predictions', []):
            pred_id = pred['prediction_id']
            out.append({
                'instance_id': instance_id,
                'prediction_id': pred_id,
                'EXTEST_STATUS': 'SKIPPED_NO_DDL',
                'dataset_source': '',
                'dataset_strategy': '',
                'dataset_tags': '',
                'reproducible_cex': '',
                'error_message': 'Missing DDL',
                'gold_sql_result': '',
                'prediction_sql_result': '',
                'num_datasets': 0
            })
        return {"eval_results": out, "datagen_records": []}

    if dialect in ('postgres', 'postgresql'):
        gold_sql = item.get('gold_sql_postgresql') or item.get('gold_sql_postgres') or item.get('gold_sql')
    else:
        gold_sql = item.get(f'gold_sql_{dialect}', item.get(f'gold_sql_{exec_dialect}', item.get('gold_sql')))
    if not gold_sql:
        out = []
        for pred in item.get('predictions', []):
            pred_id = pred['prediction_id']
            out.append({
                'instance_id': instance_id,
                'prediction_id': pred_id,
                'EXTEST_STATUS': 'SKIPPED_NO_GOLD_SQL',
                'dataset_source': '',
                'dataset_strategy': '',
                'dataset_tags': '',
                'reproducible_cex': '',
                'error_message': 'Missing Gold SQL',
                'gold_sql_result': '',
                'prediction_sql_result': '',
                'num_datasets': 0
            })
        return {"eval_results": out, "datagen_records": []}
        
    prediction_queries = {}
    for pred in item.get('predictions', []):
        pred_id = pred['prediction_id']
        pred_sql = pred.get('prediction_sql')
        if dialect in ('postgres', 'postgresql'):
            pred_sql = pred.get('prediction_sql_postgresql') or pred.get('prediction_sql_postgres') or pred_sql
        else:
            pred_sql = pred.get(f'prediction_sql_{dialect}', pred.get(f'prediction_sql_{exec_dialect}', pred_sql))
        prediction_queries[pred_id] = pred_sql
        
    eval_results = {}
    datagen_records = []
    if prediction_queries:
        try:
            eval_results = lasso_worker(ddl_content, gold_sql, prediction_queries, exec_dialect, timeout=timeout, instance_id=instance_id)
            datagen_records = eval_results.get("datagen_records", [])
            for rec in datagen_records:
                rec["instance_id"] = instance_id
        except Exception:
            import traceback
            err_msg = traceback.format_exc()
            eval_results = {"predictions": {}, "global_error": err_msg}
            datagen_records = [{
                "instance_id": instance_id,
                "query_id": "gold",
                "query_type": "gold",
                "data_gen_time": 0.0,
                "num_datasets": 0,
                "attack_strategies": "",
                "error_message": err_msg
            }]
    else:
        eval_results = {"predictions": {}}
        
    gold_meta = eval_results.get("gold_meta", {})
    gold_timed_out = bool(gold_meta.get("error_message") and "Timeout after" in gold_meta["error_message"])

    out = []
    for pred in item.get('predictions', []):
        pred_id = pred['prediction_id']
        
        status_flag = "UNKNOWN"
        cex_str = ""
        gold_sql_result = ""
        prediction_sql_result = ""
        dataset_source = ""
        dataset_strategy = ""
        dataset_tags = ""
        reproducible_cex_path = ""
        num_datasets = 0
        
        if pred_id in eval_results.get("predictions", {}):
            pred_res = eval_results["predictions"][pred_id]
            exec_result = pred_res.get("execution_result")
            dataset_source = pred_res.get("dataset_source", "")
            dataset_strategy = pred_res.get("dataset_strategy", "")
            dataset_tags = pred_res.get("dataset_tags", "")
            num_datasets = pred_res.get("num_datasets", 0)
            
            if exec_result:
                status_val = exec_result.get("status", "")
                if status_val in ("EXTEST_ERROR", "ERROR") or str(status_val).startswith("ERROR_"):
                    status_flag = status_val if str(status_val).startswith("ERROR_") else "EXTEST_ERROR"
                    cex_str = exec_result.get("error_message", "Unknown execution error")
                else:
                    status_flag = status_val
                    if status_flag in ("NEQ", "NEQ_SCO"):
                        cex_str = pred_res.get("dataset_sql", "")
                        gold_sql_result = str(exec_result.get("gold_sql_result", ""))
                        prediction_sql_result = str(exec_result.get("prediction_sql_result", ""))
                        
                        reproducible_cex_content = exec_result.get("reproducible_cex", "")
                        if reproducible_cex_content:
                            cex_dir = os.path.join(results_dir, 'reproducible_cex', 'lasso_gold')
                            os.makedirs(cex_dir, exist_ok=True)
                            safe_instance_id = str(instance_id).replace('/', '_').replace('\\', '_')
                            rel_path = f"reproducible_cex/lasso_gold/{safe_instance_id}_{pred_id}.sql"
                            with open(os.path.join(results_dir, rel_path), "w", encoding="utf-8") as rf:
                                rf.write(reproducible_cex_content)
                            reproducible_cex_path = rel_path
            else:
                if pred_res.get("timeout") or (gold_timed_out and not pred_res.get("execution_result")):
                    status_flag = "TIMEOUT"
                    cex_str = pred_res.get("error_message") or gold_meta.get("error_message") or f"Timeout after {timeout}s"
                elif pred_res.get("error_message"):
                    status_flag = "TOOL_ERROR"
                    cex_str = pred_res.get("error_message")
                elif gold_meta.get("error_message"):
                    status_flag = "TOOL_ERROR"
                    cex_str = gold_meta.get("error_message")
                else:
                    status_flag = "NO_CEX"
                    cex_str = "No test datasets generated"
        elif "global_error" in eval_results:
            err_msg = eval_results["global_error"]
            if "Timeout after" in err_msg:
                status_flag = "TIMEOUT"
            else:
                status_flag = "TOOL_ERROR"
            cex_str = err_msg
        else:
            status_flag = "SKIPPED"
            cex_str = "Not evaluated"
                
        safe_instance_id = str(instance_id).replace('/', '_').replace('\\', '_')
        
        error_msg_val = cex_str if status_flag in ['TOOL_ERROR', 'TIMEOUT', 'ERROR_QUERY_EXECUTION', 'EXTEST_ERROR'] or str(status_flag).startswith('ERROR') else ''
        error_msg_path = ""
        
        if error_msg_val:
            error_msg_dir = os.path.join(results_dir, 'error_msg', 'lasso_gold')
            os.makedirs(error_msg_dir, exist_ok=True)
            rel_path = f"error_msg/lasso_gold/{safe_instance_id}_{pred_id}.txt"
            with open(os.path.join(results_dir, rel_path), "w", encoding="utf-8") as rf:
                rf.write(error_msg_val)
            error_msg_path = rel_path

        out.append({
            'instance_id': instance_id,
            'prediction_id': pred_id,
            'EXTEST_STATUS': status_flag,
            'dataset_source': dataset_source,
            'dataset_strategy': dataset_strategy,
            'dataset_tags': dataset_tags,
            'reproducible_cex': reproducible_cex_path,
            'error_message': error_msg_path,
            'gold_sql_result': gold_sql_result,
            'prediction_sql_result': prediction_sql_result,
            'num_datasets': num_datasets
        })
    return {"eval_results": out, "datagen_records": datagen_records}

def main():
    parser = argparse.ArgumentParser(description="Evaluate Lasso Test Data Generator")
    parser.add_argument('--benchmark', type=str, default='all', help='Benchmark to evaluate (e.g. bird, spider, xdata)')
    parser.add_argument('--resume', action='store_true', help='Resume from last saved item in csv')
    parser.add_argument('--retry', action='store_true', help='Retry evaluation for failed/error cases in existing CSV')
    parser.add_argument('--target-dialect', '--dialect', type=str, default='native', choices=['native', 'sqlite', 'mysql', 'postgresql', 'postgres'], help='Target dialect to use for queries')
    parser.add_argument('--timeout', type=int, default=30, help='Timeout in seconds per data generation call (default: 30)')
    parser.add_argument('--instance-id', type=str, default=None, help='Filter evaluation to a specific instance ID')
    parser.add_argument('--prediction-id', type=str, default=None, help='Filter evaluation to a specific prediction ID')
    parser.add_argument('--input-file', type=str, default=None, help='Input JSON file')
    args = parser.parse_args()

    results_dir = csv_utils.get_results_dir(script_dir, args.target_dialect)
    os.makedirs(results_dir, exist_ok=True)

    input_file = args.input_file or os.environ.get('INPUT_FILE')
    data, loaded_schemas = benchmark_loader.load_benchmark_data(
        benchmark=args.benchmark,
        input_file=input_file,
        base_dir=script_dir
    )
    global schemas_data_global
    if loaded_schemas:
        schemas_data_global = loaded_schemas

    if not data:
        print(f"No queries found to evaluate for benchmark '{args.benchmark}'.")
        return

    unique_sources = set(item.get('source', 'unknown') for item in data)

    fieldnames = ['instance_id', 'prediction_id', 'EXTEST_STATUS', 'dataset_source', 'dataset_strategy', 'dataset_tags', 'reproducible_cex', 'error_message', 'gold_sql_result', 'prediction_sql_result', 'num_datasets']
    datagen_fieldnames = ['instance_id', 'query_id', 'query_type', 'data_gen_time', 'num_datasets', 'attack_strategies', 'error_message']

    for src in unique_sources:
        out_csv = os.path.join(results_dir, f'lasso_{src}.csv')
        mode = 'a' if ((args.resume or args.retry) and os.path.exists(out_csv)) else 'w'
        with open(out_csv, mode, newline='', encoding='utf-8') as f:
            writer = csv.DictWriter(f, fieldnames=fieldnames)
            if mode == 'w' or os.path.getsize(out_csv) == 0:
                writer.writeheader()

        datagen_csv = os.path.join(results_dir, f'lasso_datagen_{src}.csv')
        mode_dg = 'a' if ((args.resume or args.retry) and os.path.exists(datagen_csv)) else 'w'
        with open(datagen_csv, mode_dg, newline='', encoding='utf-8') as f:
            writer = csv.DictWriter(f, fieldnames=datagen_fieldnames)
            if mode_dg == 'w' or os.path.getsize(datagen_csv) == 0:
                writer.writeheader()

    data, total_predictions = csv_utils.filter_predictions_for_evaluation(
        data=data,
        results_dir=results_dir,
        csv_file_func=lambda src: os.path.join(results_dir, f'lasso_{src}.csv'),
        resume=args.resume,
        retry=args.retry,
        target_instance_id=args.instance_id,
        target_prediction_id=args.prediction_id,
        tool_name="Lasso"
    )
    print(f"Loaded {len(data)} items to process with Lasso. Total predictions: {total_predictions}")
    
    status_counts = Counter()
    source_counts = Counter()
    from tqdm import tqdm

    last_status = [None]
    with tqdm(total=total_predictions, desc="Evaluating Predictions") as pbar:
        for item in data:
            try:
                item_output = process_item(item, args.target_dialect, args.timeout, results_dir=results_dir)
                eval_results = item_output.get("eval_results", [])
                datagen_recs = item_output.get("datagen_records", [])

                src = item.get('source', 'unknown')
                out_csv = os.path.join(results_dir, f'lasso_{src}.csv')
                datagen_csv = os.path.join(results_dir, f'lasso_datagen_{src}.csv')

                for res in eval_results:
                    status_counts[res.get('EXTEST_STATUS', 'UNKNOWN')] += 1
                    ds_src = res.get('dataset_source', '')
                    if ds_src:
                        source_counts[ds_src] += 1

                csv_utils.update_or_append_results(out_csv, fieldnames, eval_results)
                if datagen_recs:
                    csv_utils.update_or_append_results(datagen_csv, datagen_fieldnames, datagen_recs)
                csv_utils.print_status_update(pbar, status_counts, last_status)
            except KeyboardInterrupt:
                pbar.write("\nInterrupted by user. Saving partial results...")
                break
            except Exception as e:
                pbar.write(f"Error processing item: {e}")

            pbar.update(len(item.get('predictions', [])))

    print(f"Done. Results saved in {results_dir}")
    
    for src in unique_sources:
        out_csv = os.path.join(results_dir, f'lasso_{src}.csv')
        datagen_csv = os.path.join(results_dir, f'lasso_datagen_{src}.csv')
        csv_utils.deduplicate_csv(out_csv, fieldnames)
        csv_utils.deduplicate_datagen_csv(datagen_csv, datagen_fieldnames)
    
    for src in unique_sources:
        print(f"\n--- Status Statistics for {src} ---")
        try:
            out_csv = os.path.join(results_dir, f'lasso_{src}.csv')
            with open(out_csv, 'r', encoding='utf-8') as f:
                reader = csv.DictReader(f)
                rows = list(reader)
                counts = Counter(row.get('EXTEST_STATUS', 'UNKNOWN') for row in rows)
                ds_counts = Counter(row.get('dataset_source', '') for row in rows if row.get('dataset_source'))
                for status, count in counts.most_common():
                    print(f"{status}: {count}")
                print(f"Killed by Gold Datasets: {ds_counts.get('gold', 0)}")
                print(f"Killed by Pred Datasets (TW): {ds_counts.get('pred', 0)}")
            
            err_counts = csv_utils.get_error_histogram(out_csv, results_dir, "ERROR_QUERY_EXECUTION")
            csv_utils.print_error_histogram(err_counts, f"Top 5 ERROR_QUERY_EXECUTION Errors for {src}", top_n=5)
        except Exception as e:
            print(f"Could not print statistics: {e}")



if __name__ == '__main__':
    main()
