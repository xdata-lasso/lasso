import json
import argparse
import os
import sys
import time
import sqlite3
import csv
import uuid
import contextlib
from collections import Counter
from tqdm import tqdm
from timeout_utils import run_with_timeout
import csv_utils
import benchmark_loader

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
parseval_src = os.path.join(BASE_DIR, 'originals', 'ParSEval', 'src')
if not os.path.exists(parseval_src):
    parseval_src = os.path.join(BASE_DIR, 'ParSEval', 'src')
sys.path.append(os.path.abspath(parseval_src))
sys.path.append(os.path.abspath(os.path.join(BASE_DIR, '../sql-execution-tester')))

try:
    from execution_tester import execution_test
    from query_normalizer import normalize_sql
except ImportError as e:
    print(f"Error importing execution_test/query_normalizer: {e}")
    sys.exit(1)

try:
    from parseval.disprover import Disprover
    from parseval.states import Semantics, Verdict
except ImportError as e:
    print(f"Error importing ParSEval components: {e}")
    sys.exit(1)

schemas_data_global = benchmark_loader.get_schemas(base_dir=BASE_DIR)

def get_ddl(database_id):
    if database_id in schemas_data_global:
        return schemas_data_global[database_id].get("ddl", "")
    return ""

def parseval_worker(gold_sql, pred_sql, ddl_content, parseval_dialect, connection_string):
    disprover = Disprover(
        sql1=gold_sql,
        sql2=pred_sql,
        schema=ddl_content,
        dialect=parseval_dialect,
        connection_string=connection_string,
        semantics='bag',
    )
    with open(os.devnull, 'w') as f, contextlib.redirect_stdout(f):
        return disprover.disprove()

def process_item(item):
    db_id = item.get('schema_id', item.get('database_id'))
    dialect = 'sqlite'
    gold_sql = item['gold_sql']
    instance_id = str(item.get('id') or item.get('instance_id') or db_id)
    ddl_content = get_ddl(db_id)
    
    if not ddl_content:


        # quick filter
        # although already handled in build benchmarks
        for pred in item['predictions']:
            status = pred.get('status')
            is_update = gold_sql.strip().upper().startswith('UPDATE') or pred.get('prediction_sql', '').strip().upper().startswith('UPDATE')
            
            if status == 'EQ':
                final_status = 'EQ'
            elif is_update:
                final_status = 'SKIPPED_UPDATE_QUERY'
            else:
                final_status = 'SKIPPED_NO_DDL'
                
            yield {
                'instance_id': instance_id,
                'prediction_id': pred['prediction_id'],
                'raw_tool_status': final_status,
                'EXTEST_STATUS': final_status,
                'time_taken': 0,
                'error_message': '',
                'gold_sql_result': '',
                'prediction_sql_result': '',
                'num_datasets': 0,
                'reproducible_cex': ''
            }
        return
        
    
    gold_sql = item.get(f'gold_sql_{dialect}', item.get('gold_sql'))
        
    for pred in item['predictions']:
        pred_id = pred['prediction_id']
        pred_sql = pred['prediction_sql']
        
        is_update = gold_sql.strip().upper().startswith('UPDATE') or pred_sql.strip().upper().startswith('UPDATE')
        
        # this also should be already elimnated from build benchmarks
        if pred.get('status') == 'EQ':
            yield {
                'instance_id': instance_id,
                'prediction_id': pred_id,
                'raw_tool_status': 'EQ',
                'EXTEST_STATUS': 'EQ',
                'time_taken': 0,
                'error_message': '',
                'gold_sql_result': '',
                'prediction_sql_result': '',
                'num_datasets': 0,
                'reproducible_cex': ''
            }
            continue
            
        # this too may never run, as we filter this out during benchmarking
        if is_update:
            yield {
                'instance_id': instance_id,
                'prediction_id': pred_id,
                'raw_tool_status': 'SKIPPED_UPDATE_QUERY',
                'EXTEST_STATUS': 'SKIPPED_UPDATE_QUERY',
                'time_taken': 0,
                'error_message': '',
                'gold_sql_result': '',
                'prediction_sql_result': '',
                'num_datasets': 0,
                'reproducible_cex': ''
            }
            continue
            
        pred_sql = pred.get(f'prediction_sql_{dialect}', pred_sql)
            
        status_flag = "UNKNOWN"
        cex_str = ""
        gold_sql_result = ""
        prediction_sql_result = ""
        reproducible_cex_path = ""
        total_time = 0
        
        db_context = None
        # parseval requires a sqlite db created from outsite. lets create temporary unique db.
        db_path = f"/tmp/parseval_{db_id}_{uuid.uuid4().hex}.db"
        connection_string = ""
        
        if dialect == 'sqlite':
            connection_string = f"sqlite:///{db_path}"
            db_path_q2 = db_path.replace(".db", "_q2.db")
            if os.path.exists(db_path):
                os.remove(db_path)
            if os.path.exists(db_path_q2):
                os.remove(db_path_q2)
        
        start_time = time.time()
        
        try:         
            res = run_with_timeout(parseval_worker, 30, gold_sql, pred_sql, ddl_content, "sqlite", connection_string)
            data_gen_time = getattr(res, 'data_gen_time', getattr(res.generation, 'elapsed_time', 0.0))
            
            if res.verdict == Verdict.NEQ:
                raw_tool_status = "NEQ"
                cex_str = res.dataset_sql
                status_flag = raw_tool_status

                # now verify with execution_test
                if cex_str:
                    try:
                        exec_res = execution_test(
                            schema=ddl_content,
                            dataset=cex_str,
                            gold_sql=gold_sql,
                            prediction_sql=pred_sql,
                            dialect=dialect
                        )
                        status_val = exec_res.get("status", "")
                        if status_val in ("EXTEST_ERROR", "ERROR") or str(status_val).startswith("ERROR_"):
                            status_flag = status_val if str(status_val).startswith("ERROR_") else "EXTEST_ERROR"
                            cex_str = str(exec_res.get("error_message", "Unknown execution error")).replace('\n', '\\n')
                        else:
                            status_flag = status_val
                            gold_sql_result = str(exec_res.get("gold_sql_result", "")).replace('\n', '\\n')
                            prediction_sql_result = str(exec_res.get("prediction_sql_result", "")).replace('\n', '\\n')
                            
                        reproducible_cex_content = exec_res.get("reproducible_cex", "")
                        if reproducible_cex_content:
                            base_dir = os.path.dirname(os.path.abspath(__file__))
                            results_dir = os.path.join(base_dir, 'results')
                            cex_dir = os.path.join(results_dir, 'reproducible_cex', 'parseval')
                            os.makedirs(cex_dir, exist_ok=True)
                            safe_instance_id = str(instance_id).replace('/', '_').replace('\\', '_')
                            rel_path = f"reproducible_cex/parseval/{safe_instance_id}_{pred_id}.sql"
                            with open(os.path.join(results_dir, rel_path), "w", encoding="utf-8") as rf:
                                rf.write(reproducible_cex_content)
                            reproducible_cex_path = rel_path
                    except Exception as e:
                        status_flag = "ERROR_QUERY_EXECUTION"
                else:
                    status_flag = "NO_CEX"
                    cex_str = "No counterexample provided by Parseval"
            elif res.verdict == Verdict.EQ:
                raw_tool_status = "EQ"
                status_flag = "EQ"
            else:
                raw_tool_status = "TOOL_ERROR"
                status_flag = "TOOL_ERROR"
                if hasattr(res, 'error_msg') and res.error_msg:
                    cex_str = res.error_msg
                
        except TimeoutError:
            raw_tool_status = "TIMEOUT"
            status_flag = "TIMEOUT"
            data_gen_time = 30.0
            cex_str = "Timeout after 30s"
        except Exception as e:
            raw_tool_status = "TOOL_ERROR"
            status_flag = "TOOL_ERROR"
            data_gen_time = time.time() - start_time
            err_msg = str(e).strip() if str(e).strip() else f"{type(e).__name__}: {repr(e)}"
            cex_str = err_msg
        finally:
            if db_context:
                db_context.close()
            
        if dialect == 'sqlite':
            if os.path.exists(db_path):
                os.remove(db_path)
            if os.path.exists(db_path_q2):
                os.remove(db_path_q2)
            
        if cex_str:
            if "Both queries returned empty results - cannot prove equivalence" in cex_str:
                status_flag = "EQ_EXEC"
            elif "pymysql.err.ProgrammingError" in cex_str:
                status_flag = "ERROR_SYNTAX"

        base_dir = os.path.dirname(os.path.abspath(__file__))
        results_dir = os.path.join(base_dir, 'results')
        safe_instance_id = str(instance_id).replace('/', '_').replace('\\', '_')
        
        error_msg_val = cex_str if status_flag in ['TOOL_ERROR', 'TIMEOUT', 'ERROR_QUERY_EXECUTION', 'EXTEST_ERROR'] or str(status_flag).startswith('ERROR') else ''
        error_msg_path = ""
        
        if error_msg_val:
            error_msg_dir = os.path.join(results_dir, 'error_msg', 'parseval')
            os.makedirs(error_msg_dir, exist_ok=True)
            rel_path = f"error_msg/parseval/{safe_instance_id}_{pred_id}.txt"
            with open(os.path.join(results_dir, rel_path), "w", encoding="utf-8") as rf:
                rf.write(error_msg_val)
            error_msg_path = rel_path

        yield {
            'instance_id': instance_id,
            'prediction_id': pred_id,
            'raw_tool_status': raw_tool_status,
            'EXTEST_STATUS': status_flag,
            'time_taken': f"{data_gen_time:.3f}" if isinstance(data_gen_time, (int, float)) else str(data_gen_time),
            'error_message': error_msg_path,
            'gold_sql_result': gold_sql_result,
            'prediction_sql_result': prediction_sql_result,
            'num_datasets': 1 if raw_tool_status == "NEQ" else 0,
            'reproducible_cex': reproducible_cex_path
        }

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--benchmark', type=str, default='all', help='Benchmark to evaluate (e.g. bird, spider)')
    parser.add_argument('--resume', action='store_true', help='Resume from last saved item in csv')
    parser.add_argument('--retry', action='store_true', help='Retry evaluation for failed/error cases in existing CSV')
    parser.add_argument('--target-dialect', type=str, default='sqlite', choices=['native', 'sqlite', 'mysql', 'postgresql'], help='Target dialect to use for queries')
    parser.add_argument('--instance-id', type=str, default=None, help='Filter evaluation to a specific instance ID')
    parser.add_argument('--prediction-id', type=str, default=None, help='Filter evaluation to a specific prediction ID')
    parser.add_argument('--input-file', type=str, default=None, help='Input JSON file')
    args = parser.parse_args()

    results_dir = os.path.join(BASE_DIR, 'results')
    os.makedirs(results_dir, exist_ok=True)

    data, loaded_schemas = benchmark_loader.load_benchmark_data(
        benchmark=args.benchmark,
        input_file=args.input_file or os.environ.get('INPUT_FILE'),
        base_dir=BASE_DIR
    )
    global schemas_data_global
    if loaded_schemas:
        schemas_data_global = loaded_schemas

    if not data:
        print(f"No queries found to evaluate for benchmark '{args.benchmark}'.")
        return

    print(f"Loaded {len(data)} items to process with ParSEval.")
    
    unique_sources = set(item.get('source', 'unknown') for item in data)
    fieldnames = ['instance_id', 'prediction_id', 'raw_tool_status', 'EXTEST_STATUS', 'reproducible_cex', 'time_taken', 'error_message', 'gold_sql_result', 'prediction_sql_result', 'num_datasets']
    
    for src in unique_sources:
        out_csv = os.path.join(results_dir, f'parseval_{src}.csv')
        mode = 'a' if ((args.resume or args.retry) and os.path.exists(out_csv)) else 'w'
        with open(out_csv, mode, newline='', encoding='utf-8') as f:
            writer = csv.DictWriter(f, fieldnames=fieldnames)
            if mode == 'w' or os.path.getsize(out_csv) == 0:
                writer.writeheader()
            
    data, total_predictions = csv_utils.filter_predictions_for_evaluation(
        data=data,
        results_dir=results_dir,
        csv_file_func=lambda src: os.path.join(results_dir, f'parseval_{src}.csv'),
        resume=args.resume,
        retry=args.retry,
        target_instance_id=args.instance_id,
        target_prediction_id=args.prediction_id,
        tool_name="ParSEval"
    )
    
    if args.target_dialect != 'native':
        for item in data:
            item['dialect'] = args.target_dialect

    print(f"Loaded {len(data)} items to process with ParSEval. Total predictions: {total_predictions}")

    if total_predictions == 0:
        print("Nothing to process.")
        return

    status_counts = Counter()
    last_status = [None]
    with tqdm(total=total_predictions, desc="Evaluating ParSEval") as pbar:
        for item in data:
            src = item.get('source', 'unknown')
            out_csv = os.path.join(results_dir, f'parseval_{src}.csv')
            try:
                for res in process_item(item):
                    status_counts[res.get('EXTEST_STATUS', 'UNKNOWN')] += 1
                    csv_utils.update_or_append_results(out_csv, fieldnames, [res])
                    csv_utils.print_status_update(pbar, status_counts, last_status)
                    pbar.update(1)
            except KeyboardInterrupt:
                pbar.write("\nInterrupted by user. Saving partial results...")
                break
            except Exception as e:
                pbar.write(f"Error processing item {item.get('instance_id')}: {e}")

    print(f"Done. Saved to {results_dir}")
    
    for src in unique_sources:
        out_csv = os.path.join(results_dir, f'parseval_{src}.csv')
        csv_utils.deduplicate_csv(out_csv, fieldnames)
        
    for src in unique_sources:
        print(f"\n--- Status Statistics (Total) for {src} ---")
        try:
            out_csv = os.path.join(results_dir, f'parseval_{src}.csv')
            with open(out_csv, 'r', encoding='utf-8') as f:
                reader = csv.DictReader(f)
                counts = Counter(row.get('EXTEST_STATUS', 'UNKNOWN') for row in reader)
                for status, count in counts.most_common():
                    print(f"{status}: {count}")
            
            err_counts = csv_utils.get_error_histogram(out_csv, results_dir, "ERROR_QUERY_EXECUTION")
            csv_utils.print_error_histogram(err_counts, f"Top 5 ERROR_QUERY_EXECUTION Errors for {src}", top_n=5)
        except Exception as e:
            print(f"Could not print statistics: {e}")

if __name__ == '__main__':
    main()
