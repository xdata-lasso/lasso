import json
import logging
import argparse
from decimal import Decimal
import datetime

class BytesEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, bytes):
            return obj.decode('utf-8', errors='replace')
        if isinstance(obj, memoryview):
            return bytes(obj).decode('utf-8', errors='replace')
        if isinstance(obj, Decimal):
            return float(obj)
        if isinstance(obj, (datetime.date, datetime.datetime, datetime.time)):
            return obj.isoformat()
        return super().default(obj)
"""
Test runner for SQL semantic mutation testing.

Given a test case JSON with schema, correct query, and expected mutants,
this runner:
  1. Generates test datasets using attack strategies.
  2. For each (dataset, mutant) pair, uses execution_tester to check if
     the correct query and mutant query produce different results (NEQ).
  3. Reports which mutants were killed and which survived.
"""
import sys
import os
import json
import argparse
import logging
import contextlib

sys.path.insert(0, os.path.join(os.path.dirname(__file__), 'src'))
sys.path.insert(0, os.path.join(os.path.dirname(__file__), 'sql-execution-tester'))

from main import generate_test_data
from execution_tester import execution_test
from query_normalizer import normalize_sql

logger = logging.getLogger(__name__)


def _normalize_mutants(test_case: dict, dialect: str = "sqlite") -> list[dict]:
    """Extract mutant list from either test case format, prioritizing dialect-specific queries."""
    raw_list = []
    if "expected_semantic_errors_to_be_caught" in test_case:
        raw_list = test_case["expected_semantic_errors_to_be_caught"]
    elif "expected_mutants_to_kill" in test_case:
        raw_list = test_case["expected_mutants_to_kill"]
    elif "predictions" in test_case:
        raw_list = test_case["predictions"]

    mutants = []
    for m in raw_list:
        m_id = m.get("prediction_id", m.get("type", m.get("id")))
        if dialect in ("postgres", "postgresql"):
            q = (
                m.get("query_postgresql")
                or m.get("query_postgres")
                or m.get("prediction_sql_postgresql")
                or m.get("prediction_sql_postgres")
                or m.get("mutant_query_postgresql")
                or m.get("mutant_query_postgres")
                or m.get("mutant_query")
                or m.get("prediction_sql")
                or m.get("query")
            )
        else:
            q = (
                m.get(f"query_{dialect}")
                or m.get(f"prediction_sql_{dialect}")
                or m.get(f"mutant_query_{dialect}")
                or m.get("mutant_query")
                or m.get("prediction_sql")
                or m.get("query")
            )
        mutants.append({"id": m_id, "query": q})
    return mutants


def run_test_case(test_case: dict, debug: bool = False, dialect_override: str = None) -> dict:
    dialect = dialect_override or test_case.get("dialect", "sqlite")

    if dialect in ("postgres", "postgresql"):
        schema_ddl = (
            test_case.get("schema_postgresql")
            or test_case.get("schema_postgres")
            or test_case.get("ddl_postgres")
            or test_case.get("ddl_postgresql")
            or test_case.get("schema")
        )
        correct_query = (
            test_case.get("correct_query_postgresql")
            or test_case.get("correct_query_postgres")
            or test_case.get("gold_sql_postgresql")
            or test_case.get("gold_sql_postgres")
            or test_case.get("correct_query")
            or test_case.get("gold_sql")
        )
    else:
        schema_ddl = test_case.get(f"schema_{dialect}") or test_case.get("schema")
        correct_query = (
            test_case.get(f"correct_query_{dialect}")
            or test_case.get(f"gold_sql_{dialect}")
            or test_case.get("correct_query")
            or test_case.get("gold_sql")
        )

    if isinstance(schema_ddl, list):
        schema_ddl = "\n".join(schema_ddl)
    mutants = _normalize_mutants(test_case, dialect=dialect)

    # Normalize queries before data generation and testing
    try:
        norm_correct_query = normalize_sql(correct_query, schema_ddl, dialect=dialect, mock_time=True, augment_order=True)
    except Exception:
        norm_correct_query = correct_query

    for mutant in mutants:
        try:
            mutant["query"] = normalize_sql(mutant["query"], schema_ddl, dialect=dialect, mock_time=True, augment_order=True)
        except Exception:
            pass
    tc_id = test_case.get("id", "unknown")

    if debug:
        logger.info("Test case: %s", tc_id)
        logger.info("Schema:\n%s", schema_ddl)
        logger.info("Correct query: %s", correct_query)

    # Step 1: Generate datasets
    datasets = generate_test_data(schema_ddl, norm_correct_query)

    if debug:
        logger.info("Generated %d dataset(s)", len(datasets))
        for i, ds in enumerate(datasets, 1):
            logger.info("  Dataset %d [%s]: %s", i, ds.strategy_name, ds.description)
            for stmt in ds.insert_statements:
                logger.info("    %s", stmt)

    def _check_base_validity(query, query_datasets):
        base_ds_list = [ds for ds in query_datasets if "BaseDatasetStrategy" in ds.strategy_name]
        for ds in base_ds_list:
            ds_sql = "\n".join(ds.insert_statements)
            if not debug:
                with open(os.devnull, 'w') as devnull, contextlib.redirect_stdout(devnull):
                    res = execution_test(schema_ddl, ds_sql, query, query, dialect=dialect)
            else:
                res = execution_test(schema_ddl, ds_sql, query, query, dialect=dialect)
            if res.get("gold_sql_result") and len(res["gold_sql_result"]) > 0:
                return True
        return False

    gold_base_valid = _check_base_validity(norm_correct_query, datasets)
    
    mutant_base_valid = {}
    for mutant in mutants:
        try:
            m_datasets = generate_test_data(schema_ddl, mutant["query"])
            mutant_base_valid[mutant["id"]] = _check_base_validity(mutant["query"], m_datasets)
        except Exception:
            mutant_base_valid[mutant["id"]] = False

    # Step 2: For each mutant, check if any dataset kills it
    killed_mutants = set()
    kill_details = {}  # mutant_id -> {dataset_idx, reason, gold_sql_result, prediction_sql_result}
    alive_details = {} # mutant_id -> list of dicts with results per dataset

    for mutant in mutants:
        mutant_id = mutant["id"]
        mutant_query = mutant["query"]
        
        mutant_alive_results = []
        is_killed = False

        for i, dataset in enumerate(datasets, 1):
            dataset_sql = "\n".join(dataset.insert_statements)

            # Suppress stdout from compare_queries unless in debug mode
            if not debug:
                with open(os.devnull, 'w') as devnull, contextlib.redirect_stdout(devnull):
                    result = execution_test(
                        schema=schema_ddl,
                        dataset=dataset_sql,
                        gold_sql=norm_correct_query,
                        prediction_sql=mutant["query"],
                        dialect=dialect
                    )
            else:
                result = execution_test(
                    schema=schema_ddl,
                    dataset=dataset_sql,
                    gold_sql=norm_correct_query,
                    prediction_sql=mutant["query"],
                    dialect=dialect
                )

            status = result["status"]

            if debug:
                logger.info(
                    "  Mutant '%s' on dataset %d [%s]: %s (reason=%s)",
                    mutant_id, i, dataset.strategy_name, status,
                    result.get("reason", "-"),
                )
                if status.startswith("NEQ") or status.startswith("ERROR") or status == "EQ_EXEC":
                    logger.info("    Q1 result: %s", result.get("gold_sql_result"))
                    logger.info("    Q2 result: %s", result.get("prediction_sql_result"))
                if "error_message" in result:
                    logger.info("    Error: %s", result["error_message"])

            if status.startswith("NEQ") or (status.startswith("ERROR") and status != "ERROR_DATASET_LOADING"):
                killed_mutants.add(mutant_id)
                kill_details[mutant_id] = {
                    "dataset_idx": i,
                    "dataset_strategy": dataset.strategy_name,
                    "dataset_source": "correct_query",
                    "comparator_status": status,
                    "reason": result.get("reason"),
                    "gold_sql_result": _format_result(result.get("gold_sql_result")),
                    "prediction_sql_result": _format_result(result.get("prediction_sql_result")),
                }
                is_killed = True
                break  # Mutant killed, no need to test further datasets
            else:
                mutant_alive_results.append({
                    "dataset_idx": i,
                    "dataset_strategy": dataset.strategy_name,
                    "dataset_source": "correct_query",
                    "comparator_status": status,
                    "gold_sql_result": _format_result(result.get("gold_sql_result")),
                    "prediction_sql_result": _format_result(result.get("prediction_sql_result")),
                })

        # Two-way data generation: if mutant survived, generate datasets using the mutant query
        if not is_killed:
            try:
                mutant_datasets = generate_test_data(schema_ddl, mutant["query"])
            except Exception as e:
                if debug:
                    logger.warning("  Error generating datasets for mutant '%s': %s", mutant_id, e)
                mutant_datasets = []

            for i, dataset in enumerate(mutant_datasets, 1):
                dataset_sql = "\n".join(dataset.insert_statements)
                if not debug:
                    with open(os.devnull, 'w') as devnull, contextlib.redirect_stdout(devnull):
                        result = execution_test(
                            schema=schema_ddl,
                            dataset=dataset_sql,
                            gold_sql=norm_correct_query,
                            prediction_sql=mutant["query"],
                            dialect=dialect
                        )
                else:
                    result = execution_test(
                        schema=schema_ddl,
                        dataset=dataset_sql,
                        gold_sql=norm_correct_query,
                        prediction_sql=mutant["query"],
                        dialect=dialect
                    )

                status = result["status"]

                if debug:
                    logger.info(
                        "  Mutant '%s' on mutant dataset %d [%s]: %s (reason=%s)",
                        mutant_id, i, dataset.strategy_name, status,
                        result.get("reason", "-"),
                    )
                    if status.startswith("NEQ") or status.startswith("ERROR") or status == "EQ_EXEC":
                        logger.info("    Q1 result: %s", result.get("gold_sql_result"))
                        logger.info("    Q2 result: %s", result.get("prediction_sql_result"))

                if status.startswith("NEQ") or (status.startswith("ERROR") and status != "ERROR_DATASET_LOADING"):
                    killed_mutants.add(mutant_id)
                    kill_details[mutant_id] = {
                        "dataset_idx": i,
                        "dataset_strategy": dataset.strategy_name,
                        "dataset_source": "mutant_query",
                        "comparator_status": status,
                        "reason": result.get("reason"),
                        "gold_sql_result": _format_result(result.get("gold_sql_result")),
                        "prediction_sql_result": _format_result(result.get("prediction_sql_result")),
                    }
                    is_killed = True
                    break
                else:
                    mutant_alive_results.append({
                        "dataset_idx": i,
                        "dataset_strategy": dataset.strategy_name,
                        "dataset_source": "mutant_query",
                        "comparator_status": status,
                        "gold_sql_result": _format_result(result.get("gold_sql_result")),
                        "prediction_sql_result": _format_result(result.get("prediction_sql_result")),
                    })

        if not is_killed:
            alive_details[mutant_id] = mutant_alive_results

    all_ids = {m["id"] for m in mutants}
    alive_mutants = all_ids - killed_mutants

    summary = {
        "test_case_id": tc_id,
        "gold_base_valid": gold_base_valid,
        "mutant_base_valid": mutant_base_valid,
        "total_mutants": len(mutants),
        "killed": sorted(killed_mutants),
        "alive": sorted(alive_mutants),
        "num_datasets": len(datasets),
        "datasets": [
            {
                "dataset_idx": i + 1,
                "strategy": ds.strategy_name,
                "description": ds.description,
                "sql": ds.insert_statements
            }
            for i, ds in enumerate(datasets)
        ],
        "kill_details": kill_details,
        "alive_details": alive_details,
    }

    if debug:
        logger.info("Summary: %d/%d killed", len(killed_mutants), len(mutants))
        if alive_mutants:
            logger.warning("Alive mutants: %s", sorted(alive_mutants))

    return summary


def _format_result(rows):
    """Convert query result rows to JSON-serializable lists."""
    if rows is None:
        return None
    return [list(row) for row in rows]


def main():
    parser = argparse.ArgumentParser(description="Run SQL semantic mutation test cases.")
    parser.add_argument("file", help="Path to JSON test case file")
    parser.add_argument("--debug", action="store_true", help="Enable debug logging")
    parser.add_argument("--dialect", type=str, default=None, help="SQL dialect override (sqlite, postgres, postgresql, mysql)")
    args = parser.parse_args()

    if args.debug:
        logging.basicConfig(level=logging.DEBUG, format="%(levelname)s: %(message)s")
    else:
        logging.basicConfig(level=logging.WARNING)

    with open(args.file, "r") as f:
        data = json.load(f)

    test_cases = data if isinstance(data, list) else [data]

    for tc in test_cases:
        result = run_test_case(tc, debug=args.debug, dialect_override=args.dialect)
        print(json.dumps(result, indent=2, cls=BytesEncoder))


if __name__ == "__main__":
    main()
