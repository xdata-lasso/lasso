"""
Lasso Test-Data Generator Main Module
====================================

CLI entry point and test harness for the Lasso SQL semantic test data generation system.
Orchestrates schema parsing, AST parsing, attack strategy execution, dataset generation,
and execution testing against candidate mutant queries.
"""

import importlib
import inspect
import pkgutil
import hashlib
import os
import sys
import time
import contextlib
import functools

sql_tester_path = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'sql-execution-tester')
if sql_tester_path not in sys.path:
    sys.path.insert(0, sql_tester_path)

try:
    from execution_tester import execution_test_batch
except ImportError:
    execution_test_batch = None

from models import Dataset
from dataset_generator.value_generator import DataFactory
from parser import parse_sql_to_ast, parse_ddl_to_schema
from sql_serializer import generate_inserts
from dataset_generator.augmentation import repair_orphan_rows
from attacks.base import AttackStrategy
import attacks


@functools.lru_cache(maxsize=None)
def load_attacks() -> list[AttackStrategy]:
    """
    Dynamically load any attack strategy placed in the attacks/ folder.
    """
    strategies = []
    for _, module_name, _ in pkgutil.iter_modules(attacks.__path__):
        module = importlib.import_module(f"attacks.{module_name}")
        for name, obj in inspect.getmembers(module, inspect.isclass):
            if (
                issubclass(obj, AttackStrategy)
                and not inspect.isabstract(obj)
                and obj.__module__ == module.__name__
            ):
                strategies.append(obj())
    return strategies



from dataset_generator import clear_dataset_cache, ensure_dataset_uniqueness, generate_base_dataset
from z3_solver import clear_z3_cache

def generate_test_data(ddl_string: str, query_string: str, seed: int = 42) -> list[Dataset]:
    """
    Main orchestration function to generate datasets for a query.
    """
    schema = parse_ddl_to_schema(ddl_string)
    parsed_query = parse_sql_to_ast(query_string)
    loaded_attacks = load_attacks()
    
    DataFactory.get_instance().reset(seed)
    clear_z3_cache()
    
    results = []

    # Unconditionally generate the base dataset
    DataFactory.get_instance().clear_uniqueness()
    try:
        base_data = generate_base_dataset(schema, parsed_query)
        base_ds = Dataset(
            strategy_name="BaseDatasetStrategy",
            data=base_data,
            tags=["base_dataset"],
            description="Attempts to yield a non-empty result for the query to establish a standard baseline state."
        )
        base_ds.data = ensure_dataset_uniqueness(schema, base_ds.data)
        repair_orphan_rows(schema, base_ds.data)
        base_ds.insert_statements = generate_inserts(schema, base_ds)
        results.append(base_ds)
    except Exception as e:
        print(f"Base dataset generation failed: {e}")

    for strategy in loaded_attacks:
        if strategy.is_applicable(schema, parsed_query):
            DataFactory.get_instance().clear_uniqueness()
            
            try:
                ds_list = strategy.generate(schema, parsed_query)
                for dataset in ds_list:
                    # 1. Uniqueness (Ensure unique constraints are satisfied)
                    dataset.data = ensure_dataset_uniqueness(schema, dataset.data)
                    # 2. Augmentation (Repair orphan rows for FKs)
                    repair_orphan_rows(schema, dataset.data)
                    # 3. Serialization (Generate INSERTs)
                    dataset.insert_statements = generate_inserts(schema, dataset)
                results.extend(ds_list)
            except Exception as e:
                # Log the error and continue
                print(f"Strategy {strategy.__class__.__name__} failed: {e}")
            
    # Deduplicate datasets based on exact insert statements
    unique_datasets = {}
    for ds in results:
        signature = tuple(sorted(ds.insert_statements))
        if signature in unique_datasets:
            existing = unique_datasets[signature]
            if ds.strategy_name not in existing.strategy_name:
                existing.strategy_name += f", {ds.strategy_name}"
            for tag in ds.tags:
                if tag not in existing.tags:
                    existing.tags.append(tag)
        else:
            unique_datasets[signature] = ds

    def is_base_dataset(ds: Dataset) -> bool:
        return "base_dataset" in ds.tags or "BaseDatasetStrategy" in ds.strategy_name

    base_datasets = [ds for ds in unique_datasets.values() if is_base_dataset(ds)]
    other_datasets = [ds for ds in unique_datasets.values() if not is_base_dataset(ds)]
    return base_datasets + other_datasets


def generate_test_data_with_meta(ddl_string: str, query_string: str) -> tuple[list[Dataset], dict]:
    """
    Orchestration function to generate datasets for a query and return metadata (timing, strategy names, errors).
    """
    start_time = time.time()
    err_msg = ""
    datasets = []
    try:
        datasets = generate_test_data(ddl_string, query_string)
    except Exception as e:
        err_msg = str(e)
    data_gen_time = time.time() - start_time
    
    strategies = set()
    for ds in datasets:
        for s in ds.strategy_name.split(", "):
            if s.strip():
                strategies.add(s.strip())
                
    meta = {
        "data_gen_time": data_gen_time,
        "num_datasets": len(datasets),
        "attack_strategies": "; ".join(sorted(strategies)),
        "error_message": err_msg
    }
    return datasets, meta


def evaluate_predictions(ddl_string: str, gold_query: str, prediction_queries: dict[str, str], dialect: str = "sqlite") -> dict:
    """
    Evaluates prediction queries against a gold query by generating test datasets.
    It first generates datasets from the gold query, and if a prediction is not refuted,
    it generates datasets from unrefuted prediction queries to try and refute them.
    
    Returns the execution test results along with details of the dataset that killed it,
    tags, source of the dataset, and total data generation time.
    """
    if execution_test_batch is None:
        return {"error": "Failed to import execution_tester"}

    norm_gold_query = gold_query
    normalized_predictions = {pred_id: q for pred_id, q in prediction_queries.items()}

    generation_time = 0.0
    num_generated_datasets = 0
    
    results = {
        "total_predictions": len(prediction_queries),
        "predictions": {}
    }
    
    pred_states = {}
    for pred_id, q in prediction_queries.items():
        pred_states[pred_id] = {
            "prediction_id": pred_id,
            "query": q,
            "normalized_query": normalized_predictions[pred_id],
            "status": "unrefuted",
            "details": {"refuted": False}
        }
        
    def get_unrefuted_ids():
        pids = []
        for pid, state in pred_states.items():
            if not state["details"]["refuted"]:
                pids.append(pid)
            elif not bool(state["details"].get("execution_result", {}).get("gold_sql_result")):
                pids.append(pid)
        return pids
        
    execution_cache = {} # (dataset_sql, query_sql) -> result
    
    def test_dataset_on_queries(dataset, source_name, ds_idx, pids_to_test):
        dataset_sql = "\n".join(dataset.insert_statements)
        
        queries_to_run = []
        pids_to_run = []
        
        for pid in pids_to_test:
            q = pred_states[pid]["normalized_query"]
            if (dataset_sql, q) not in execution_cache:
                queries_to_run.append(q)
                pids_to_run.append(pid)
                
        if queries_to_run:
            with open(os.devnull, 'w') as devnull, contextlib.redirect_stdout(devnull):
                test_results = execution_test_batch(
                    schema=ddl_string,
                    dataset=dataset_sql,
                    gold_sql=norm_gold_query,
                    prediction_sqls=queries_to_run,
                    dialect=dialect
                )
            for i, res in enumerate(test_results):
                q = queries_to_run[i]
                execution_cache[(dataset_sql, q)] = res
                
        for pid in pids_to_test:
            q = pred_states[pid]["normalized_query"]
            res = execution_cache[(dataset_sql, q)]
            
            is_neq = res["status"].startswith("NEQ") or res["status"].startswith("ERROR")
            new_has_nonempty_gold = bool(res.get("gold_sql_result"))

            if is_neq:
                curr_refuted = pred_states[pid]["details"]["refuted"]
                curr_gold = pred_states[pid]["details"].get("execution_result", {}).get("gold_sql_result")
                curr_has_nonempty_gold = bool(curr_gold)

                if not curr_refuted or (not curr_has_nonempty_gold and new_has_nonempty_gold):
                    pred_states[pid]["status"] = res["status"]
                    pred_states[pid]["details"] = {
                        "refuted": True,
                        "dataset_source": source_name,
                        "dataset_strategy": dataset.strategy_name,
                        "dataset_tags": dataset.tags,
                        "dataset_idx": ds_idx,
                        "execution_result": res,
                        "dataset_sql": dataset_sql
                    }
            else:
                pred_states[pid]["status"] = res["status"]
                if "execution_result" not in pred_states[pid]["details"]:
                    pred_states[pid]["details"].update({
                        "dataset_source": source_name,
                        "dataset_strategy": dataset.strategy_name,
                        "dataset_tags": dataset.tags,
                        "dataset_idx": ds_idx,
                        "execution_result": res,
                        "dataset_sql": dataset_sql
                    })

    datasets_collection = []
    generated_for_pids = set()

    # 1. Gold query datasets
    start_gen = time.time()
    gold_datasets = generate_test_data(ddl_string, norm_gold_query)
    generation_time += time.time() - start_gen
    num_generated_datasets += len(gold_datasets)
    
    for ds_idx, dataset in enumerate(gold_datasets):
        unrefuted = get_unrefuted_ids()
        if not unrefuted:
            break
        test_dataset_on_queries(dataset, "gold_query", ds_idx, unrefuted)
    
    # Snapshot of results after only gold query datasets
    predictions_gold = {}
    for pid, state in pred_states.items():
        predictions_gold[pid] = {
            "prediction_id": state["prediction_id"],
            "query": state["query"],
            "status": state["status"],
            "details": state["details"].copy() if isinstance(state.get("details"), dict) else state.get("details")
        }
    results["predictions_gold"] = predictions_gold

    # 2. Unrefuted prediction queries
    unrefuted_to_try = get_unrefuted_ids()
    for pid in unrefuted_to_try:
        if pred_states[pid]["details"]["refuted"]:
            continue
            
        start_gen = time.time()
        try:
            pred_datasets = generate_test_data(ddl_string, pred_states[pid]["normalized_query"])
        except Exception:
            pred_datasets = []
        generation_time += time.time() - start_gen
        num_generated_datasets += len(pred_datasets)
        
        generated_for_pids.add(pid)
        
        for ds_idx, dataset in enumerate(pred_datasets):
            unrefuted = get_unrefuted_ids()
            if not unrefuted:
                break
            test_dataset_on_queries(dataset, f"prediction_query_{pid}", ds_idx, unrefuted)
            
            # If the current query was refuted, we can stop evaluating its remaining datasets early
            if pred_states[pid]["details"]["refuted"]:
                break

    # 3. Already refuted or not generated
    all_pids = list(pred_states.keys())
    for pid in all_pids:
        if pid not in generated_for_pids:
            start_gen = time.time()
            try:
                pred_datasets = generate_test_data(ddl_string, pred_states[pid]["normalized_query"])
            except Exception:
                pred_datasets = []
            generation_time += time.time() - start_gen
            num_generated_datasets += len(pred_datasets)
            
            for ds_idx, dataset in enumerate(pred_datasets):
                datasets_collection.append((dataset, f"prediction_query_{pid}", ds_idx))
                
    # 4. Check all remaining unrefuted against collected datasets
    for dataset, source_name, ds_idx in datasets_collection:
        unrefuted = get_unrefuted_ids()
        if not unrefuted:
            break
        test_dataset_on_queries(dataset, source_name, ds_idx, unrefuted)
            
    results["total_data_generation_time"] = generation_time
    results["num_generated_datasets"] = num_generated_datasets
    
    for pid, state in pred_states.items():
        results["predictions"][pid] = {
            "prediction_id": state["prediction_id"],
            "query": state["query"],
            "status": state["status"],
            "details": state["details"]
        }
        
    return results
