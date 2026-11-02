import json
import os
import sys
import time
import csv
import glob
import argparse
from collections import Counter
from tqdm import tqdm
import contextlib
import sqlglot

script_dir = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.abspath(os.path.join(script_dir, 'originals', 'SQLWitness')))
sys.path.append(os.path.abspath(os.path.join(script_dir, '../sql-execution-tester')))

import logging
logging.getLogger("logger").setLevel(logging.CRITICAL)

from timeout_utils import run_with_timeout
import csv_utils
import benchmark_loader

try:
    from execution_tester import execution_test
    from query_normalizer import normalize_sql
except ImportError as e:
    print(f"Error importing execution_test/query_normalizer: {e}")
    sys.exit(1)

try:
    from sqlwitness import counterexample
    from sqlwitness.online.schema_handler import SchemaHandler
    from sqlwitness.online.runner import DatabaseRunner
except ImportError as e:
    print(f"Error importing SQLWitness native components: {e}")
    sys.exit(1)


schemas_data_global = benchmark_loader.get_schemas(base_dir=script_dir)


def cleanup_temp_db_files():
    """Remove any temporary worker SQLite database files created by SQLWitness."""
    for base in [os.getcwd(), script_dir, os.path.dirname(script_dir)]:
        for p in glob.glob(os.path.join(base, "worker_db_*.db")) + glob.glob(os.path.join(base, "test.db")):
            try:
                if os.path.exists(p):
                    os.remove(p)
            except Exception:
                pass


def get_sqlwitness_schema_handler(db_id, ddl_content):
    """
    Construct a native SQLWitness SchemaHandler using SQLWitness's built-in methods:
    1. SchemaHandler.from_schema() if schema tables are precomputed.
    2. SchemaHandler.from_ast() parsed from DDL via SQLGlot.
    """
    schema_info = schemas_data_global.get(db_id, {})
    poly_schema_data = schema_info.get("polygon_schema", {})
    tables_list = poly_schema_data.get("Tables", [])
    constraints = schema_info.get("polygon_constraints", [])

    if tables_list:
        return SchemaHandler.from_schema(tables_list), constraints

    if ddl_content:
        try:
            asts = sqlglot.parse(ddl_content, read='sqlite')
            table_asts = [a for a in asts if isinstance(a, sqlglot.exp.Create) and a.kind == "TABLE"]
            if table_asts:
                return SchemaHandler.from_ast(table_asts), constraints
        except Exception:
            pass

    return None, []


def get_ddl(database_id):
    if database_id in schemas_data_global:
        return schemas_data_global[database_id].get("ddl", "")
    return ""


def generate_inserts_with_sqlwitness(schema_handler, table_data, dialect='sqlite', constraints=None):
    """
    Generate SQL INSERT statements using SQLWitness's own DatabaseRunner._generate_all_inserts().
    """
    if not table_data or not isinstance(table_data, dict):
        return []
    try:
        runner = DatabaseRunner(
            schema_handler=schema_handler,
            table_data=table_data,
            dialect_name=dialect,
            constraints=constraints or []
        )
        all_inserts = runner._generate_all_inserts()
        statements = []
        for sublist in all_inserts:
            for s in sublist:
                s_clean = s.strip()
                if not s_clean.endswith(';'):
                    s_clean += ';'
                statements.append(s_clean)
        return statements
    except Exception as e:
        return []


def sqlwitness_worker(schema_list, constraints, gold_sql, pred_sql, dialect, timeout, iteration, debug=False):
    pid = os.getpid()
    try:
        if not debug:
            with open(os.devnull, 'w') as devnull, contextlib.redirect_stdout(devnull), contextlib.redirect_stderr(devnull):
                refuted, data, elapsed, iters = counterexample(
                    schema=schema_list,
                    constraints=constraints,
                    groundtruth_query=gold_sql,
                    candidate_query=pred_sql,
                    dialect=dialect,
                    timeout=timeout,
                    iteration=iteration,
                    use_multiprocessing=False,
                )
        else:
            refuted, data, elapsed, iters = counterexample(
                schema=schema_list,
                constraints=constraints,
                groundtruth_query=gold_sql,
                candidate_query=pred_sql,
                dialect=dialect,
                timeout=timeout,
                iteration=iteration,
                use_multiprocessing=False,
            )
        return refuted, data, elapsed, iters, None
    except Exception as e:
        err_msg = str(e).strip() if str(e).strip() else f"{type(e).__name__}: {repr(e)}"
        return False, None, 0.0, 0, err_msg
    finally:
        for db_file in glob.glob(f"worker_db_{pid}*.db") + glob.glob("test.db"):
            try:
                if os.path.exists(db_file):
                    os.remove(db_file)
            except Exception:
                pass


def process_item(item, target_dialect='sqlite', timeout=30, iteration=100, debug=False, results_dir=None):
    db_id = item.get('schema_id', item.get('database_id'))
    dialect_extest = 'postgres' if target_dialect in ('postgres', 'postgresql') else ('mysql' if target_dialect == 'mysql' else 'sqlite')
    dialect_witness = 'sqlite' if target_dialect in ('native', 'sqlite', '') else target_dialect
    gold_sql = item.get('gold_sql', '')
    instance_id = str(item.get('id') or item.get('instance_id') or db_id)
    ddl_content = get_ddl(db_id)
    if results_dir is None:
        results_dir = csv_utils.get_results_dir(script_dir, target_dialect)

    schema_handler, constraints = get_sqlwitness_schema_handler(db_id, ddl_content)

    if schema_handler is None or not schema_handler.schema or not ddl_content:
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

    gold_sql_witness = item.get(f'gold_sql_{dialect_witness}', gold_sql)
    gold_sql_extest = item.get(f'gold_sql_{dialect_extest}', gold_sql)

    for idx, pred in enumerate(item.get('predictions', [])):
        pred_id = pred.get('prediction_id', f"pred_{idx}")
        pred_sql = pred.get('prediction_sql', '')

        if pred.get('status') == 'EQ':
            yield {
                'instance_id': instance_id,
                'prediction_id': pred_id,
                'raw_tool_status': 'EQ',
                'EXTEST_STATUS': 'EQ',
                'time_taken': 0,
                'raw_counterexample': '',
                'error_message': '',
                'gold_sql_result': '',
                'prediction_sql_result': '',
                'reproducible_cex': ''
            }
            continue

        is_update = gold_sql.strip().upper().startswith('UPDATE') or pred_sql.strip().upper().startswith('UPDATE')
        if is_update:
            yield {
                'instance_id': instance_id,
                'prediction_id': pred_id,
                'raw_tool_status': 'SKIPPED_UPDATE_QUERY',
                'EXTEST_STATUS': 'SKIPPED_UPDATE_QUERY',
                'time_taken': 0,
                'raw_counterexample': '',
                'error_message': '',
                'gold_sql_result': '',
                'prediction_sql_result': '',
                'reproducible_cex': ''
            }
            continue

        pred_sql_witness = pred.get(f'prediction_sql_{dialect_witness}', pred_sql)
        pred_sql_extest = pred.get(f'prediction_sql_{dialect_extest}', pred_sql)

        start_t = time.time()
        ret_status = "UNKNOWN"
        cex = None
        total_time = 0.0
        err_detail = ""

        try:
            res = run_with_timeout(
                sqlwitness_worker,
                int(timeout) + 5,
                schema_handler.schema,
                constraints,
                gold_sql_witness,
                pred_sql_witness,
                dialect_witness,
                timeout,
                iteration,
                debug
            )
            refuted, data, elapsed, iters, err_worker = res
            total_time = elapsed if elapsed > 0 else (time.time() - start_t)
            if err_worker:
                ret_status = "TOOL_ERROR"
                err_detail = err_worker
            elif refuted:
                ret_status = "NEQ"
                cex = data
            else:
                ret_status = "EQ"
        except TimeoutError:
            ret_status = "TIMEOUT"
            err_detail = f"Timeout after {timeout}s"
            total_time = time.time() - start_t
        except Exception as e:
            ret_status = "TOOL_ERROR"
            err_detail = str(e).strip() if str(e).strip() else f"{type(e).__name__}: {repr(e)}"
            total_time = time.time() - start_t

        status_flag_validated = ret_status
        raw_cex = json.dumps(cex, default=str) if isinstance(cex, dict) else str(cex) if cex else ""
        gold_sql_result = ""
        prediction_sql_result = ""
        reproducible_cex_path = ""
        converted_cex_msg = ""

        if ret_status == "NEQ" and isinstance(cex, dict):
            # Generate INSERT statements natively through SQLWitness DatabaseRunner
            inserts = generate_inserts_with_sqlwitness(
                schema_handler=schema_handler,
                table_data=cex,
                dialect=dialect_extest,
                constraints=constraints
            )
            converted_cex_exec = '\n'.join(inserts)
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
                    converted_cex_msg = str(exec_res.get("error_message", "Unknown validation error")).replace('\n', '\\n')
                else:
                    status_flag_validated = exec_res.get("status", "ERROR_QUERY_EXECUTION")
                    gold_sql_result = str(exec_res.get("gold_sql_result", "")).replace('\n', '\\n')
                    prediction_sql_result = str(exec_res.get("prediction_sql_result", "")).replace('\n', '\\n')

                    reproducible_cex_content = exec_res.get("reproducible_cex", "")
                    if reproducible_cex_content:
                        cex_dir = os.path.join(results_dir, 'reproducible_cex', 'sqlwitness')
                        os.makedirs(cex_dir, exist_ok=True)
                        safe_instance_id = str(instance_id).replace('/', '_').replace('\\', '_')
                        rel_path = f"reproducible_cex/sqlwitness/{safe_instance_id}_{pred_id}.sql"
                        with open(os.path.join(results_dir, rel_path), "w", encoding="utf-8") as rf:
                            rf.write(reproducible_cex_content)
                        reproducible_cex_path = rel_path
            except Exception as e:
                status_flag_validated = "ERROR_QUERY_EXECUTION"
                converted_cex_msg = str(e).replace('\n', '\\n')
        elif ret_status == "NEQ":
            status_flag_validated = "NO_CEX"
            converted_cex_msg = "No counterexample dictionary returned by SQLWitness"

        error_msg = ''
        if status_flag_validated in ['TOOL_ERROR', 'TIMEOUT', 'ERROR_QUERY_EXECUTION', 'EXTEST_ERROR'] or str(status_flag_validated).startswith('ERROR'):
            error_msg = converted_cex_msg if converted_cex_msg else err_detail

        safe_instance_id = str(instance_id).replace('/', '_').replace('\\', '_')

        raw_cex_path = ""
        if raw_cex:
            raw_cex_dir = os.path.join(results_dir, 'raw_cex', 'sqlwitness')
            os.makedirs(raw_cex_dir, exist_ok=True)
            rel_path = f"raw_cex/sqlwitness/{safe_instance_id}_{pred_id}.txt"
            with open(os.path.join(results_dir, rel_path), "w", encoding="utf-8") as rf:
                rf.write(raw_cex)
            raw_cex_path = rel_path

        error_msg_path = ""
        if error_msg:
            error_msg_dir = os.path.join(results_dir, 'error_msg', 'sqlwitness')
            os.makedirs(error_msg_dir, exist_ok=True)
            rel_path = f"error_msg/sqlwitness/{safe_instance_id}_{pred_id}.txt"
            with open(os.path.join(results_dir, rel_path), "w", encoding="utf-8") as rf:
                rf.write(error_msg)
            error_msg_path = rel_path

        yield {
            'instance_id': instance_id,
            'prediction_id': pred_id,
            'raw_tool_status': ret_status,
            'EXTEST_STATUS': status_flag_validated,
            'time_taken': f"{total_time:.3f}" if isinstance(total_time, (int, float)) else str(total_time),
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
    parser.add_argument('--target-dialect', '--dialect', type=str, default='sqlite', choices=['native', 'sqlite', 'mysql', 'postgresql', 'postgres'], help='Target dialect to use for queries')
    parser.add_argument('--instance-id', type=str, default=None, help='Filter evaluation to a specific instance ID')
    parser.add_argument('--prediction-id', type=str, default=None, help='Filter evaluation to a specific prediction ID')
    parser.add_argument('--input-file', type=str, default=None, help='Input JSON file')
    parser.add_argument('--timeout', type=float, default=30.0, help='Search timeout in seconds per query pair')
    parser.add_argument('--iteration', type=int, default=100, help='Maximum search iterations per query pair')
    parser.add_argument('--debug', action='store_true', help='Enable debug logging')
    args = parser.parse_args()

    results_dir = csv_utils.get_results_dir(script_dir, args.target_dialect)
    os.makedirs(results_dir, exist_ok=True)
    cleanup_temp_db_files()

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
        out_csv = os.path.join(results_dir, f'sqlwitness_{src}.csv')
        mode = 'a' if ((args.resume or args.retry) and os.path.exists(out_csv)) else 'w'
        with open(out_csv, mode, newline='', encoding='utf-8') as f:
            writer = csv.DictWriter(f, fieldnames=fieldnames)
            if mode == 'w' or os.path.getsize(out_csv) == 0:
                writer.writeheader()

    data, total_predictions = csv_utils.filter_predictions_for_evaluation(
        data=data,
        results_dir=results_dir,
        csv_file_func=lambda src: os.path.join(results_dir, f'sqlwitness_{src}.csv'),
        resume=args.resume,
        retry=args.retry,
        target_instance_id=args.instance_id,
        target_prediction_id=args.prediction_id,
        tool_name="SQLWitness"
    )
    print(f"Loaded {len(data)} items to process with SQLWitness. Total predictions: {total_predictions}")

    if total_predictions == 0:
        print("Nothing to process.")
        return

    status_counts = Counter()
    last_status = [None]
    with tqdm(total=total_predictions, desc="Evaluating SQLWitness") as pbar:
        for item in data:
            src = item.get('source', 'unknown')
            output_csv_path = os.path.join(results_dir, f'sqlwitness_{src}.csv')
            try:
                for res in process_item(item, args.target_dialect, timeout=args.timeout, iteration=args.iteration, debug=args.debug, results_dir=results_dir):
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
        out_csv = os.path.join(results_dir, f'sqlwitness_{src}.csv')
        csv_utils.deduplicate_csv(out_csv, fieldnames)

    for src in unique_sources:
        print(f"\n--- Status Statistics (Total) for {src} ---")
        try:
            output_csv_path = os.path.join(results_dir, f'sqlwitness_{src}.csv')
            with open(output_csv_path, 'r', encoding='utf-8') as f:
                reader = csv.DictReader(f)
                counts = Counter(row.get('EXTEST_STATUS', 'UNKNOWN') for row in reader)
                for status, count in counts.most_common():
                    print(f"{status}: {count}")

            err_counts = csv_utils.get_error_histogram(output_csv_path, results_dir, "ERROR_QUERY_EXECUTION")
            if err_counts:
                csv_utils.print_error_histogram(err_counts, f"Top 5 ERROR_QUERY_EXECUTION Errors for {src}", top_n=5)

            tool_err_counts = csv_utils.get_error_histogram(output_csv_path, results_dir, "TOOL_ERROR")
            if tool_err_counts:
                csv_utils.print_error_histogram(tool_err_counts, f"Top 5 TOOL_ERROR Errors for {src}", top_n=5)
        except Exception as e:
            print(f"Could not print statistics: {e}")

    cleanup_temp_db_files()


if __name__ == '__main__':
    main()
