import json
import os
import sys
import time
import csv
import re
import sqlite3
import argparse
from collections import Counter
from tqdm import tqdm
import sqlglot
from timeout_utils import run_with_timeout
import csv_utils
import benchmark_loader
import contextlib

script_dir = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.abspath(os.path.join(script_dir, '../polygon')))
sys.path.append(os.path.abspath(os.path.join(script_dir, '../sql-execution-tester')))

import logging
logging.getLogger("logger").setLevel(logging.CRITICAL)

try:
    from execution_tester import execution_test
    from query_normalizer import normalize_sql
except ImportError as e:
    print(f"Error importing execution_test/query_normalizer: {e}")
    sys.exit(1)

try:
    from polygon.environment import Environment
except ImportError as e:
    print(f"Error importing Environment: {e}")
    sys.exit(1)

def dict_to_inserts(cex_dict, schema_out):
    statements = []
    for table_info in schema_out:
        table_name = table_info["TableName"]
        rows = cex_dict.get(table_name.lower(), cex_dict.get(table_name, []))
        if not rows or len(rows) < 2:
            continue
            
        col_names = rows[0]
        table_data = rows[1:]
        cols_str = ", ".join(f'"{c}"' for c in col_names)
        
        for row in table_data:
            vals = []
            for val in row:
                if val is None:
                    vals.append('NULL')
                elif isinstance(val, str):
                    escaped = val.replace("'", "''")
                    vals.append(f"'{escaped}'")
                elif isinstance(val, bool):
                    vals.append('1' if val else '0')
                else:
                    vals.append(str(val))
            vals_str = ", ".join(vals)
            statements.append(f'INSERT INTO "{table_name}" ({cols_str}) VALUES ({vals_str});')
            
    return statements

schemas_data_global = benchmark_loader.get_schemas(base_dir=script_dir)

def get_polygon_schema_and_constraints(db_id):
    if db_id not in schemas_data_global:
        return [], []
    schema_info = schemas_data_global[db_id]
    poly_schema_data = schema_info.get("polygon_schema", {})
    poly_schema = poly_schema_data.get("Tables", [])
    poly_constraints = schema_info.get("polygon_constraints", [])
    return poly_schema, poly_constraints

def get_ddl(database_id):
    if database_id in schemas_data_global:
        return schemas_data_global[database_id].get("ddl", "")
    return ""

def get_env_config(source, item_id):
    if source == 'calcite':
        return 2, {k: 16 for k in ['filter', 'project', 'union', 'inner join', 'left join', 'right join', 'full join', 'product', 'order by']}
    elif source == 'literature':
        return 3, {k: 4 for k in ['filter', 'project', 'union', 'inner join', 'left join', 'right join', 'full join', 'product', 'order by']}
    elif source == 'leetcode':
        try:
            pid = int(str(item_id).replace('leetcode_', ''))
        except Exception:
            pid = -1
        bound = 2
        if pid in [619, 1050, 1398]:
            bound = 3
        if pid in [1661]:
            bound = 4
        if pid in [596, 1149]:
            bound = 5
        return bound, {
            'filter': 4, 'project': 4, 'union': 4, 'inner join': 4,
            'left join': 4, 'right join': 4, 'full join': 4, 'product': 4,
            'order by': 2
        }
    else: 
        return 2, {k: 4 for k in ['filter', 'project', 'union', 'inner join', 'left join', 'right join', 'full join', 'product', 'order by']}


def polygon_worker(schema_out, constraints_out, bound, default_k, gold_sql, pred_sql):
    import tempfile, logging, os
    from polygon.logger import logger
    
    tf = tempfile.NamedTemporaryFile(delete=False, suffix=".log")
    tf.close()
    
    handler = logging.FileHandler(tf.name)
    handler.setLevel(logging.ERROR)
    logger.addHandler(handler)
    
    try:
        from polygon.environment import Environment
        env = Environment(schema_out, constraints_out, bound=bound, default_k=default_k, time_budget=30)
        res = env.check(gold_sql, pred_sql, use_precise_encoding=False)
        eq, cex, checking_time, total_time, ret = res
        if ret and ret.get('status') == 'ERR':
            if os.path.exists(tf.name) and os.path.getsize(tf.name) > 0:
                with open(tf.name, 'r', encoding='utf-8', errors='replace') as rf:
                    content = rf.read().strip()
                if content:
                    lines = [ln.strip() for ln in content.split('\n') if ln.strip()]
                    ret['error'] = lines[-1] if lines else 'Polygon internal error'
        return eq, cex, checking_time, total_time, ret
    finally:
        logger.removeHandler(handler)
        if os.path.exists(tf.name):
            try:
                os.unlink(tf.name)
            except Exception:
                pass

def process_item(item, target_dialect='native'):
    db_id = item.get('schema_id', item.get('database_id'))
    dialect_polygon = 'mysql'
    dialect_extest = 'sqlite'
    gold_sql = item['gold_sql']
    source = item.get('source', '')
    instance_id = str(item.get('id') or item.get('instance_id') or db_id)
    ddl_content = get_ddl(db_id)
    schema_out, constraints_out = get_polygon_schema_and_constraints(db_id)
    
    if not schema_out:
        for idx, pred in enumerate(item.get('predictions', [])):
            pred_id = pred.get('prediction_id', f"pred_{idx}")
            final_status = 'SKIPPED_NO_DDL'
            yield {
                'instance_id': instance_id,
                'prediction_id': pred_id,
                'raw_tool_status': final_status,
                'EXTEST_STATUS': final_status,
                'time_taken': 0,
                'raw_counterexample': '',
                'error_message': 'Missing DDL or Schema' if final_status in ['SKIPPED_NO_DDL', 'TOOL_ERROR'] else '',
                'gold_sql_result': '',
                'prediction_sql_result': '',
                'reproducible_cex': ''
            }
        return
        
    gold_sql_poly = item.get(f'gold_sql_{dialect_polygon}', item.get('gold_sql'))
    gold_sql_extest = item.get(f'gold_sql_{dialect_extest}', item.get('gold_sql'))

    for idx, pred in enumerate(item.get('predictions', [])):
        pred_id = pred.get('prediction_id', f"pred_{idx}")
        pred_sql = pred.get('prediction_sql', '')
        
        pred_sql_poly = pred.get(f'prediction_sql_{dialect_polygon}', pred_sql)
        pred_sql_extest = pred.get(f'prediction_sql_{dialect_extest}', pred_sql)
            
        start_t = time.time()
        try:
            bound, default_k = get_env_config(source, instance_id)
            
            eq, cex, checking_time, total_time, ret = run_with_timeout(polygon_worker, 30, schema_out, constraints_out, bound, default_k, gold_sql_poly, pred_sql_poly)
            ret_status = ret.get('status', 'ERR')
            if total_time is None:
                total_time = time.time() - start_t
        except TimeoutError:
            ret_status = "TIMEOUT"
            cex = "Timeout after 30s"
            total_time = time.time() - start_t
        except Exception as e:
            ret_status = "TOOL_ERROR"
            cex = str(e)
            total_time = time.time() - start_t

        status_flag_validated = "TOOL_ERROR" if ret_status == "ERR" else ret_status
        if status_flag_validated == "TOOL_ERROR" and not cex:
            cex = ret.get('error', 'Polygon/Z3 solver failed (check z3 in PATH and solver compatibility)')
        converted_cex = ""
        raw_cex = json.dumps(cex, default=str) if isinstance(cex, dict) else str(cex) if cex else ""
        raw_cex = raw_cex.replace('\n', '\\n')
        gold_sql_result = ""
        prediction_sql_result = ""
        reproducible_cex_path = ""
        
        if ret_status == "NEQ" and isinstance(cex, dict):
            inserts = dict_to_inserts(cex, schema_out)
            converted_cex_exec = '\n'.join(inserts)
            converted_cex = ' '.join(inserts)
            try:
                with open(os.devnull, 'w') as devnull, contextlib.redirect_stdout(devnull):
                    exec_res = execution_test(
                        schema=ddl_content,
                        dataset=converted_cex_exec,
                        gold_sql=gold_sql_extest,
                        prediction_sql=pred_sql_extest,
                        dialect=dialect_extest
                    )
                if str(exec_res.get("status", "")).startswith("ERROR"):
                    status_flag_validated = exec_res.get("status")
                    converted_cex = str(exec_res.get("error_message", "Unknown validation error")).replace('\n', '\\n')
                else:
                    status_flag_validated = exec_res.get("status", "ERROR_QUERY_EXECUTION")
                    gold_sql_result = str(exec_res.get("gold_sql_result", "")).replace('\n', '\\n')
                    prediction_sql_result = str(exec_res.get("prediction_sql_result", "")).replace('\n', '\\n')
                    
                    reproducible_cex_content = exec_res.get("reproducible_cex", "")
                    if reproducible_cex_content:
                        base_dir = os.path.dirname(os.path.abspath(__file__))
                        results_dir = os.path.join(base_dir, 'results')
                        cex_dir = os.path.join(results_dir, 'reproducible_cex', 'polygon')
                        os.makedirs(cex_dir, exist_ok=True)
                        safe_instance_id = str(instance_id).replace('/', '_').replace('\\', '_')
                        rel_path = f"reproducible_cex/polygon/{safe_instance_id}_{pred_id}.sql"
                        with open(os.path.join(results_dir, rel_path), "w", encoding="utf-8") as rf:
                            rf.write(reproducible_cex_content)
                        reproducible_cex_path = rel_path
            except Exception as e:
                status_flag_validated = "ERROR_QUERY_EXECUTION"
                converted_cex = str(e).replace('\n', '\\n')
        elif ret_status == "NEQ":
            status_flag_validated = "NO_CEX"
            converted_cex = "No counterexample provided by Polygon"
                
        error_msg = ''
        if status_flag_validated in ['TOOL_ERROR', 'TIMEOUT', 'ERROR_QUERY_EXECUTION', 'EXTEST_ERROR'] or str(status_flag_validated).startswith('ERROR'):
            error_msg = converted_cex if ret_status == "NEQ" else raw_cex
            
        # Write large strings to files
        base_dir = os.path.dirname(os.path.abspath(__file__))
        results_dir = os.path.join(base_dir, 'results')
        safe_instance_id = str(instance_id).replace('/', '_').replace('\\', '_')
        
        raw_cex_path = ""
        if raw_cex:
            raw_cex_dir = os.path.join(results_dir, 'raw_cex', 'polygon')
            os.makedirs(raw_cex_dir, exist_ok=True)
            rel_path = f"raw_cex/polygon/{safe_instance_id}_{pred_id}.txt"
            with open(os.path.join(results_dir, rel_path), "w", encoding="utf-8") as rf:
                rf.write(raw_cex)
            raw_cex_path = rel_path
            
        error_msg_path = ""
        if error_msg:
            error_msg_dir = os.path.join(results_dir, 'error_msg', 'polygon')
            os.makedirs(error_msg_dir, exist_ok=True)
            rel_path = f"error_msg/polygon/{safe_instance_id}_{pred_id}.txt"
            with open(os.path.join(results_dir, rel_path), "w", encoding="utf-8") as rf:
                rf.write(error_msg)
            error_msg_path = rel_path

        yield {
            'instance_id': instance_id,
            'prediction_id': pred_id,
            'raw_tool_status': ret_status,
            'EXTEST_STATUS': status_flag_validated,
            'time_taken': total_time,
            'raw_counterexample': raw_cex_path,
            'error_message': error_msg_path,
            'gold_sql_result': gold_sql_result,
            'prediction_sql_result': prediction_sql_result,
            'reproducible_cex': reproducible_cex_path
        }

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--benchmark', nargs='+', default=['all'], help='Benchmark to evaluate')
    parser.add_argument('--resume', action='store_true', help='Resume from last saved item in csv')
    parser.add_argument('--retry', action='store_true', help='Retry evaluation for failed/error cases in existing CSV')
    parser.add_argument('--target-dialect', type=str, default='native', choices=['native', 'sqlite', 'mysql', 'postgresql'], help='Target dialect to use for queries')
    parser.add_argument('--instance-id', type=str, default=None, help='Filter evaluation to a specific instance ID')
    parser.add_argument('--prediction-id', type=str, default=None, help='Filter evaluation to a specific prediction ID')
    parser.add_argument('--input-file', type=str, default=None, help='Input JSON file')
    args = parser.parse_args()

    results_dir = os.path.join(script_dir, 'results')
    os.makedirs(results_dir, exist_ok=True)

    bench_arg = " ".join(args.benchmark) if isinstance(args.benchmark, list) else args.benchmark
    data, loaded_schemas = benchmark_loader.load_benchmark_data(
        benchmark=bench_arg,
        input_file=args.input_file or os.environ.get('INPUT_FILE'),
        base_dir=script_dir
    )
    global schemas_data_global
    if loaded_schemas:
        schemas_data_global = loaded_schemas

    if not data:
        print(f"No queries found to evaluate for benchmark '{bench_arg}'.")
        return

    unique_sources = set(item.get('source', 'unknown') for item in data)
    fieldnames = ['instance_id', 'prediction_id', 'raw_tool_status', 'EXTEST_STATUS', 'reproducible_cex', 'time_taken', 'raw_counterexample', 'error_message', 'gold_sql_result', 'prediction_sql_result']
    
    for src in unique_sources:
        out_csv = os.path.join(results_dir, f'polygon_{src}.csv')
        mode = 'a' if ((args.resume or args.retry) and os.path.exists(out_csv)) else 'w'
        with open(out_csv, mode, newline='', encoding='utf-8') as f:
            writer = csv.DictWriter(f, fieldnames=fieldnames)
            if mode == 'w' or os.path.getsize(out_csv) == 0:
                writer.writeheader()
            
    data, total_predictions = csv_utils.filter_predictions_for_evaluation(
        data=data,
        results_dir=results_dir,
        csv_file_func=lambda src: os.path.join(results_dir, f'polygon_{src}.csv'),
        resume=args.resume,
        retry=args.retry,
        target_instance_id=args.instance_id,
        target_prediction_id=args.prediction_id,
        tool_name="Polygon"
    )
    print(f"Loaded {len(data)} items to process with Polygon. Total predictions: {total_predictions}")
    
    if total_predictions == 0:
        print("Nothing to process.")
        return

    status_counts = Counter()
    last_status = [None]
    with tqdm(total=total_predictions, desc="Evaluating Polygon") as pbar:
        for item in data:
            src = item.get('source', 'unknown')
            output_csv_path = os.path.join(results_dir, f'polygon_{src}.csv')
            try:
                for res in process_item(item, args.target_dialect):
                    status_counts[res.get('EXTEST_STATUS', 'UNKNOWN')] += 1
                    csv_utils.update_or_append_results(output_csv_path, fieldnames, [res])
                    csv_utils.print_status_update(pbar, status_counts, last_status)
                    pbar.update(1)
            except KeyboardInterrupt:
                pbar.write("\nInterrupted by user. Saving partial results...")
                break
            except Exception as e:
                pbar.write(f"Error processing item: {e}")

    print(f"Done. Results saved to {results_dir}")
    
    for src in unique_sources:
        out_csv = os.path.join(results_dir, f'polygon_{src}.csv')
        csv_utils.deduplicate_csv(out_csv, fieldnames)
        
    for src in unique_sources:
        print(f"\n--- Status Statistics (Total) for {src} ---")
        try:
            output_csv_path = os.path.join(results_dir, f'polygon_{src}.csv')
            with open(output_csv_path, 'r', encoding='utf-8') as f:
                reader = csv.DictReader(f)
                counts = Counter(row.get('EXTEST_STATUS', 'UNKNOWN') for row in reader)
                for status, count in counts.most_common():
                    print(f"{status}: {count}")
            
            err_counts = csv_utils.get_error_histogram(output_csv_path, results_dir, "ERROR_QUERY_EXECUTION")
            csv_utils.print_error_histogram(err_counts, f"Top 5 ERROR_QUERY_EXECUTION Errors for {src}", top_n=5)

            tool_err_counts = csv_utils.get_error_histogram(output_csv_path, results_dir, "TOOL_ERROR")
            if tool_err_counts:
                csv_utils.print_error_histogram(tool_err_counts, f"Top 5 TOOL_ERROR Errors for {src}", top_n=5)
        except Exception as e:
            print(f"Could not print statistics: {e}")

if __name__ == '__main__':
    main()
