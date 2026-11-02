#!/usr/bin/env python3
"""
Evaluation of Cross-Checking Across 4 Levels on BIRD Benchmark
==============================================================

This experimental script evaluates whether and to what degree cross-checking test datasets
across queries increases the number of refuted non-equivalent query pairs (mutant kills / NEQ).

Research Question:
------------------
Does cross-checking test datasets generated for other queries:
1. Between a query pair (Gold + Mutant)
2. Across sibling mutants within the same instance (Instance-Level Pool)
3. Across distinct instances sharing the same database schema (Cross-Instance Schema Pool)
yield an increase in non-equivalent (NEQ) detection rate compared to Gold-only data generation?

The Four Hierarchical Evaluation Levels:
----------------------------------------
- Level 1 (Gold-Only):
    Each pair (Q_gold, Q_pred) is evaluated solely on datasets generated from Q_gold.
- Level 2 (Pairwise Gold + Prediction):
    Each pair (Q_gold, Q_pred) is evaluated on datasets generated from Q_gold AND Q_pred.
- Level 3 (Instance Pool):
    Each pair (Q_gold, Q_pred) is evaluated on datasets generated from Q_gold and ALL sibling
    prediction queries within that same instance.
- Level 4 (Cross-Instance Schema Pool):
    Each pair (Q_gold, Q_pred) is evaluated on datasets generated from ALL queries (gold and
    predictions) across all sampled instances sharing the exact same database schema.

Sound Execution Minimization:
-----------------------------
Because dataset pools satisfy monotonic inclusion:
    D_Level1(p) ⊆ D_Level2(p) ⊆ D_Level3(p) ⊆ D_Level4(p)
we achieve optimal minimization:
1. Sound Early Termination: Any pair refuted at Level k is guaranteed refuted at all Levels k' > k
   and is immediately removed from further testing.
2. Incremental Testing (ΔD): Unrefuted pairs are tested ONLY against the marginal new datasets
   introduced at Level k+1.
3. Canonical Deduplication: Datasets with identical sequence of INSERT statements are deduplicated
   by SHA-256 hash (preserving statement execution order).
4. Table-Overlap Pruning: In Level 4, datasets touching zero tables in Tables(Q_gold) ∪ Tables(Q_pred)
   are mathematically identical to empty database evaluations and are safely skipped.
5. Batch SQLite Execution: Unrefuted predictions sharing the same gold query are tested on each
   dataset in a single in-memory SQLite setup.
"""

import argparse
import contextlib
import csv
import hashlib
import json
import logging
import os
import random
import re
import sys
import time
from collections import Counter, defaultdict

# Adjust python paths
script_dir = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.abspath(os.path.join(script_dir, '../src')))
sys.path.insert(0, os.path.abspath(os.path.join(script_dir, '../sql-execution-tester')))

try:
    from main import generate_test_data_with_meta
    from execution_tester import execution_test_batch
    from timeout_utils import run_with_timeout
    import sqlglot
    import sqlglot.expressions as exp
    import csv_utils
import benchmark_loader
except ImportError as e:
    print(f"Error importing required modules: {e}")
    sys.exit(1)

logging.basicConfig(
    level=logging.INFO,
    format='[%(asctime)s] [%(levelname)s] %(message)s',
    datefmt='%H:%M:%S'
)
logger = logging.getLogger("cross_checking_study")


def extract_tables_from_query(sql: str) -> set[str]:
    """Extract table names referenced in a SQL query using sqlglot."""
    tables = set()
    if not sql:
        return tables
    try:
        parsed = sqlglot.parse_one(sql)
        for t in parsed.find_all(exp.Table):
            if t.name:
                tables.add(t.name.lower().strip('`"[]'))
    except Exception:
        # Regex fallback
        for m in re.finditer(r'(?:FROM|JOIN)\s+[`"\[]?([A-Za-z0-9_]+)[`"\]]?', sql, re.IGNORECASE):
            tables.add(m.group(1).lower())
    return tables


def extract_table_from_insert(stmt: str) -> str:
    """Extract table name from an INSERT INTO statement."""
    m = re.search(r'INSERT\s+INTO\s+[`"\[]?([A-Za-z0-9_]+)[`"\]]?', stmt, re.IGNORECASE)
    return m.group(1).lower() if m else ""


def compute_dataset_hash(insert_statements: list[str]) -> str:
    """Computes a canonical SHA-256 hash preserving INSERT statement execution order."""
    canonical = tuple(stmt.strip() for stmt in insert_statements if stmt.strip())
    return hashlib.sha256("\n".join(canonical).encode('utf-8')).hexdigest()[:16]


def is_refuted_status(status: str, error_message: str = "") -> bool:
    """Determines if the status represents a valid mutant refutation (kill). Only NEQ is considered."""
    return status == "NEQ"


def get_query_cache_path(cache_dir: str, schema_id: str, dialect: str, query_sql: str) -> str:
    """Computes a deterministic cache path for a query's generated datasets."""
    norm_sql = query_sql.strip()
    query_hash = hashlib.sha256(f"{dialect}::{norm_sql}".encode('utf-8')).hexdigest()[:24]
    return os.path.join(cache_dir, schema_id, f"{query_hash}.json")


def save_dataset_cache(cache_file: str, payload: dict) -> None:
    """Atomically saves serialized datasets to disk."""
    try:
        os.makedirs(os.path.dirname(cache_file), exist_ok=True)
        tmp_path = f"{cache_file}.tmp.{os.getpid()}"
        with open(tmp_path, 'w', encoding='utf-8') as f:
            json.dump(payload, f, indent=2)
        os.replace(tmp_path, cache_file)
    except Exception as e:
        logger.warning(f"Failed to write cache file {cache_file}: {e}")


def datagen_worker(task: dict) -> dict:
    """
    Worker task for parallel data generation for a single query.
    task: {query_id, query_type, instance_id, schema_id, ddl, query_sql, dialect, cache_file}
    """
    query_id = task["query_id"]
    query_type = task["query_type"]
    instance_id = task["instance_id"]
    schema_id = task["schema_id"]
    ddl = task["ddl"]
    query_sql = task["query_sql"]
    dialect = task.get("dialect", "sqlite")
    cache_file = task.get("cache_file")

    start_time = time.time()
    try:
        datasets, meta = run_with_timeout(generate_test_data_with_meta, 60, ddl_string=ddl, query_string=query_sql)
        elapsed = time.time() - start_time
    except TimeoutError:
        elapsed = time.time() - start_time
        return {
            "query_id": query_id,
            "query_type": query_type,
            "instance_id": instance_id,
            "schema_id": schema_id,
            "elapsed": elapsed,
            "datasets": [],
            "error_message": "Timeout after 60s",
            "strategies": ""
        }
    except Exception as e:
        elapsed = time.time() - start_time
        return {
            "query_id": query_id,
            "query_type": query_type,
            "instance_id": instance_id,
            "schema_id": schema_id,
            "elapsed": elapsed,
            "datasets": [],
            "error_message": str(e),
            "strategies": ""
        }

    serialized_datasets = []
    for ds in datasets:
        serialized_datasets.append({
            "insert_statements": ds.insert_statements,
            "strategy_name": getattr(ds, "strategy_name", ""),
            "tags": getattr(ds, "tags", [])
        })

    if cache_file:
        save_dataset_cache(cache_file, {
            "schema_id": schema_id,
            "dialect": dialect,
            "query_sql": query_sql,
            "elapsed": elapsed,
            "num_datasets": len(serialized_datasets),
            "error_message": meta.get("error_message", ""),
            "strategies": meta.get("attack_strategies", ""),
            "datasets": serialized_datasets
        })

    return {
        "query_id": query_id,
        "query_type": query_type,
        "instance_id": instance_id,
        "schema_id": schema_id,
        "elapsed": elapsed,
        "datasets": serialized_datasets,
        "error_message": meta.get("error_message", ""),
        "strategies": meta.get("attack_strategies", "")
    }


def sample_bird_instances(queries_data: list[dict], schemas_data: dict, sample_size: int, seed: int, strategy: str, instances_file: str = None) -> list[dict]:
    """Filter and sample valid BIRD instances deterministically."""
    if instances_file and os.path.exists(instances_file):
        with open(instances_file, 'r', encoding='utf-8') as f:
            target_ids = set(json.load(f))
        valid_items = [d for d in queries_data if str(d.get('id') or d.get('instance_id')) in target_ids]
        logger.info(f"Loaded {len(valid_items)} specific instances from {instances_file}")
        return valid_items

    eligible = []
    for item in queries_data:
        if item.get('source') != 'bird':
            continue
        schema_id = item.get('schema_id', item.get('database_id'))
        if not schema_id or schema_id not in schemas_data or not schemas_data[schema_id].get('ddl'):
            continue
        gold_sql = item.get('gold_sql_sqlite', item.get('gold_sql'))
        if not gold_sql:
            continue
        preds = item.get('predictions', [])
        if not preds:
            continue
        eligible.append(item)

    # Deterministic sort before sampling
    eligible.sort(key=lambda x: str(x.get('id') or x.get('instance_id')))

    if strategy == 'sequential':
        sampled = eligible[:sample_size]
    else:
        rng = random.Random(seed)
        sampled = rng.sample(eligible, min(sample_size, len(eligible)))

    sampled.sort(key=lambda x: str(x.get('id') or x.get('instance_id')))
    return sampled


def main():
    parser = argparse.ArgumentParser(description="Evaluate Cross-Checking Across 4 Levels on BIRD Benchmark")
    parser.add_argument('--sample-size', type=int, default=100, help='Number of BIRD instances to sample (default: 100)')
    parser.add_argument('--seed', type=int, default=42, help='Random seed for deterministic sampling (default: 42)')
    parser.add_argument('--sample-strategy', type=str, default='random', choices=['random', 'sequential'], help='Sampling strategy')
    parser.add_argument('--instances-file', type=str, default=None, help='Path to JSON file with exact instance IDs to evaluate')
    parser.add_argument('--num-workers', type=int, default=None, help='Worker processes for parallel data generation')
    parser.add_argument('--output-dir', type=str, default=None, help='Directory to save analysis results')
    parser.add_argument('--dialect', type=str, default='sqlite', help='SQL dialect (default: sqlite)')
    parser.add_argument('--cache-dir', type=str, default=None, help='Directory to cache and load materialized datasets (default: experiments/materialized_datasets)')
    parser.add_argument('--recompute-datagen', action='store_true', help='Force recomputing datagen even if cached materialized datasets exist')
    args = parser.parse_args()


    # Results directory
    output_dir = args.output_dir or os.path.join(script_dir, 'results', 'cross_checking_study')
    os.makedirs(output_dir, exist_ok=True)

    # Materialized datasets cache directory
    cache_dir = args.cache_dir or os.path.join(script_dir, 'materialized_datasets')
    os.makedirs(cache_dir, exist_ok=True)

    # Load Schemas and Queries
    queries_data, schemas_data = benchmark_loader.load_benchmark_data(benchmark='bird', base_dir=script_dir)

    if not queries_data or not schemas_data:
        logger.error("BIRD benchmark data not found in benchmarks/bird or experiments directory!")
        sys.exit(1)

    logger.info("================================================================================")
    logger.info("           LASSO: CROSS-CHECKING EVALUATION STUDY (BIRD BENCHMARK)            ")
    logger.info("================================================================================")
    logger.info(f"Target Dialect : {args.dialect}")
    logger.info(f"Sample Size    : {args.sample_size} instances")
    logger.info(f"Sample Strategy: {args.sample_strategy} (seed={args.seed})")
    logger.info("Mode           : Sequential")
    logger.info(f"Output Dir     : {output_dir}")
    logger.info(f"Cache Dir      : {cache_dir}")

    # 1. SAMPLING INSTANCES
    sampled_instances = sample_bird_instances(
        queries_data, schemas_data, args.sample_size, args.seed, args.sample_strategy, args.instances_file
    )
    logger.info(f"Sampled {len(sampled_instances)} valid BIRD instances.")

    # Save sampled instance IDs
    sampled_ids = [str(x.get('id') or x.get('instance_id')) for x in sampled_instances]
    with open(os.path.join(output_dir, 'sampled_instances.json'), 'w', encoding='utf-8') as f:
        json.dump(sampled_ids, f, indent=2)

    # Group instances by schema
    schema_to_instances = defaultdict(list)
    for item in sampled_instances:
        sid = item.get('schema_id', item.get('database_id'))
        schema_to_instances[sid].append(item)

    logger.info(f"Sample spans {len(schema_to_instances)} unique database schemas:")
    for sid, insts in sorted(schema_to_instances.items(), key=lambda x: len(x[1]), reverse=True):
        logger.info(f"  - Schema '{sid}': {len(insts)} instances")

    # 2. COLLECT QUERIES AND PAIRS
    all_datagen_tasks = []
    pairs_list = []
    total_predictions = 0

    for item in sampled_instances:
        inst_id = str(item.get('id') or item.get('instance_id'))
        schema_id = item.get('schema_id', item.get('database_id'))
        ddl = schemas_data[schema_id]['ddl']
        gold_sql = item.get(f'gold_sql_{args.dialect}', item.get('gold_sql'))
        gold_tables = extract_tables_from_query(gold_sql)

        # Task for Gold query
        gold_cache_file = get_query_cache_path(cache_dir, schema_id, args.dialect, gold_sql)
        all_datagen_tasks.append({
            "query_id": f"{inst_id}_gold",
            "query_type": "gold",
            "instance_id": inst_id,
            "schema_id": schema_id,
            "ddl": ddl,
            "query_sql": gold_sql,
            "dialect": args.dialect,
            "cache_file": gold_cache_file
        })

        for pred in item.get('predictions', []):
            pred_id = str(pred['prediction_id'])
            pred_sql = pred.get(f'prediction_sql_{args.dialect}', pred.get('prediction_sql'))
            pred_tables = extract_tables_from_query(pred_sql)

            # Task for Prediction query
            pred_cache_file = get_query_cache_path(cache_dir, schema_id, args.dialect, pred_sql)
            all_datagen_tasks.append({
                "query_id": pred_id,
                "query_type": "pred",
                "instance_id": inst_id,
                "schema_id": schema_id,
                "ddl": ddl,
                "query_sql": pred_sql,
                "dialect": args.dialect,
                "cache_file": pred_cache_file
            })

            pairs_list.append({
                "instance_id": inst_id,
                "prediction_id": pred_id,
                "schema_id": schema_id,
                "gold_sql": gold_sql,
                "pred_sql": pred_sql,
                "pair_tables": gold_tables | pred_tables,
                "gold_query_id": f"{inst_id}_gold"
            })
            total_predictions += 1

    logger.info(f"Total queries to generate data for: {len(all_datagen_tasks)} ({len(sampled_instances)} gold + {total_predictions} predictions)")
    logger.info(f"Total query pairs (candidates): {len(pairs_list)}")

    # 3. PARALLEL DATASET GENERATION & MATERIALIZATION
    logger.info("--------------------------------------------------------------------------------")
    logger.info("Phase 1: Generating and Materializing Datasets...")
    t_gen_start = time.time()

    datagen_csv_rows = []
    # Datasets indexed by hash (order-preserving signature)
    # sig_hash -> {sig_hash, insert_statements, dataset_sql, strategy_name, tags, source_query_id, source_query_type, source_instance_id, schema_id, tables_populated}
    unique_datasets = {}
    # query_id -> list of sig_hashes (ordered, deduplicated)
    query_dataset_hashes = defaultdict(list)
    # schema_id -> set of sig_hashes
    schema_dataset_hashes = defaultdict(set)
    # instance_id -> set of sig_hashes
    instance_dataset_hashes = defaultdict(set)

    # Cache lookup and task preparation
    cached_results = []
    cache_to_tasks = defaultdict(list)

    for task in all_datagen_tasks:
        cpath = task["cache_file"]
        if not args.recompute_datagen and os.path.exists(cpath):
            try:
                with open(cpath, 'r', encoding='utf-8') as f:
                    cached_data = json.load(f)
                cached_results.append({
                    "query_id": task["query_id"],
                    "query_type": task["query_type"],
                    "instance_id": task["instance_id"],
                    "schema_id": task["schema_id"],
                    "elapsed": cached_data.get("elapsed", 0.0),
                    "datasets": cached_data.get("datasets", []),
                    "error_message": cached_data.get("error_message", ""),
                    "strategies": cached_data.get("strategies", ""),
                    "from_cache": True
                })
                continue
            except Exception as e:
                logger.warning(f"Error reading cache {cpath}: {e}, will re-generate.")

        cache_to_tasks[cpath].append(task)

    unique_gen_tasks = [task_list[0] for task_list in cache_to_tasks.values()]
    logger.info(f"Materialized Cache: {len(cached_results)}/{len(all_datagen_tasks)} queries loaded directly from cache.")
    if unique_gen_tasks:
        covered_count = sum(len(l) for l in cache_to_tasks.values())
        logger.info(f"Generating datasets for {len(unique_gen_tasks)} unique uncached queries (covering {covered_count} task references) sequentially...")

    all_results = list(cached_results)

    if unique_gen_tasks:
        completed_count = 0
        for task in unique_gen_tasks:
            try:
                res = datagen_worker(task)
                cpath = task["cache_file"]
                for orig_task in cache_to_tasks[cpath]:
                    all_results.append({
                        "query_id": orig_task["query_id"],
                        "query_type": orig_task["query_type"],
                        "instance_id": orig_task["instance_id"],
                        "schema_id": orig_task["schema_id"],
                        "elapsed": res["elapsed"],
                        "datasets": res["datasets"],
                        "error_message": res["error_message"],
                        "strategies": res["strategies"],
                        "from_cache": False
                    })
            except Exception as e:
                logger.error(f"Error in datagen task {task.get('query_id')}: {e}")
            completed_count += 1
            if completed_count % 50 == 0 or completed_count == len(unique_gen_tasks):
                logger.info(f"  Progress: {completed_count}/{len(unique_gen_tasks)} unique queries processed...")

    for res in all_results:
        qid = res["query_id"]
        qtype = res["query_type"]
        iid = res["instance_id"]
        sid = res["schema_id"]
        ds_list = res["datasets"]

        datagen_csv_rows.append({
            "instance_id": iid,
            "query_id": qid,
            "query_type": qtype,
            "schema_id": sid,
            "data_gen_time": f"{res['elapsed']:.3f}",
            "num_datasets": len(ds_list),
            "attack_strategies": res["strategies"],
            "error_message": res["error_message"]
        })

        for ds in ds_list:
            inserts = ds["insert_statements"]
            if not inserts:
                continue
            d_hash = compute_dataset_hash(inserts)
            if d_hash not in unique_datasets:
                tables_pop = set(extract_table_from_insert(stmt) for stmt in inserts)
                tables_pop.discard("")
                unique_datasets[d_hash] = {
                    "sig_hash": d_hash,
                    "insert_statements": inserts,
                    "dataset_sql": "\n".join(inserts),
                    "strategy_name": ds["strategy_name"],
                    "tags": ds["tags"],
                    "source_query_id": qid,
                    "source_query_type": qtype,
                    "source_instance_id": iid,
                    "schema_id": sid,
                    "tables_populated": tables_pop
                }

            if d_hash not in query_dataset_hashes[qid]:
                query_dataset_hashes[qid].append(d_hash)
            schema_dataset_hashes[sid].add(d_hash)
            instance_dataset_hashes[iid].add(d_hash)

    t_gen_elapsed = time.time() - t_gen_start
    total_generated_datasets = sum(int(r["num_datasets"]) for r in datagen_csv_rows)
    logger.info(f"Phase 1 Complete in {t_gen_elapsed:.2f}s!")
    logger.info(f"  Total datasets generated: {total_generated_datasets}")
    logger.info(f"  Total unique datasets after order-preserving deduplication: {len(unique_datasets)}")
    dedup_ratio = (1.0 - len(unique_datasets) / max(1, total_generated_datasets)) * 100.0
    logger.info(f"  Deduplication redundancy elimination: {dedup_ratio:.1f}%")

    # Save consolidated materialized datasets to output_dir
    materialized_datasets_file = os.path.join(output_dir, 'materialized_datasets.json')
    with open(materialized_datasets_file, 'w', encoding='utf-8') as f:
        json.dump({
            d_hash: {
                "sig_hash": ds["sig_hash"],
                "insert_statements": ds["insert_statements"],
                "strategy_name": ds["strategy_name"],
                "tags": ds["tags"],
                "source_query_id": ds["source_query_id"],
                "source_query_type": ds["source_query_type"],
                "source_instance_id": ds["source_instance_id"],
                "schema_id": ds["schema_id"],
                "tables_populated": sorted(list(ds["tables_populated"]))
            }
            for d_hash, ds in unique_datasets.items()
        }, f, indent=2)
    logger.info(f"Materialized {len(unique_datasets)} unique datasets to {materialized_datasets_file}")

    # 4. TESTING HARNESS ACROSS 4 LEVELS WITH MINIMIZATION AND TIMING
    logger.info("--------------------------------------------------------------------------------")
    logger.info("Phase 2: Evaluating 4 Cross-Checking Levels with Sound Minimization...")
    t_eval_start = time.time()

    # Initialize state for each pair
    # pair_key = (instance_id, prediction_id)
    pair_states = {}
    for p in pairs_list:
        pkey = (p["instance_id"], p["prediction_id"])
        pair_states[pkey] = {
            "instance_id": p["instance_id"],
            "prediction_id": p["prediction_id"],
            "schema_id": p["schema_id"],
            "gold_sql": p["gold_sql"],
            "pred_sql": p["pred_sql"],
            "pair_tables": p["pair_tables"],
            "gold_query_id": p["gold_query_id"],
            "level1_status": "EQ",
            "level2_status": "EQ",
            "level3_status": "EQ",
            "level4_status": "EQ",
            "first_killed_level": None,
            "killing_dataset_hash": "",
            "killing_dataset_source": "",
            "killing_dataset_instance": "",
            "killing_strategy": "",
            "killing_reason": "",
            "time_taken": 0.0,
            "num_evaluations": 0
        }

    # Group pairs by instance
    inst_to_pairs = defaultdict(list)
    for p in pairs_list:
        inst_to_pairs[p["instance_id"]].append(p)

    # -------------------------------------------------------------------------
    # LEVEL 1: Gold-Only Data Generation
    # -------------------------------------------------------------------------
    t_l1_start = time.time()
    logger.info("Running Level 1: Gold-Only Datasets...")
    unrefuted_pairs_l1 = set(pair_states.keys())

    for inst_id, pairs in inst_to_pairs.items():
        gold_qid = f"{inst_id}_gold"
        gold_d_hashes = query_dataset_hashes.get(gold_qid, [])
        if not gold_d_hashes:
            continue

        schema_id = pairs[0]["schema_id"]
        ddl = schemas_data[schema_id]["ddl"]
        gold_sql = pairs[0]["gold_sql"]

        active_pairs = [p for p in pairs if (p["instance_id"], p["prediction_id"]) in unrefuted_pairs_l1]
        if not active_pairs:
            continue

        for d_hash in gold_d_hashes:
            if not active_pairs:
                break
            ds_obj = unique_datasets[d_hash]
            dataset_sql = ds_obj["dataset_sql"]
            pred_sqls = [p["pred_sql"] for p in active_pairs]

            t_batch_start = time.time()
            with open(os.devnull, 'w') as devnull, contextlib.redirect_stdout(devnull):
                test_results = execution_test_batch(
                    schema=ddl,
                    dataset=dataset_sql,
                    gold_sql=gold_sql,
                    prediction_sqls=pred_sqls,
                    dialect=args.dialect
                )
            batch_duration = time.time() - t_batch_start

            per_pair_time = batch_duration / max(1, len(pred_sqls))
            for p in active_pairs:
                pkey = (p["instance_id"], p["prediction_id"])
                pair_states[pkey]["time_taken"] += per_pair_time
                pair_states[pkey]["num_evaluations"] += 1

            survived_pairs = []
            for i, res in enumerate(test_results):
                p = active_pairs[i]
                pkey = (p["instance_id"], p["prediction_id"])
                status = res.get("status", "UNKNOWN")
                err_msg = res.get("error_message", "")

                if is_refuted_status(status, err_msg):
                    # Refuted in Level 1!
                    pair_states[pkey]["level1_status"] = status
                    pair_states[pkey]["level2_status"] = status
                    pair_states[pkey]["level3_status"] = status
                    pair_states[pkey]["level4_status"] = status
                    pair_states[pkey]["first_killed_level"] = "level1"
                    pair_states[pkey]["killing_dataset_hash"] = d_hash
                    pair_states[pkey]["killing_dataset_source"] = "gold"
                    pair_states[pkey]["killing_dataset_instance"] = inst_id
                    pair_states[pkey]["killing_strategy"] = ds_obj["strategy_name"]
                    pair_states[pkey]["killing_reason"] = res.get("reason", status)
                    unrefuted_pairs_l1.remove(pkey)
                else:
                    survived_pairs.append(p)
            active_pairs = survived_pairs

    t_l1_elapsed = time.time() - t_l1_start
    l1_killed = len(pairs_list) - len(unrefuted_pairs_l1)
    logger.info(f"Level 1 Complete in {t_l1_elapsed:.2f}s: {l1_killed}/{len(pairs_list)} refuted ({l1_killed/len(pairs_list)*100.0:.1f}%)")

    # -------------------------------------------------------------------------
    # LEVEL 2: Pairwise Gold + Prediction Datasets
    # -------------------------------------------------------------------------
    t_l2_start = time.time()
    logger.info("Running Level 2: Pairwise Gold + Pred Datasets (testing unrefuted pairs on mutant datasets)...")
    unrefuted_pairs_l2 = set(unrefuted_pairs_l1)

    for pkey in list(unrefuted_pairs_l2):
        st = pair_states[pkey]
        pred_qid = st["prediction_id"]
        inst_id = st["instance_id"]
        gold_qid = f"{inst_id}_gold"

        gold_d_hashes = set(query_dataset_hashes.get(gold_qid, []))
        pred_d_hashes = query_dataset_hashes.get(pred_qid, [])

        # Marginal datasets: in Pred but not in Gold
        marginal_hashes = [h for h in pred_d_hashes if h not in gold_d_hashes]
        if not marginal_hashes:
            continue

        schema_id = st["schema_id"]
        ddl = schemas_data[schema_id]["ddl"]
        gold_sql = st["gold_sql"]
        pred_sql = st["pred_sql"]

        for d_hash in marginal_hashes:
            ds_obj = unique_datasets[d_hash]
            dataset_sql = ds_obj["dataset_sql"]

            t_batch_start = time.time()
            with open(os.devnull, 'w') as devnull, contextlib.redirect_stdout(devnull):
                test_results = execution_test_batch(
                    schema=ddl,
                    dataset=dataset_sql,
                    gold_sql=gold_sql,
                    prediction_sqls=[pred_sql],
                    dialect=args.dialect
                )
            batch_duration = time.time() - t_batch_start

            pair_states[pkey]["time_taken"] += batch_duration
            pair_states[pkey]["num_evaluations"] += 1

            res = test_results[0]
            status = res.get("status", "UNKNOWN")
            err_msg = res.get("error_message", "")

            if is_refuted_status(status, err_msg):
                # Refuted in Level 2!
                pair_states[pkey]["level2_status"] = status
                pair_states[pkey]["level3_status"] = status
                pair_states[pkey]["level4_status"] = status
                pair_states[pkey]["first_killed_level"] = "level2"
                pair_states[pkey]["killing_dataset_hash"] = d_hash
                pair_states[pkey]["killing_dataset_source"] = "pred_own"
                pair_states[pkey]["killing_dataset_instance"] = inst_id
                pair_states[pkey]["killing_strategy"] = ds_obj["strategy_name"]
                pair_states[pkey]["killing_reason"] = res.get("reason", status)
                unrefuted_pairs_l2.remove(pkey)
                break

    t_l2_elapsed = time.time() - t_l2_start
    l2_killed = len(pairs_list) - len(unrefuted_pairs_l2)
    l2_delta = l2_killed - l1_killed
    logger.info(f"Level 2 Complete in {t_l2_elapsed:.2f}s: {l2_killed}/{len(pairs_list)} refuted ({l2_killed/len(pairs_list)*100.0:.1f}%), Delta gain: +{l2_delta}")

    # -------------------------------------------------------------------------
    # LEVEL 3: Instance Pool (Gold + All Sibling Predictions in Instance)
    # -------------------------------------------------------------------------
    t_l3_start = time.time()
    logger.info("Running Level 3: Instance Pool Datasets (testing remaining unrefuted on sibling mutant datasets)...")
    unrefuted_pairs_l3 = set(unrefuted_pairs_l2)

    for inst_id, pairs in inst_to_pairs.items():
        active_pairs = [p for p in pairs if (p["instance_id"], p["prediction_id"]) in unrefuted_pairs_l3]
        if not active_pairs:
            continue

        schema_id = pairs[0]["schema_id"]
        ddl = schemas_data[schema_id]["ddl"]
        gold_sql = pairs[0]["gold_sql"]
        gold_qid = f"{inst_id}_gold"
        gold_d_hashes = set(query_dataset_hashes.get(gold_qid, []))

        all_inst_d_hashes = [h for h in instance_dataset_hashes.get(inst_id, set()) if h not in gold_d_hashes]
        if not all_inst_d_hashes:
            continue

        for d_hash in all_inst_d_hashes:
            if not active_pairs:
                break
            preds_to_test = [p for p in active_pairs if d_hash not in query_dataset_hashes.get(p["prediction_id"], [])]
            if not preds_to_test:
                continue

            ds_obj = unique_datasets[d_hash]
            dataset_sql = ds_obj["dataset_sql"]
            pred_sqls = [p["pred_sql"] for p in preds_to_test]

            t_batch_start = time.time()
            with open(os.devnull, 'w') as devnull, contextlib.redirect_stdout(devnull):
                test_results = execution_test_batch(
                    schema=ddl,
                    dataset=dataset_sql,
                    gold_sql=gold_sql,
                    prediction_sqls=pred_sqls,
                    dialect=args.dialect
                )
            batch_duration = time.time() - t_batch_start

            per_pair_time = batch_duration / max(1, len(pred_sqls))
            for p in preds_to_test:
                pkey = (p["instance_id"], p["prediction_id"])
                pair_states[pkey]["time_taken"] += per_pair_time
                pair_states[pkey]["num_evaluations"] += 1

            survived_pairs = []
            for i, res in enumerate(test_results):
                p = preds_to_test[i]
                pkey = (p["instance_id"], p["prediction_id"])
                status = res.get("status", "UNKNOWN")
                err_msg = res.get("error_message", "")

                if is_refuted_status(status, err_msg):
                    # Refuted in Level 3!
                    pair_states[pkey]["level3_status"] = status
                    pair_states[pkey]["level4_status"] = status
                    pair_states[pkey]["first_killed_level"] = "level3"
                    pair_states[pkey]["killing_dataset_hash"] = d_hash
                    pair_states[pkey]["killing_dataset_source"] = "pred_sibling"
                    pair_states[pkey]["killing_dataset_instance"] = inst_id
                    pair_states[pkey]["killing_strategy"] = ds_obj["strategy_name"]
                    pair_states[pkey]["killing_reason"] = res.get("reason", status)
                    unrefuted_pairs_l3.remove(pkey)
                else:
                    survived_pairs.append(p)

            survived_keys = set((p["instance_id"], p["prediction_id"]) for p in survived_pairs)
            untested = [p for p in active_pairs if p not in preds_to_test]
            active_pairs = [p for p in active_pairs if (p["instance_id"], p["prediction_id"]) in survived_keys or p in untested]

    t_l3_elapsed = time.time() - t_l3_start
    l3_killed = len(pairs_list) - len(unrefuted_pairs_l3)
    l3_delta = l3_killed - l2_killed
    logger.info(f"Level 3 Complete in {t_l3_elapsed:.2f}s: {l3_killed}/{len(pairs_list)} refuted ({l3_killed/len(pairs_list)*100.0:.1f}%), Delta gain: +{l3_delta}")

    # -------------------------------------------------------------------------
    # LEVEL 4: Cross-Instance Schema Pool (All Queries on the Same Schema)
    # -------------------------------------------------------------------------
    t_l4_start = time.time()
    logger.info("Running Level 4: Cross-Instance Schema Pool Datasets (testing remaining unrefuted on other instances)...")
    unrefuted_pairs_l4 = set(unrefuted_pairs_l3)

    for schema_id, schema_insts in schema_to_instances.items():
        schema_d_hashes = schema_dataset_hashes.get(schema_id, set())
        ddl = schemas_data[schema_id]["ddl"]

        inst_unrefuted = defaultdict(list)
        for pkey in list(unrefuted_pairs_l4):
            if pair_states[pkey]["schema_id"] == schema_id:
                inst_unrefuted[pair_states[pkey]["instance_id"]].append(pair_states[pkey])

        for inst_id, active_pairs in inst_unrefuted.items():
            inst_hashes = instance_dataset_hashes.get(inst_id, set())
            marginal_hashes = [h for h in schema_d_hashes if h not in inst_hashes]
            if not marginal_hashes:
                continue

            gold_sql = active_pairs[0]["gold_sql"]
            remaining_active = list(active_pairs)

            for d_hash in marginal_hashes:
                if not remaining_active:
                    break

                ds_obj = unique_datasets[d_hash]
                ds_tables = ds_obj["tables_populated"]

                preds_to_test = []
                for p_st in remaining_active:
                    pair_tables = p_st["pair_tables"]
                    if pair_tables and ds_tables and not (ds_tables & pair_tables):
                        continue
                    preds_to_test.append(p_st)

                if not preds_to_test:
                    continue

                dataset_sql = ds_obj["dataset_sql"]
                pred_sqls = [p["pred_sql"] for p in preds_to_test]

                t_batch_start = time.time()
                with open(os.devnull, 'w') as devnull, contextlib.redirect_stdout(devnull):
                    test_results = execution_test_batch(
                        schema=ddl,
                        dataset=dataset_sql,
                        gold_sql=gold_sql,
                        prediction_sqls=pred_sqls,
                        dialect=args.dialect
                    )
                batch_duration = time.time() - t_batch_start

                per_pair_time = batch_duration / max(1, len(pred_sqls))
                for p_st in preds_to_test:
                    pkey = (p_st["instance_id"], p_st["prediction_id"])
                    pair_states[pkey]["time_taken"] += per_pair_time
                    pair_states[pkey]["num_evaluations"] += 1

                survived = []
                for i, res in enumerate(test_results):
                    p_st = preds_to_test[i]
                    pkey = (p_st["instance_id"], p_st["prediction_id"])
                    status = res.get("status", "UNKNOWN")
                    err_msg = res.get("error_message", "")

                    if is_refuted_status(status, err_msg):
                        # Refuted in Level 4!
                        src_qtype = ds_obj["source_query_type"]
                        ds_source_label = "cross_instance_gold" if src_qtype == "gold" else "cross_instance_pred"
                        pair_states[pkey]["level4_status"] = status
                        pair_states[pkey]["first_killed_level"] = "level4"
                        pair_states[pkey]["killing_dataset_hash"] = d_hash
                        pair_states[pkey]["killing_dataset_source"] = ds_source_label
                        pair_states[pkey]["killing_dataset_instance"] = ds_obj["source_instance_id"]
                        pair_states[pkey]["killing_strategy"] = ds_obj["strategy_name"]
                        pair_states[pkey]["killing_reason"] = res.get("reason", status)
                        unrefuted_pairs_l4.remove(pkey)
                    else:
                        survived.append(p_st)

                survived_keys = set((p["instance_id"], p["prediction_id"]) for p in survived)
                untested = [p for p in remaining_active if p not in preds_to_test]
                remaining_active = [p for p in remaining_active if (p["instance_id"], p["prediction_id"]) in survived_keys or p in untested]

    t_l4_elapsed = time.time() - t_l4_start
    l4_killed = len(pairs_list) - len(unrefuted_pairs_l4)
    l4_delta = l4_killed - l3_killed
    t_eval_elapsed = time.time() - t_eval_start
    logger.info(f"Level 4 Complete in {t_l4_elapsed:.2f}s: {l4_killed}/{len(pairs_list)} refuted ({l4_killed/len(pairs_list)*100.0:.1f}%), Delta gain: +{l4_delta}")
    logger.info(f"Phase 2 Complete in {t_eval_elapsed:.2f}s!")

    # -------------------------------------------------------------------------
    # 5. COMPREHENSIVE ANALYSIS & REPORTING
    # -------------------------------------------------------------------------
    logger.info("--------------------------------------------------------------------------------")
    logger.info("Phase 3: Synthesizing Experimental Results...")

    total_pairs = len(pairs_list)
    r1_pct = (l1_killed / total_pairs) * 100.0
    r2_pct = (l2_killed / total_pairs) * 100.0
    r3_pct = (l3_killed / total_pairs) * 100.0
    r4_pct = (l4_killed / total_pairs) * 100.0

    # Source breakdown of kills
    source_counts = Counter(st["killing_dataset_source"] for st in pair_states.values() if st["killing_dataset_source"])

    # Schema-level breakdown
    schema_stats = defaultdict(lambda: {"total": 0, "l1": 0, "l2": 0, "l3": 0, "l4": 0})
    for st in pair_states.values():
        sid = st["schema_id"]
        schema_stats[sid]["total"] += 1
        if is_refuted_status(st["level1_status"]):
            schema_stats[sid]["l1"] += 1
        if is_refuted_status(st["level2_status"]):
            schema_stats[sid]["l2"] += 1
        if is_refuted_status(st["level3_status"]):
            schema_stats[sid]["l3"] += 1
        if is_refuted_status(st["level4_status"]):
            schema_stats[sid]["l4"] += 1

    # PRINT SUMMARY TABLES TO CONSOLE
    print("\n" + "=" * 105)
    print("                      CROSS-CHECKING EXPERIMENT RESULTS SUMMARY                       ")
    print("=" * 105)
    print(f"Sample Scope : {len(sampled_instances)} BIRD Instances | {len(schema_to_instances)} Schemas | {total_pairs} Query Pairs")
    print("-" * 105)
    print(f"{'Evaluation Level':<32} | {'Scope Description':<25} | {'Killed':<8} | {'Rate':<7} | {'Delta Gain':<13} | {'Eval Time':<10}")
    print("-" * 105)
    print(f"{'Level 1: Gold-Only':<32} | {'Datasets from Q_gold':<25} | {l1_killed:<8} | {r1_pct:>5.1f}% | {'--':<13} | {f'{t_l1_elapsed:.2f}s':<10}")
    print(f"{'Level 2: Pairwise Gold+Pred':<32} | {'Q_gold + Q_pred (2-way)':<25} | {l2_killed:<8} | {r2_pct:>5.1f}% | {f'+{l2_delta} (+{l2_delta/total_pairs*100:.1f}%)':<13} | {f'{t_l2_elapsed:.2f}s':<10}")
    print(f"{'Level 3: Instance Pool':<32} | {'All Q_pred in instance':<25} | {l3_killed:<8} | {r3_pct:>5.1f}% | {f'+{l3_delta} (+{l3_delta/total_pairs*100:.1f}%)':<13} | {f'{t_l3_elapsed:.2f}s':<10}")
    print(f"{'Level 4: Cross-Instance Pool':<32} | {'All queries in schema':<25} | {l4_killed:<8} | {r4_pct:>5.1f}% | {f'+{l4_delta} (+{l4_delta/total_pairs*100:.1f}%)':<13} | {f'{t_l4_elapsed:.2f}s':<10}")
    print("-" * 105)
    net_gain = l4_killed - l1_killed
    net_gain_pct = (net_gain / total_pairs) * 100.0
    print(f"Total Net Increase from Full Cross-Checking (Level 4 vs Level 1): +{net_gain} pairs refuted (+{net_gain_pct:.1f}% absolute gain)")
    print("=" * 105)

    print("\n" + "-" * 70)
    print("MUTANT KILLS BY DATASET ORIGIN (WHERE FIRST KILLED)")
    print("-" * 70)
    print(f"  * Gold Query Datasets (Level 1)                     : {source_counts.get('gold', 0):>4} ({source_counts.get('gold', 0)/total_pairs*100:.1f}%)")
    print(f"  * Own Mutant Datasets (Level 2)                      : {source_counts.get('pred_own', 0):>4} ({source_counts.get('pred_own', 0)/total_pairs*100:.1f}%)")
    print(f"  * Sibling Mutant Datasets in Same Instance (Level 3) : {source_counts.get('pred_sibling', 0):>4} ({source_counts.get('pred_sibling', 0)/total_pairs*100:.1f}%)")
    print(f"  * Cross-Instance Gold Datasets (Level 4)             : {source_counts.get('cross_instance_gold', 0):>4} ({source_counts.get('cross_instance_gold', 0)/total_pairs*100:.1f}%)")
    print(f"  * Cross-Instance Mutant Datasets (Level 4)           : {source_counts.get('cross_instance_pred', 0):>4} ({source_counts.get('cross_instance_pred', 0)/total_pairs*100:.1f}%)")
    print(f"  * Unrefuted / Survived Across All Levels             : {len(unrefuted_pairs_l4):>4} ({len(unrefuted_pairs_l4)/total_pairs*100:.1f}%)")
    print("-" * 70)

    avg_eval_time = sum(st["time_taken"] for st in pair_states.values()) / max(1, total_pairs)
    print("\n" + "-" * 70)
    print("EXECUTION TIMING & EFFICIENCY")
    print("-" * 70)
    print(f"  * Total Generated Datasets              : {total_generated_datasets}")
    print(f"  * Datagen Time                          : {t_gen_elapsed:.2f}s")
    print(f"  * Execution Testing Time (Total)        : {t_eval_elapsed:.2f}s")
    print(f"      - Level 1 Eval Time                 : {t_l1_elapsed:.2f}s")
    print(f"      - Level 2 Eval Time                 : {t_l2_elapsed:.2f}s")
    print(f"      - Level 3 Eval Time                 : {t_l3_elapsed:.2f}s")
    print(f"      - Level 4 Eval Time                 : {t_l4_elapsed:.2f}s")
    print(f"  * Average Eval Time per Query Pair      : {avg_eval_time:.4f}s")
    print("-" * 70)

    print("\n" + "-" * 85)
    print(f"{'Schema Name':<28} | {'Pairs':<6} | {'Level 1':<8} | {'Level 2':<8} | {'Level 3':<8} | {'Level 4':<8} | {'Gain':<6}")
    print("-" * 85)
    for sid, st in sorted(schema_stats.items(), key=lambda x: x[1]["total"], reverse=True):
        gain = st["l4"] - st["l1"]
        print(f"{sid:<28} | {st['total']:<6} | {st['l1']:<8} | {st['l2']:<8} | {st['l3']:<8} | {st['l4']:<8} | {f'+{gain}':<6}")
    print("-" * 85)

    # 6. EXPORT CSV ARTIFACTS
    # 6a. Level Summary CSV
    summary_csv_path = os.path.join(output_dir, 'cross_checking_summary.csv')
    with open(summary_csv_path, 'w', newline='', encoding='utf-8') as f:
        writer = csv.writer(f)
        writer.writerow(["level", "description", "killed_pairs", "total_pairs", "refutation_rate_pct", "marginal_gain", "marginal_gain_pct", "eval_time_seconds"])
        writer.writerow(["level1", "Gold-Only Datasets", l1_killed, total_pairs, f"{r1_pct:.2f}", 0, "0.00", f"{t_l1_elapsed:.3f}"])
        writer.writerow(["level2", "Pairwise Gold+Pred", l2_killed, total_pairs, f"{r2_pct:.2f}", l2_delta, f"{l2_delta/total_pairs*100:.2f}", f"{t_l2_elapsed:.3f}"])
        writer.writerow(["level3", "Instance Pool", l3_killed, total_pairs, f"{r3_pct:.2f}", l3_delta, f"{l3_delta/total_pairs*100:.2f}", f"{t_l3_elapsed:.3f}"])
        writer.writerow(["level4", "Cross-Instance Schema Pool", l4_killed, total_pairs, f"{r4_pct:.2f}", l4_delta, f"{l4_delta/total_pairs*100:.2f}", f"{t_l4_elapsed:.3f}"])

    # 6b. Detailed Pairs CSV
    pairs_csv_path = os.path.join(output_dir, 'cross_checking_pairs.csv')
    pairs_fieldnames = [
        "instance_id", "prediction_id", "schema_id",
        "level1_status", "level2_status", "level3_status", "level4_status",
        "first_killed_level", "killing_dataset_source", "killing_dataset_instance",
        "killing_strategy", "killing_reason", "killing_dataset_hash",
        "time_taken", "num_evaluations"
    ]
    with open(pairs_csv_path, 'w', newline='', encoding='utf-8') as f:
        writer = csv.DictWriter(f, fieldnames=pairs_fieldnames)
        writer.writeheader()
        for pkey, st in pair_states.items():
            writer.writerow({
                "instance_id": st["instance_id"],
                "prediction_id": st["prediction_id"],
                "schema_id": st["schema_id"],
                "level1_status": st["level1_status"],
                "level2_status": st["level2_status"],
                "level3_status": st["level3_status"],
                "level4_status": st["level4_status"],
                "first_killed_level": st["first_killed_level"] or "unrefuted",
                "killing_dataset_source": st["killing_dataset_source"],
                "killing_dataset_instance": st["killing_dataset_instance"],
                "killing_strategy": st["killing_strategy"],
                "killing_reason": st["killing_reason"],
                "killing_dataset_hash": st["killing_dataset_hash"],
                "time_taken": f"{st['time_taken']:.4f}",
                "num_evaluations": st["num_evaluations"]
            })

    # 6c. Schema Stats CSV
    schemas_csv_path = os.path.join(output_dir, 'cross_checking_schemas.csv')
    with open(schemas_csv_path, 'w', newline='', encoding='utf-8') as f:
        writer = csv.writer(f)
        writer.writerow(["schema_id", "total_pairs", "level1_killed", "level2_killed", "level3_killed", "level4_killed", "net_gain"])
        for sid, st in sorted(schema_stats.items(), key=lambda x: x[1]["total"], reverse=True):
            writer.writerow([sid, st["total"], st["l1"], st["l2"], st["l3"], st["l4"], st["l4"] - st["l1"]])

    # 6d. Datagen CSV
    datagen_csv_path = os.path.join(output_dir, 'cross_checking_datagen.csv')
    datagen_fields = ["instance_id", "query_id", "query_type", "schema_id", "data_gen_time", "num_datasets", "attack_strategies", "error_message"]
    with open(datagen_csv_path, 'w', newline='', encoding='utf-8') as f:
        writer = csv.DictWriter(f, fieldnames=datagen_fields)
        writer.writeheader()
        writer.writerows(datagen_csv_rows)

    logger.info("All CSV reports exported to:")
    logger.info(f"  - Summary               : {summary_csv_path}")
    logger.info(f"  - Pair Details          : {pairs_csv_path}")
    logger.info(f"  - Schemas               : {schemas_csv_path}")
    logger.info(f"  - Datagen               : {datagen_csv_path}")
    logger.info(f"  - Materialized Datasets : {materialized_datasets_file}")
    logger.info("Evaluation study finished successfully!")


if __name__ == '__main__':
    main()


