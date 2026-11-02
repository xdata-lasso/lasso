#!/usr/bin/env python3
"""
Improvements Finder: Helper script as described in Section 3.1 of paper/main.tex.

Gathers benchmark examples that the current LASSO codebase does not handle (i.e. where LASSO
did not refute equivalence) and partitions them into two categories:

  (1) Other-Proved Non-Equivalent Queries (other_proved_neq):
      Finds instances where other tools (such as ParSEval, Polygon, SpotIT, XData)
      successfully proved query non-equivalence (NEQ/NEQ_SCO) but LASSO did not.
      Such confirmed non-equivalent queries are high-priority candidates used to
      improve the LASSO codebase.

  (2) Unknown Queries (unknown_queries):
      Collects the remaining examples where none of the evaluated tools proved
      non-equivalence. When addressing these cases in LASSO, additional semantic
      reasoning is required to verify whether the queries are genuinely non-equivalent
      before proceeding to implement support in the codebase.

Each test case JSON file strictly follows LASSO's standard test runner schema:
{
    "id": "<prediction_id>",
    "dialect": "<dialect>",
    "schema": "<DDL_content>",
    "correct_query": "<gold_sql>",
    "expected_semantic_errors_to_be_caught": [
        {
            "id": "<prediction_id>",
            "description": "<tool execution status details>",
            "query": "<prediction_sql>"
        }
    ]
}
"""

import os
import sys
import json
import shutil
import csv
import argparse
from collections import defaultdict


def load_schemas(schemas_path: str) -> dict:
    """Load schema DDLs from schemas.json."""
    if not os.path.exists(schemas_path):
        print(f"Warning: schemas file not found at {schemas_path}")
        return {}
    with open(schemas_path, "r", encoding="utf-8") as f:
        return json.load(f)


def load_queries(queries_path: str, schemas: dict) -> dict:
    """
    Load queries.json and index predictions by prediction_id.
    Ensures SQLite syntax and schema DDLs are used to match evaluate_lasso.py
    and make generated test cases directly runnable by test_runner.py.
    Returns: dict mapping prediction_id -> metadata
    """
    if not os.path.exists(queries_path):
        print(f"Warning: queries file not found at {queries_path}")
        return {}

    pred_lookup = {}
    with open(queries_path, "r", encoding="utf-8") as f:
        queries_data = json.load(f)

    for item in queries_data:
        inst_id = str(item.get("id") or item.get("instance_id", "")).strip()
        schema_id = item.get("schema_id") or item.get("database_id")
        dialect = "sqlite"
        benchmark = item.get("source", "")
        if not benchmark and "_" in inst_id:
            benchmark = inst_id.split("_")[0]

        # Extract SQLite schema DDL
        ddl = ""
        if schema_id and schema_id in schemas:
            ddl = schemas[schema_id].get("ddl", "")
        elif "schema" in item:
            ddl = item["schema"]
        elif "ddl" in item:
            ddl = item["ddl"]

        if isinstance(ddl, list):
            ddl = "\n".join(ddl)

        # Use SQLite gold query matching evaluate_lasso.py
        gold_sql = item.get("gold_sql_sqlite") or item.get("gold_sql", "")

        for pred in item.get("predictions", []):
            pid = pred.get("prediction_id")
            if not pid:
                continue

            # Use SQLite prediction query matching evaluate_lasso.py
            pred_sql = pred.get("prediction_sql_sqlite") or pred.get("prediction_sql", "")
            if not pred_sql:
                continue

            pred_lookup[pid] = {
                "instance_id": inst_id,
                "benchmark": benchmark,
                "schema_id": schema_id,
                "dialect": dialect,
                "ddl": ddl,
                "gold_sql": gold_sql,
                "prediction_sql": pred_sql,
            }

    return pred_lookup


def collect_evaluation_results(results_dir: str):
    """
    Collect evaluation statuses from experiments/results/*.csv.
    Returns:
        eval_data: dict of (instance_id, prediction_id) -> {
            'benchmark': str,
            'lasso': {tool_csv_name: status},
            'other': {tool_name: status}
        }
    """
    if not os.path.exists(results_dir):
        print(f"Error: results directory not found at {results_dir}")
        return {}

    eval_data = defaultdict(lambda: {"benchmark": "", "lasso": {}, "other": {}})

    csv_files = [
        f
        for f in os.listdir(results_dir)
        if f.endswith(".csv")
        and not f.startswith("lasso_strategy_kills")
        and "_datagen_" not in f
    ]

    for fname in sorted(csv_files):
        fpath = os.path.join(results_dir, fname)

        # Identify benchmark from filename e.g. lasso_bird.csv -> bird
        parts = fname[:-4].split("_")
        bench = parts[-1] if len(parts) > 1 else ""

        is_lasso = fname.startswith("lasso_") or fname == "lasso.csv"
        tool_name = "lasso" if is_lasso else ("_".join(parts[:-1]) if len(parts) > 1 else parts[0])

        with open(fpath, "r", encoding="utf-8") as f:
            reader = csv.DictReader(f)
            for row in reader:
                inst_id = str(row.get("instance_id", "")).strip()
                pred_id = str(row.get("prediction_id", "")).strip()
                status = str(row.get("EXTEST_STATUS", "")).strip()

                if not inst_id or not pred_id or not status:
                    continue

                key = (inst_id, pred_id)
                if bench and not eval_data[key]["benchmark"]:
                    eval_data[key]["benchmark"] = bench

                if is_lasso:
                    eval_data[key]["lasso"][fname] = status
                else:
                    eval_data[key]["other"][tool_name] = status

    return eval_data


def classify_improvements(eval_data: dict, benchmark_filter: str = None):
    """
    Partition instances not refuted by LASSO into:
      - other_proved_neq: Other tools proved NEQ, LASSO did not.
      - unknown_queries: Neither LASSO nor other tools proved NEQ.
    """
    other_proved_neq = []
    unknown_queries = []
    bench_counts = defaultdict(lambda: {"lasso_neq": 0, "other_proved_neq": 0, "unknown": 0, "total": 0})

    neq_statuses = {"NEQ"}

    for (inst_id, pred_id), info in eval_data.items():
        bench = info["benchmark"] or (inst_id.split("_")[0] if "_" in inst_id else "unknown")
        if benchmark_filter and benchmark_filter.lower() != "all" and bench.lower() != benchmark_filter.lower():
            continue

        lasso_results = info["lasso"]
        other_results = info["other"]

        # Only consider cases evaluated by LASSO
        if not lasso_results:
            continue

        bench_counts[bench]["total"] += 1

        lasso_proved_neq = any(s in neq_statuses for s in lasso_results.values())
        if lasso_proved_neq:
            bench_counts[bench]["lasso_neq"] += 1
            continue

        # LASSO did not prove NEQ
        other_neq_tools = [tool for tool, status in other_results.items() if status in neq_statuses]

        item = {
            "instance_id": inst_id,
            "prediction_id": pred_id,
            "benchmark": bench,
            "lasso_results": lasso_results,
            "other_results": other_results,
            "other_neq_tools": other_neq_tools,
        }

        if other_neq_tools:
            # Category 1: Other tools proved NEQ, LASSO did not
            bench_counts[bench]["other_proved_neq"] += 1
            other_proved_neq.append(item)
        else:
            # Category 2: Remaining examples (none of the tools proved NEQ)
            bench_counts[bench]["unknown"] += 1
            unknown_queries.append(item)

    return other_proved_neq, unknown_queries, bench_counts


def write_test_case_files(
    items: list, output_dir: str, pred_lookup: dict, limit: int = None, group_by_benchmark: bool = True
) -> int:
    """Generate standardized SQLite JSON test case files in the target directory, grouped by benchmark."""
    os.makedirs(output_dir, exist_ok=True)
    count = 0

    for item in items:
        if limit is not None and count >= limit:
            break

        pred_id = item["prediction_id"]
        inst_id = item["instance_id"]
        bench = item.get("benchmark") or (inst_id.split("_")[0] if "_" in inst_id else "unknown")
        meta = pred_lookup.get(pred_id, {})

        ddl = meta.get("ddl", "")
        gold_sql = meta.get("gold_sql", "")
        pred_sql = meta.get("prediction_sql", "")
        dialect = "sqlite"

        if not ddl or not gold_sql or not pred_sql:
            continue

        lasso_statuses_str = ", ".join(f"{t}:{s}" for t, s in item["lasso_results"].items())
        other_statuses_str = (
            ", ".join(f"{t}:{s}" for t, s in item["other_results"].items())
            if item["other_results"]
            else "NONE"
        )

        test_case_data = {
            "id": pred_id,
            "dialect": dialect,
            "schema": ddl,
            "correct_query": gold_sql,
            "expected_semantic_errors_to_be_caught": [
                {
                    "id": pred_id,
                    "description": f"Lasso status: [{lasso_statuses_str}] | Other tools: [{other_statuses_str}]",
                    "query": pred_sql,
                }
            ],
        }

        safe_inst_id = str(inst_id).replace("/", "_").replace("\\", "_").replace(" ", "_")
        safe_pred_id = str(pred_id).replace("/", "_").replace("\\", "_").replace(" ", "_")
        if safe_pred_id.startswith(safe_inst_id):
            filename = f"{safe_pred_id}.json"
        else:
            filename = f"{safe_inst_id}_{safe_pred_id}.json"

        target_dir = os.path.join(output_dir, bench) if group_by_benchmark else output_dir
        os.makedirs(target_dir, exist_ok=True)

        filepath = os.path.join(target_dir, filename)
        with open(filepath, "w", encoding="utf-8") as out_f:
            json.dump(test_case_data, out_f, indent=4)

        count += 1

    return count


def print_summary_table(bench_counts: dict, total_other_neq: int, total_unknown: int):
    """Print a clean breakdown table matching the paper's benchmarks."""
    header = f"{'Benchmark':<15} | {'Evaluated':<10} | {'LASSO Refuted':<14} | {'Other-Proved NEQ':<18} | {'Unknown':<10}"
    separator = "-" * len(header)
    print("\n" + separator)
    print(header)
    print(separator)

    tot_eval = sum(c["total"] for c in bench_counts.values())
    tot_lasso = sum(c["lasso_neq"] for c in bench_counts.values())

    for bench in sorted(bench_counts.keys()):
        c = bench_counts[bench]
        print(
            f"{bench:<15} | {c['total']:<10} | {c['lasso_neq']:<14} | {c['other_proved_neq']:<18} | {c['unknown']:<10}"
        )

    print(separator)
    print(
        f"{'Overall':<15} | {tot_eval:<10} | {tot_lasso:<14} | {total_other_neq:<18} | {total_unknown:<10}"
    )
    print(separator + "\n")


def cleanup_output_directory(output_dir: str, benchmark: str = "all", group_by_benchmark: bool = True):
    """
    Cleans up previously generated test cases and directories.
    If benchmark is 'all', removes all files and benchmark folders under category dirs.
    If a specific benchmark is provided, cleans up that benchmark's subfolder or matching files.
    """
    categories = ["other_proved_neq", "unknown_queries"]
    
    if benchmark.lower() == "all":
        for cat in categories:
            cat_dir = os.path.join(output_dir, cat)
            if os.path.exists(cat_dir):
                shutil.rmtree(cat_dir)
            os.makedirs(cat_dir, exist_ok=True)
    else:
        for cat in categories:
            cat_dir = os.path.join(output_dir, cat)
            if not os.path.exists(cat_dir):
                os.makedirs(cat_dir, exist_ok=True)
                continue
            if group_by_benchmark:
                bench_dir = os.path.join(cat_dir, benchmark)
                if os.path.exists(bench_dir):
                    shutil.rmtree(bench_dir)
                os.makedirs(bench_dir, exist_ok=True)
            else:
                for fname in os.listdir(cat_dir):
                    if fname.startswith(f"{benchmark}_") or fname.startswith(f"{benchmark}/"):
                        fpath = os.path.join(cat_dir, fname)
                        if os.path.isfile(fpath):
                            os.remove(fpath)


def main():
    repo_root = os.path.dirname(os.path.abspath(__file__))

    parser = argparse.ArgumentParser(
        description="Improvements Finder: Identifies non-refuted queries and categorizes them into Other-Proved NEQ and Unknown Queries."
    )
    parser.add_argument(
        "--benchmark", "-b", type=str, default="all",
        help="Filter by benchmark (e.g. bird, calcite, cubes, leetcode, literature, tpch, largejoin, xdata, or all)",
    )
    parser.add_argument(
        "--output-dir", "-o", type=str, default=os.path.join(repo_root, "experiments", "lasso_improvements"),
        help="Output directory for generated test case JSON files (default: experiments/lasso_improvements)",
    )
    parser.add_argument(
        "--limit", "-n", type=int, default=None,
        help="Limit number of test case files to generate per category (default: unlimited)",
    )
    parser.add_argument(
        "--summary-only", action="store_true",
        help="Only display summary table without writing test case files",
    )
    parser.add_argument(
        "--no-cleanup", action="store_true",
        help="Do not clean up previous results before generating new test case files",
    )
    parser.add_argument(
        "--results-dir", type=str, default=os.path.join(repo_root, "experiments", "results"),
        help="Directory containing tool evaluation CSV files",
    )
    parser.add_argument(
        "--queries-file", type=str, default=os.path.join(repo_root, "experiments", "queries.json"),
        help="Path to queries.json",
    )
    parser.add_argument(
        "--schemas-file", type=str, default=os.path.join(repo_root, "experiments", "schemas.json"),
        help="Path to schemas.json",
    )
    parser.add_argument(
        "--no-benchmark-subfolders", action="store_true",
        help="Disable creating benchmark subfolders within category folders (flattens all files into category folder)",
    )

    args = parser.parse_args()

    print("=" * 80)
    print("LASSO Improvements Finder")
    print("=" * 80)

    # 1. Collect evaluation data from CSV files
    print(f"Loading results from {args.results_dir}...")
    eval_data = collect_evaluation_results(args.results_dir)
    if not eval_data:
        print("No evaluation data found. Exiting.")
        return

    # 2. Classify into (1) Other-Proved NEQ and (2) Unknown Queries
    other_proved_neq, unknown_queries, bench_counts = classify_improvements(
        eval_data, benchmark_filter=args.benchmark
    )

    # 3. Print summary table
    print_summary_table(bench_counts, len(other_proved_neq), len(unknown_queries))

    if args.summary_only:
        print("Summary only mode requested. Skipping file generation.")
        return

    # 4. Load metadata for test case generation
    print(f"Loading query metadata from {args.queries_file} and {args.schemas_file}...")
    schemas = load_schemas(args.schemas_file)
    pred_lookup = load_queries(args.queries_file, schemas)

    # 5. Define output directories matching paper/main.tex categories
    dir_other_neq = os.path.join(args.output_dir, "other_proved_neq")
    dir_unknown = os.path.join(args.output_dir, "unknown_queries")
    group_by_bench = not args.no_benchmark_subfolders

    # Clean up previous results unless disabled
    if not args.no_cleanup:
        print(f"Cleaning up previous results in {args.output_dir}...")
        cleanup_output_directory(
            args.output_dir,
            benchmark=args.benchmark,
            group_by_benchmark=group_by_bench
        )

    print(f"\nWriting test case JSON files into {args.output_dir} (grouped by benchmark: {group_by_bench}):")
    n_other = write_test_case_files(
        other_proved_neq, dir_other_neq, pred_lookup, limit=args.limit, group_by_benchmark=group_by_bench
    )
    print(f"  [Category 1] Other-Proved NEQ: {n_other} test cases saved to {dir_other_neq}")

    n_unknown = write_test_case_files(
        unknown_queries, dir_unknown, pred_lookup, limit=args.limit, group_by_benchmark=group_by_bench
    )
    print(f"  [Category 2] Unknown Queries:  {n_unknown} test cases saved to {dir_unknown}")
    print("\nDone! These test cases are ready for execution with test_runner.py or run_all.py.\n")


if __name__ == "__main__":
    main()
