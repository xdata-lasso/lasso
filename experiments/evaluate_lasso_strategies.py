"""
Evaluate Lasso Attack Strategies Effectiveness
================================================
Evaluates the effectiveness of individual test-generation attack strategies in LASSO.
Only tests gold datasets generated from the reference query.
Evaluates all prediction queries against all generated datasets without early stopping,
recording every (instance_id, prediction_id, attack_strategy) kill where non-equivalence is proven.

Outputs a dedicated CSV keeping track of which attack strategy killed which query pair
(allowing multiple strategies to be credited for the same pair).
"""

import json
import argparse
import os
import sys
import time
import csv
import re
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
    print(f"Error importing generate_test_data_with_meta: {e}")
    sys.exit(1)

schemas_data_global = benchmark_loader.get_schemas(base_dir=script_dir)

def get_ddl(database_id):
    if database_id in schemas_data_global:
        return schemas_data_global[database_id].get("ddl", "")
    return ""

def extract_attack_strategies(strategy_name: str) -> list[str]:
    """
    Extracts canonical attack strategy names from a dataset's strategy_name string.
    Handles comma-separated strategies (from deduplicated datasets) and strips
    dataset-specific parameters/suffixes (e.g. column names, offsets, indices).
    """
    if not strategy_name:
        return []

    strategies = []
    for part in strategy_name.split(","):
        part = part.strip()
        if not part:
            continue

        m = re.match(r"^([A-Za-z0-9]+AttackStrategy|BaseDatasetStrategy|[A-Za-z0-9]+Attack)", part)
        if m:
            base_name = m.group(1)
            if base_name == "ArithmeticAttack":
                base_name = "ArithmeticAttackStrategy"
            elif base_name == "AggregateDistinctColumnAttack":
                base_name = "AggregateDistinctColumnAttackStrategy"
            elif base_name == "AggregateMissingDistinctAttack":
                base_name = "AggregateMissingDistinctAttackStrategy"
            elif base_name == "GroupByDuplicateAttributeAttack":
                base_name = "GroupByDuplicateAttributeAttackStrategy"
            strategies.append(base_name)
        else:
            base_name = part.split("_")[0]
            strategies.append(base_name)

    seen = set()
    result = []
    for s in strategies:
        if s not in seen:
            seen.add(s)
            result.append(s)
    return result

def strategy_eval_worker(ddl_content: str, gold_sql: str, prediction_queries: dict[str, str], dialect: str):
    """
    Gold Datasets Only Strategy Evaluation Worker.
    Tests all prediction queries against all generated gold datasets without early stopping,
    tracking every (prediction_id, attack_strategy) kill where non-equivalence is proven.
    """
    import contextlib
    from execution_tester import execution_test_batch

    pids = list(prediction_queries.keys())
    pred_sqls = [prediction_queries[pid] for pid in pids]

    gold_datasets, gold_meta = generate_test_data_with_meta(ddl_string=ddl_content, query_string=gold_sql)

    kills = set()
    pred_statuses = {pid: "EQ_EXEC" for pid in pids}

    if not gold_meta.get("error_message"):
        for dataset in gold_datasets:
            dataset_sql = "\n".join(dataset.insert_statements)

            with open(os.devnull, 'w') as devnull, contextlib.redirect_stdout(devnull):
                test_results = execution_test_batch(
                    schema=ddl_content,
                    dataset=dataset_sql,
                    gold_sql=gold_sql,
                    prediction_sqls=pred_sqls,
                    dialect=dialect
                )

            strats = extract_attack_strategies(getattr(dataset, "strategy_name", ""))

            for i, res in enumerate(test_results):
                pid = pids[i]
                status = res.get("status", "")

                if status.startswith("NEQ"):
                    pred_statuses[pid] = status
                    for strat in strats:
                        kills.add((pid, strat))
                elif status.startswith("ERROR") and not pred_statuses[pid].startswith("NEQ"):
                    pred_statuses[pid] = status

    return {
        "kills": list(kills),
        "pred_statuses": pred_statuses,
        "error_message": gold_meta.get("error_message", "")
    }

def process_item(item, target_dialect='native', timeout=30):
    db_id = item.get('schema_id', item.get('database_id'))
    dialect = 'sqlite'
    instance_id = str(item.get('id') or item.get('instance_id') or db_id).strip()
    ddl_content = get_ddl(db_id)

    if not ddl_content:
        return {"kills": [], "completed": True, "error": "Missing DDL"}

    gold_sql = item.get(f'gold_sql_{dialect}', item.get('gold_sql'))
    if not gold_sql:
        return {"kills": [], "completed": True, "error": "Missing Gold SQL"}

    prediction_queries = {}
    for pred in item.get('predictions', []):
        pred_id = str(pred['prediction_id']).strip()
        pred_sql = pred.get(f'prediction_sql_{dialect}', pred.get('prediction_sql', ''))
        prediction_queries[pred_id] = pred_sql

    if not prediction_queries:
        return {"kills": [], "completed": True, "error": ""}

    try:
        worker_res = run_with_timeout(strategy_eval_worker, timeout, ddl_content, gold_sql, prediction_queries, dialect)
        raw_kills = worker_res.get("kills", [])
        kills_records = []
        for pid, strat in sorted(raw_kills):
            kills_records.append({
                'instance_id': instance_id,
                'prediction_id': pid,
                'attack_strategy': strat
            })
        return {"kills": kills_records, "completed": True, "error": worker_res.get("error_message", "")}
    except TimeoutError:
        return {"kills": [], "completed": False, "error": f"Timeout after {timeout}s"}
    except Exception as e:
        return {"kills": [], "completed": False, "error": str(e)}

def main():
    parser = argparse.ArgumentParser(description="Evaluate Effectiveness of Lasso Attack Strategies on Gold Datasets")
    parser.add_argument('--benchmark', type=str, default='all', help='Benchmark to evaluate (e.g. bird, leetcode, xdata, all)')
    parser.add_argument('--target-dialect', type=str, default='native', choices=['native', 'sqlite', 'mysql', 'postgresql'], help='Target dialect to use for queries')
    parser.add_argument('--timeout', type=int, default=30, help='Timeout in seconds per item evaluation (default: 30)')
    parser.add_argument('--instance-id', type=str, default=None, help='Filter evaluation to a specific instance ID')
    parser.add_argument('--prediction-id', type=str, default=None, help='Filter evaluation to a specific prediction ID')
    parser.add_argument('--input-file', type=str, default=None, help='Input JSON file (default: queries.json)')
    parser.add_argument('--output-prefix', type=str, default='lasso_strategy_kills', help='Output CSV prefix (default: lasso_strategy_kills)')
    args = parser.parse_args()

    results_dir = os.path.join(script_dir, 'results')
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

    if args.instance_id:
        data = [d for d in data if str(d.get('id') or d.get('instance_id') or d.get('schema_id')).strip() == str(args.instance_id).strip()]

    if args.prediction_id:
        for item in data:
            item['predictions'] = [p for p in item.get('predictions', []) if str(p.get('prediction_id', '')).strip() == str(args.prediction_id).strip()]
        data = [d for d in data if d.get('predictions')]

    unique_sources = set(item.get('source', 'unknown') for item in data)
    fieldnames = ['instance_id', 'prediction_id', 'attack_strategy']

    for src in unique_sources:
        out_csv = os.path.join(results_dir, f'{args.output_prefix}_{src}.csv')
        with open(out_csv, 'w', newline='', encoding='utf-8') as f:
            writer = csv.DictWriter(f, fieldnames=fieldnames)
            writer.writeheader()

    total_predictions = sum(len(item.get('predictions', [])) for item in data)
    print(f"Loaded {len(data)} items to evaluate. Total predictions: {total_predictions}")

    from tqdm import tqdm
    strategy_kill_counts = Counter()

    with tqdm(total=total_predictions, desc="Evaluating Strategy Kills") as pbar:
        for item in data:
            src = item.get('source', 'unknown')
            instance_id = str(item.get('id') or item.get('instance_id') or item.get('schema_id', '')).strip()
            out_csv = os.path.join(results_dir, f'{args.output_prefix}_{src}.csv')

            try:
                res = process_item(item, args.target_dialect, args.timeout)
                kills = res.get("kills", [])

                if kills:
                    csv_utils.update_or_append_results(out_csv, fieldnames, kills)
                    for k in kills:
                        strategy_kill_counts[k['attack_strategy']] += 1

            except KeyboardInterrupt:
                pbar.write("\nInterrupted by user. Saving partial results...")
                break
            except Exception as e:
                pbar.write(f"Error processing item {instance_id}: {e}")

            pbar.update(len(item.get('predictions', [])))

    print(f"\nEvaluation finished. Results saved in {results_dir}")

    # Deduplicate each output CSV and print summary statistics
    for src in sorted(unique_sources):
        out_csv = os.path.join(results_dir, f'{args.output_prefix}_{src}.csv')
        csv_utils.deduplicate_strategy_kills_csv(out_csv, fieldnames)

        print(f"\n=======================================================")
        print(f"Strategy Effectiveness Breakdown for Benchmark: {src}")
        print(f"=======================================================")
        if os.path.exists(out_csv) and os.path.getsize(out_csv) > 0:
            with open(out_csv, 'r', encoding='utf-8') as f:
                reader = csv.DictReader(f)
                rows = list(reader)

            strat_counts = Counter(row['attack_strategy'] for row in rows if row.get('attack_strategy'))
            total_kills = len(rows)
            unique_killed_pairs = len(set((row['instance_id'], row['prediction_id']) for row in rows))

            print(f"Total Refutations (Strategy Kills Recorded): {total_kills:,}")
            print(f"Unique Query Pairs Refuted: {unique_killed_pairs:,}")
            print(f"\n{'Attack Strategy':<45} | {'Kills':<10} | {'% of Refutations':<18}")
            print("-" * 78)
            for strat, count in strat_counts.most_common():
                pct = (count / unique_killed_pairs * 100.0) if unique_killed_pairs > 0 else 0.0
                print(f"{strat:<45} | {count:<10} | {pct:>6.2f}%")
        else:
            print("No kills recorded.")

if __name__ == '__main__':
    main()
