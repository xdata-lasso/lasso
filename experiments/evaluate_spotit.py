import json
import os
import sys
import time
import csv
import re
import argparse
import traceback
import sqlglot
import schema_translator
from collections import Counter
from tqdm import tqdm
import contextlib
import io
from timeout_utils import run_with_timeout
import csv_utils
import benchmark_loader

script_dir = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.abspath(os.path.join(script_dir, '../sql-execution-tester')))
SPOTIT_ROOT = os.path.join(script_dir, 'originals', 'SpotIt-plus') if os.path.exists(os.path.join(script_dir, 'originals', 'SpotIt-plus')) else os.path.join(script_dir, 'SpotIt-plus')
VERIEQL_ROOT = os.path.join(SPOTIT_ROOT, "verieql")
sys.path.insert(0, VERIEQL_ROOT)

import logging
logging.getLogger("logger").setLevel(logging.CRITICAL)

try:
    from execution_tester import execution_test
    from query_normalizer import normalize_sql
except ImportError as e:
    print(f"Error importing execution_test/query_normalizer: {e}")
    sys.exit(1)

from verieql import verify_sql_equivalence
from constants import DIALECT, DATE_SHIFT_PATTERN

def clean_up(generated_sql):
    def transform_backtick_content(match):
        content = match.group(1)
        content = content.upper().replace(' ', '_')
        content = re.sub(r'(\d+)-(\d+)', r'\1_\2', content)
        content = re.sub(r'([A-Z]+)-(\d+)', r'\1\2', content)
        content = content.replace('-', '_')
        content = re.sub(r'[^A-Z0-9_]', '', content)
        content = re.sub(r'_+', '_', content).strip('_')
        return f'"{content}"'

    pattern = r'`([^`]+)`'
    generated_sql = re.sub(pattern, transform_backtick_content, generated_sql)
    pattern = r'"([^"]+)"'
    generated_sql = re.sub(pattern, transform_backtick_content, generated_sql)
    return generated_sql

schemas_data_global = benchmark_loader.get_schemas(base_dir=script_dir)

def dict_to_inserts(cex_dict, schema_out):
    statements = []
    # schema_out in spotit is {table_name: [col_name, ...]}
    for table_name, columns in schema_out.items():
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

def transform_ddl_for_spotit(uir):
    return schema_translator.transform_ddl_for_spotit(uir)


def spotit_worker(pred_sql_clean, gold_sql_clean, spotit_schema, constraints_to_use, config):
    import os, contextlib
    from verieql import verify_sql_equivalence
    with open(os.devnull, 'w') as f, contextlib.redirect_stdout(f):
        return verify_sql_equivalence(pred_sql_clean, gold_sql_clean, spotit_schema, bound_size=2, constraints=constraints_to_use, **config)


def process_item_spotit(item, schemas_data_global, results_dir):
    import time
    import json
    import os
    import re
    from verieql import verify_sql_equivalence
    from constants import DIALECT, DATE_SHIFT_PATTERN
    import schema_translator
    from timeout_utils import run_with_timeout

    db_id = item.get('schema_id', item.get('database_id'))
    dialect = 'sqlite'
    gold_sql = item['gold_sql']
    instance_id = str(item.get('id') or item.get('instance_id') or db_id)
    source = item.get('source', '')
    
    schema_info = schemas_data_global.get(db_id, {})
    spotit_schema = schema_info.get("spotit_schema")
    constraints_to_use = schema_info.get("spotit_constraints", [])
    spotit_ddl = schema_info.get("spotit_ddl")
    
    # Fallback to runtime DDL parsing only if pre-computed fields are missing
    if not spotit_schema and schema_info.get("ddl"):
        uir = schema_translator.parse_ddl_to_uir(schema_info["ddl"])
        spotit_schema, constraints_to_use = schema_translator.uir_to_spotit_format(uir)
        spotit_ddl = transform_ddl_for_spotit(uir)
            
    if not spotit_schema:
        for idx, pred in enumerate(item.get('predictions', [])):
            pred_id = str(pred.get('prediction_id', f"pred_{idx}"))
            final_status = 'SKIPPED_NO_DDL'
            yield {
                'instance_id': instance_id, 'prediction_id': pred_id,
                'raw_tool_status': final_status, 'EXTEST_STATUS': final_status,
                'time_taken': 0, 'raw_counterexample': '', 'error_message': 'Missing DDL',
                'gold_sql_result': '', 'prediction_sql_result': '', 'reproducible_cex': ''
            }
        return

    gold_sql_spotit = item.get('gold_sql_spotit') or item.get('gold_sql_sqlite') or item.get('gold_sql', '')
    gold_sql_exec = gold_sql_spotit

    for idx, pred in enumerate(item.get('predictions', [])):
        pred_id = str(pred.get('prediction_id', f"pred_{idx}"))
        pred_sql_spotit = pred.get('prediction_sql_spotit') or pred.get('prediction_sql_sqlite') or pred.get('prediction_sql', '')
        pred_sql_exec = pred_sql_spotit
        
        # Quote reserved SQL keywords used as table names so mo_sql_parsing/SpotIt does not crash
        KW_TABLE_REGEX = re.compile(r"\b(FROM|JOIN|INTO)\s+(ORDER|GROUP|USER|TRANSACTION|KEY|PLAN|CHECK)\b(?!\s+BY\b)", re.IGNORECASE)
        KW_DOT_REGEX = re.compile(r"\b(ORDER|GROUP|USER|TRANSACTION|KEY|PLAN|CHECK)\.", re.IGNORECASE)
        safe_pred_sql_spotit = KW_TABLE_REGEX.sub(lambda m: f'{m.group(1)} "{m.group(2).upper()}"', pred_sql_spotit)
        safe_pred_sql_spotit = KW_DOT_REGEX.sub(lambda m: f'"{m.group(1).upper()}".', safe_pred_sql_spotit)
        safe_gold_sql_spotit = KW_TABLE_REGEX.sub(lambda m: f'{m.group(1)} "{m.group(2).upper()}"', gold_sql_spotit)
        safe_gold_sql_spotit = KW_DOT_REGEX.sub(lambda m: f'"{m.group(1).upper()}".', safe_gold_sql_spotit)

        config = {
            'generate_code': True, 
            'timer': True, 
            'show_counterexample': True, 
            'dialect': DIALECT.MYSQL,
            "all_null_is_deleted": True, 
        }
        
        if pred.get("spotit_config"):
            config.update(pred["spotit_config"])
        else:
            DATE_KEYS = [
                "STRFTIME", "JULIANDAY", "DATE_FORMAT", "DATEDIFF", 
                "DATE_ADD", "DATE_SUB", "CURDATE", "CURRENT_DATE", 
                "CURRENT_TIMESTAMP", "NOW"
            ]
            config["encode_date"] = any(
                any(map(lambda q: key in str.upper(q), [safe_pred_sql_spotit, safe_gold_sql_spotit])) for key in DATE_KEYS) or \
                any(re.search(DATE_SHIFT_PATTERN, str.upper(sql)) is not None for sql in [safe_pred_sql_spotit, safe_gold_sql_spotit])
            STRING_KEYS = [" LIKE ", "SUBSTR", "||"]
            config["encode_string"] = any(
                any(map(lambda q: key in str.upper(q), [safe_pred_sql_spotit, safe_gold_sql_spotit])) for key in STRING_KEYS) or config["encode_date"]

        start_t = time.time()
        
        try:
            vr = run_with_timeout(spotit_worker, 30, safe_pred_sql_spotit, safe_gold_sql_spotit, spotit_schema, constraints_to_use, config)
            raw_status = 'EQ' if vr['equivalent'] else 'NEQ'
            time_cost = vr.get('time_cost')
            if time_cost is None:
                time_cost = time.time() - start_t
            cex = vr.get('counterexample', None)
        except TimeoutError:
            raw_status = 'TIMEOUT'
            time_cost = time.time() - start_t
            cex = "Timeout after 30s"
        except Exception as e:
            if "Please set `encode_date = True`" in str(e) and not config.get("encode_date"):
                try:
                    retry_config = dict(config)
                    retry_config["encode_date"] = True
                    retry_config["encode_string"] = True
                    vr = run_with_timeout(spotit_worker, 30, safe_pred_sql_spotit, safe_gold_sql_spotit, spotit_schema, constraints_to_use, retry_config)
                    raw_status = 'EQ' if vr['equivalent'] else 'NEQ'
                    time_cost = vr.get('time_cost')
                    if time_cost is None:
                        time_cost = time.time() - start_t
                    cex = vr.get('counterexample', None)
                except TimeoutError:
                    raw_status = 'TIMEOUT'
                    time_cost = time.time() - start_t
                    cex = "Timeout after 30s"
                except Exception as e2:
                    raw_status = 'TOOL_ERROR'
                    time_cost = time.time() - start_t
                    cex = str(e2)
            else:
                raw_status = 'TOOL_ERROR'
                time_cost = time.time() - start_t
                cex = str(e)
            
        status_flag_validated = raw_status
        converted_cex = ""
        raw_cex = cex if isinstance(cex, str) else (json.dumps(cex, default=str) if cex is not None else "")
        raw_cex = raw_cex.replace('\n', '\\n')
        gold_sql_result = ""
        prediction_sql_result = ""
        reproducible_cex_path = ""
        
        if raw_status == 'NEQ' and cex is not None:
            try:
                if isinstance(cex, str):
                    inserts = [stmt.strip() + ';' for stmt in cex.split(';') if stmt.strip().upper().startswith('INSERT')]
                else:
                    cex_dict = cex
                    inserts = dict_to_inserts(cex_dict, spotit_schema)
                    
                if inserts:
                    converted_cex_exec = '\n'.join(inserts)
                    converted_cex = ' '.join(inserts)
                    
                    schema_to_exec = spotit_ddl if spotit_ddl else (transform_ddl_for_spotit(uir) if 'uir' in locals() else "")
                    exec_res = execution_test(
                        schema=schema_to_exec,
                        dataset=converted_cex_exec,
                        gold_sql=gold_sql_exec,
                        prediction_sql=pred_sql_exec,
                        dialect=dialect
                    )
                    status_val = exec_res.get("status", "")
                    if status_val in ("EXTEST_ERROR", "ERROR") or str(status_val).startswith("ERROR_"):
                        status_flag_validated = status_val if str(status_val).startswith("ERROR_") else "EXTEST_ERROR"
                        converted_cex = str(exec_res.get("error_message", "Unknown execution error")).replace('\n', '\\n')
                    else:
                        status_flag_validated = status_val
                        gold_sql_result = str(exec_res.get("gold_sql_result", "")).replace('\n', '\\n')
                        prediction_sql_result = str(exec_res.get("prediction_sql_result", "")).replace('\n', '\\n')
                        
                    reproducible_cex_content = exec_res.get("reproducible_cex", "")
                    if reproducible_cex_content:
                        cex_dir = os.path.join(results_dir, 'reproducible_cex', 'spotit')
                        os.makedirs(cex_dir, exist_ok=True)
                        safe_instance_id = str(instance_id).replace('/', '_').replace('\\', '_')
                        rel_path = f"reproducible_cex/spotit/{safe_instance_id}_{pred_id}.sql"
                        with open(os.path.join(results_dir, rel_path), "w", encoding="utf-8") as rf:
                            rf.write(reproducible_cex_content)
                        reproducible_cex_path = rel_path
                else:
                    status_flag_validated = "NO_DATASET"
            except Exception as e:
                status_flag_validated = "ERROR_QUERY_EXECUTION"
                converted_cex = str(e).replace('\n', '\\n')
        elif raw_status == 'NEQ' and cex is None:
            status_flag_validated = "NO_CEX"
            converted_cex = "No counterexample provided by SpotIt (e.g. shape mismatch)"
                
        error_msg = ''
        if status_flag_validated in ['TOOL_ERROR', 'TIMEOUT', 'ERROR_QUERY_EXECUTION', 'EXTEST_ERROR'] or str(status_flag_validated).startswith('ERROR'):
            error_msg = converted_cex if raw_status == 'NEQ' else raw_cex
            
        # Write large strings to files
        base_dir = os.path.dirname(os.path.abspath(__file__))
        if not 'results_dir' in locals():
            results_dir = os.path.join(base_dir, 'results')
        safe_instance_id = str(instance_id).replace('/', '_').replace('\\', '_')
        
        raw_cex_path = ""
        if raw_cex:
            raw_cex_dir = os.path.join(results_dir, 'raw_cex', 'spotit')
            os.makedirs(raw_cex_dir, exist_ok=True)
            rel_path = f"raw_cex/spotit/{safe_instance_id}_{pred_id}.txt"
            with open(os.path.join(results_dir, rel_path), "w", encoding="utf-8") as rf:
                rf.write(raw_cex)
            raw_cex_path = rel_path
            
        error_msg_path = ""
        if error_msg:
            error_msg_dir = os.path.join(results_dir, 'error_msg', 'spotit')
            os.makedirs(error_msg_dir, exist_ok=True)
            rel_path = f"error_msg/spotit/{safe_instance_id}_{pred_id}.txt"
            with open(os.path.join(results_dir, rel_path), "w", encoding="utf-8") as rf:
                rf.write(error_msg)
            error_msg_path = rel_path

        res_dict = {
            'instance_id': instance_id,
            'prediction_id': pred_id,
            'raw_tool_status': raw_status,
            'EXTEST_STATUS': status_flag_validated,
            'time_taken': time_cost,
            'raw_counterexample': raw_cex_path,
            'error_message': error_msg_path,
            'gold_sql_result': gold_sql_result,
            'prediction_sql_result': prediction_sql_result,
            'reproducible_cex': reproducible_cex_path
        }
        yield res_dict

def evaluate_all(*args, benchmark='all', resume=False, retry=False, target_dialect=None, target_instance_id=None, target_prediction_id=None, input_file=None, **kwargs):
    results_dir = os.path.join(script_dir, 'results')
    os.makedirs(results_dir, exist_ok=True)

    data, loaded_schemas = benchmark_loader.load_benchmark_data(
        benchmark=benchmark,
        input_file=input_file or os.environ.get('INPUT_FILE'),
        base_dir=script_dir
    )
    global schemas_data_global
    if loaded_schemas:
        schemas_data_global = loaded_schemas

    if not data:
        print(f"No queries found to evaluate for benchmark '{benchmark}'.")
        return

    unique_sources = set(item.get('source', 'unknown') for item in data)
    
    fieldnames = ['instance_id', 'prediction_id', 'raw_tool_status', 'EXTEST_STATUS', 'reproducible_cex', 'time_taken', 'raw_counterexample', 'error_message', 'gold_sql_result', 'prediction_sql_result']

    for src in unique_sources:
        output_csv_path = os.path.join(results_dir, f'spotit_{src}.csv')
        file_mode = 'a' if ((resume or retry) and os.path.exists(output_csv_path)) else 'w'
        with open(output_csv_path, file_mode, newline='', encoding='utf-8') as f:
            writer = csv.DictWriter(f, fieldnames=fieldnames)
            if file_mode == 'w' or os.path.getsize(output_csv_path) == 0:
                writer.writeheader()

    data, total_predictions = csv_utils.filter_predictions_for_evaluation(
        data=data,
        results_dir=results_dir,
        csv_file_func=lambda src: os.path.join(results_dir, f'spotit_{src}.csv'),
        resume=resume,
        retry=retry,
        target_instance_id=target_instance_id,
        target_prediction_id=target_prediction_id,
        tool_name="SpotIt"
    )
    print(f"Loaded {len(data)} items to process with SpotIt. Total predictions: {total_predictions}")
    
    status_counts = Counter()
    last_status = [None]
    with tqdm(total=total_predictions, desc="Evaluating SpotIt") as pbar:
        for item in data:
            src_out = item.get('source', 'unknown')
            output_csv_path = os.path.join(results_dir, f'spotit_{src_out}.csv')
            try:
                for res in process_item_spotit(item, schemas_data_global, results_dir):
                    status_counts[res.get('EXTEST_STATUS', 'UNKNOWN')] += 1
                    csv_utils.update_or_append_results(output_csv_path, fieldnames, [res])
                    csv_utils.print_status_update(pbar, status_counts, last_status)
                    pbar.update(1)
            except KeyboardInterrupt:
                pbar.write("\nInterrupted by user. Saving partial results...")
                break
            except Exception as e:
                pbar.write(f"Error processing item: {e}")
    print(f"Finished evaluating SpotIt. Results in {results_dir}")
    
    for src in unique_sources:
        out_csv = os.path.join(results_dir, f'spotit_{src}.csv')
        csv_utils.deduplicate_csv(out_csv, fieldnames)
        
    for src in unique_sources:
        print(f"\n--- Status Statistics for {src} ---")
        try:
            output_csv_path = os.path.join(results_dir, f'spotit_{src}.csv')
            with open(output_csv_path, 'r', encoding='utf-8') as f:
                reader = csv.DictReader(f)
                counts = Counter(row.get('EXTEST_STATUS', 'UNKNOWN') for row in reader)
                for status, count in counts.most_common():
                    print(f"{status}: {count}")
            
            err_counts = csv_utils.get_error_histogram(output_csv_path, results_dir, "ERROR_QUERY_EXECUTION")
            csv_utils.print_error_histogram(err_counts, f"Top 5 ERROR_QUERY_EXECUTION Errors for {src}", top_n=5)
        except Exception as e:
            print(f"Could not print statistics: {e}")

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--benchmark', type=str, default='all', help='Benchmark to evaluate (e.g. bird, spider)')
    parser.add_argument('--resume', action='store_true', help='Resume from last saved item in csv')
    parser.add_argument('--retry', action='store_true', help='Retry evaluation for failed/error cases in existing CSV')
    parser.add_argument('--target-dialect', type=str, default='native', choices=['native', 'sqlite', 'mysql', 'postgresql'], help='Target dialect to use for queries')
    parser.add_argument('--instance-id', type=str, default=None, help='Run only for this specific instance ID')
    parser.add_argument('--prediction-id', type=str, default=None, help='Run only for this specific prediction ID')
    parser.add_argument('--input-file', type=str, default=None, help='Input JSON file')
    args = parser.parse_args()
    evaluate_all(benchmark=args.benchmark, resume=args.resume, retry=args.retry, target_dialect=args.target_dialect, target_instance_id=args.instance_id, target_prediction_id=args.prediction_id, input_file=args.input_file)
