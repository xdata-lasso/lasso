#!/usr/bin/env python3
"""
analyze_bounded_study.py

Analyzes and compares the effect of bounding the number of synthesized datasets
in Gemini-TDG (e.g. k=1, 3, 5, 10 vs. Unrestricted).

Discovers:
- Bounded runs from: experiments/gemini_tdg_study/results/ (gemini_tdg_k{N}_{benchmark}.csv)
- Unrestricted run from: experiments/results/ (gemini_tdg_{benchmark}.csv)
"""

import os
import sys
import re
import csv
import glob
import argparse
from collections import defaultdict
from typing import Dict, List, Any, Optional

STUDY_DIR = os.path.dirname(os.path.abspath(__file__))
EXPERIMENTS_DIR = os.path.dirname(STUDY_DIR)
STUDY_RESULTS_DIR = os.path.join(STUDY_DIR, "results")
MAIN_RESULTS_DIR = os.path.join(EXPERIMENTS_DIR, "results")


def parse_args():
    parser = argparse.ArgumentParser(
        description="Analyze the effect of dataset bounds (k) on Gemini-TDG"
    )
    parser.add_argument(
        '--study-results-dir',
        type=str,
        default=STUDY_RESULTS_DIR,
        help="Directory containing bounded results (default: experiments/gemini_tdg_study/results)"
    )
    parser.add_argument(
        '--main-results-dir',
        type=str,
        default=MAIN_RESULTS_DIR,
        help="Directory containing unrestricted results (default: experiments/results)"
    )
    parser.add_argument(
        '--benchmark',
        type=str,
        default='all',
        help="Filter to specific benchmark or 'all' (default: all)"
    )
    parser.add_argument(
        '--output-file',
        type=str,
        default=None,
        help="Optional file path to write markdown summary"
    )
    return parser.parse_args()


def discover_configs(study_dir: str, main_dir: str) -> Dict[str, Dict[str, Any]]:
    """
    Discovers all configurations and their corresponding CSV files.
    Returns:
        dict: config_key -> {
            'label': str,
            'k': Optional[int],  # None for unrestricted
            'eval_files': Dict[str, str],     # benchmark -> csv path
            'datagen_files': Dict[str, str],  # benchmark -> csv path
        }
    """
    configs: Dict[str, Dict[str, Any]] = {}

    # 1. Discover bounded runs in study_dir
    if os.path.isdir(study_dir):
        eval_pattern = os.path.join(study_dir, "gemini_tdg_k*")
        for filepath in glob.glob(eval_pattern):
            filename = os.path.basename(filepath)
            if not filename.endswith(".csv") or "_datagen_" in filename:
                continue

            m = re.match(r"^gemini_tdg_k(\d+)_(.+)\.csv$", filename)
            if not m:
                continue
            k_val = int(m.group(1))
            benchmark = m.group(2).lower()
            config_key = f"k_{k_val}"

            if config_key not in configs:
                configs[config_key] = {
                    'label': f"Bounded (k={k_val})",
                    'k': k_val,
                    'eval_files': {},
                    'datagen_files': {}
                }
            configs[config_key]['eval_files'][benchmark] = filepath

            dg_file = os.path.join(study_dir, f"gemini_tdg_k{k_val}_datagen_{benchmark}.csv")
            if os.path.exists(dg_file):
                configs[config_key]['datagen_files'][benchmark] = dg_file

    # 2. Discover unrestricted runs in study_dir and main_dir
    for search_dir in [study_dir, main_dir]:
        if not os.path.isdir(search_dir):
            continue
        eval_pattern = os.path.join(search_dir, "gemini_tdg_*.csv")
        for filepath in glob.glob(eval_pattern):
            filename = os.path.basename(filepath)
            if "_datagen_" in filename or re.match(r"^gemini_tdg_k\d+_", filename):
                continue

            m = re.match(r"^gemini_tdg_(?:unrestricted_)?(.+)\.csv$", filename)
            if not m:
                continue
            benchmark = m.group(1).lower()
            config_key = "unrestricted"

            if config_key not in configs:
                configs[config_key] = {
                    'label': "Unrestricted",
                    'k': None,
                    'eval_files': {},
                    'datagen_files': {}
                }
            if benchmark not in configs[config_key]['eval_files']:
                configs[config_key]['eval_files'][benchmark] = filepath

            # Look for corresponding datagen CSV
            for dg_name in [f"gemini_tdg_unrestricted_datagen_{benchmark}.csv", f"gemini_tdg_datagen_{benchmark}.csv"]:
                dg_file = os.path.join(search_dir, dg_name)
                if os.path.exists(dg_file):
                    configs[config_key]['datagen_files'][benchmark] = dg_file
                    break

    return configs


def sort_config_keys(configs: Dict[str, Dict[str, Any]]) -> List[str]:
    """Sorts configs by numeric k ascending, putting 'unrestricted' at the end."""
    bounded = []
    has_unrestricted = False
    for k_str, data in configs.items():
        if data['k'] is not None:
            bounded.append((data['k'], k_str))
        else:
            has_unrestricted = True
    bounded.sort(key=lambda x: x[0])
    ordered = [x[1] for x in bounded]
    if has_unrestricted:
        ordered.append("unrestricted")
    return ordered


def load_config_metrics(config_data: Dict[str, Any], target_benchmark: str) -> Dict[str, Any]:
    """Loads metrics across benchmarks for a single configuration."""
    eval_files = config_data['eval_files']
    datagen_files = config_data['datagen_files']

    benchmarks_to_load = list(eval_files.keys())
    if target_benchmark != 'all':
        benchmarks_to_load = [b for b in benchmarks_to_load if b == target_benchmark.lower()]

    per_benchmark: Dict[str, Dict[str, Any]] = {}
    overall = {
        'total_pairs': 0,
        'neq_count': 0,
        'eq_exec_count': 0,
        'error_count': 0,
        'other_count': 0,
        'total_time': 0.0,
        'total_prompt_tokens': 0,
        'total_candidate_tokens': 0,
        'total_tokens': 0,
        'total_instances': 0,
        'total_datasets': 0,
        'datagen_time': 0.0,
    }

    for bm in sorted(benchmarks_to_load):
        eval_csv = eval_files[bm]
        bm_stats = {
            'total_pairs': 0,
            'neq_count': 0,
            'eq_exec_count': 0,
            'error_count': 0,
            'other_count': 0,
            'total_time': 0.0,
            'total_prompt_tokens': 0,
            'total_candidate_tokens': 0,
            'total_tokens': 0,
            'total_instances': 0,
            'total_datasets': 0,
            'datagen_time': 0.0,
        }

        # Parse evaluation CSV
        with open(eval_csv, 'r', encoding='utf-8') as f:
            reader = csv.DictReader(f)
            for row in reader:
                bm_stats['total_pairs'] += 1
                status = row.get('EXTEST_STATUS', '').strip()
                if status.startswith('NEQ'):
                    bm_stats['neq_count'] += 1
                elif status in ('EQ_EXEC', 'EXEC_EQ', 'EQ'):
                    bm_stats['eq_exec_count'] += 1
                elif status.startswith('ERROR') or status in ('TOOL_ERROR', 'TIMEOUT'):
                    bm_stats['error_count'] += 1
                else:
                    bm_stats['other_count'] += 1

                try:
                    bm_stats['total_time'] += float(row.get('time_taken', 0.0) or 0.0)
                except ValueError:
                    pass

        # Parse datagen CSV if available
        if bm in datagen_files:
            with open(datagen_files[bm], 'r', encoding='utf-8') as f:
                reader = csv.DictReader(f)
                for row in reader:
                    bm_stats['total_instances'] += 1
                    try:
                        bm_stats['total_datasets'] += int(row.get('num_datasets', 0) or 0)
                        bm_stats['datagen_time'] += float(row.get('data_gen_time', 0.0) or 0.0)
                        bm_stats['total_prompt_tokens'] += int(row.get('prompt_tokens', 0) or 0)
                        bm_stats['total_candidate_tokens'] += int(row.get('candidates_tokens', 0) or 0)
                        bm_stats['total_tokens'] += int(row.get('total_tokens', 0) or 0)
                    except ValueError:
                        pass

        per_benchmark[bm] = bm_stats

        # Accumulate to overall
        for key in overall:
            overall[key] += bm_stats[key]

    return {
        'overall': overall,
        'per_benchmark': per_benchmark
    }


def format_table(headers: List[str], rows: List[List[str]], alignments: Optional[List[str]] = None) -> str:
    """Formats a 2D matrix of strings into an ASCII grid table."""
    if not alignments:
        alignments = ['left'] + ['right'] * (len(headers) - 1)

    col_widths = [len(h) for h in headers]
    for row in rows:
        for i, val in enumerate(row):
            if i < len(col_widths):
                col_widths[i] = max(col_widths[i], len(str(val)))

    def build_row(values):
        cells = []
        for val, width, align in zip(values, col_widths, alignments):
            s = str(val)
            if align == 'right':
                cells.append(s.rjust(width))
            elif align == 'center':
                cells.append(s.center(width))
            else:
                cells.append(s.ljust(width))
        return "| " + " | ".join(cells) + " |"

    def build_separator(char="-", cross="+"):
        return cross + cross.join(char * (w + 2) for w in col_widths) + cross

    lines = [
        build_separator("="),
        build_row(headers),
        build_separator("-"),
    ]
    for row in rows:
        lines.append(build_row(row))
    lines.append(build_separator("="))
    return "\n".join(lines)


def format_markdown_table(headers: List[str], rows: List[List[str]], alignments: Optional[List[str]] = None) -> str:
    """Formats a 2D matrix of strings into a Markdown table."""
    if not alignments:
        alignments = ['left'] + ['right'] * (len(headers) - 1)

    sep_cells = []
    for align in alignments:
        if align == 'right':
            sep_cells.append("---:")
        elif align == 'center':
            sep_cells.append(":---:")
        else:
            sep_cells.append(":---")
    sep_line = "| " + " | ".join(sep_cells) + " |"

    lines = [
        "| " + " | ".join(headers) + " |",
        sep_line
    ]
    for row in rows:
        lines.append("| " + " | ".join(str(cell) for cell in row) + " |")
    return "\n".join(lines)


def main():
    args = parse_args()

    configs = discover_configs(args.study_results_dir, args.main_results_dir)
    ordered_keys = sort_config_keys(configs)

    if not ordered_keys:
        print(f"No results found in:\n  Bounded: {args.study_results_dir}\n  Unrestricted: {args.main_results_dir}")
        print("\nTo generate data for the bounded study, run:")
        print("  sh experiments/run_gemini_tdg.sh --mode bounded --max-datasets 1")
        print("  sh experiments/run_gemini_tdg.sh --mode bounded --max-datasets 3")
        print("  sh experiments/run_gemini_tdg.sh --mode bounded --max-datasets 5")
        print("  sh experiments/run_gemini_tdg.sh --mode bounded --max-datasets 10")
        print("  sh experiments/run_gemini_tdg.sh --mode unrestricted")
        return

    # Load metrics for each config
    config_metrics = {}
    all_benchmarks = set()
    for cfg_key in ordered_keys:
        data = load_config_metrics(configs[cfg_key], args.benchmark)
        config_metrics[cfg_key] = data
        all_benchmarks.update(data['per_benchmark'].keys())

    sorted_bms = sorted(all_benchmarks)

    output_lines = []
    output_lines.append("=" * 80)
    output_lines.append("GEMINI-TDG BOUNDED DATASET STUDY ANALYSIS")
    output_lines.append(f"Configurations found: {', '.join(configs[k]['label'] for k in ordered_keys)}")
    output_lines.append(f"Benchmarks: {', '.join(sorted_bms) if sorted_bms else 'None'}")
    output_lines.append("=" * 80)
    output_lines.append("")

    # --- TABLE 1: Overall Summary vs k ---
    headers1 = [
        "Configuration",
        "Bound (k)",
        "Pairs",
        "Refuted (NEQ)",
        "Refutation %",
        "Avg Datasets",
        "Avg Gen Time (s)",
        "Time/Pred (s)",
        "Avg Tokens/Inst",
        "Total Tokens"
    ]
    rows1 = []
    for cfg_key in ordered_keys:
        cfg = configs[cfg_key]
        m = config_metrics[cfg_key]['overall']
        tot_pairs = m['total_pairs']
        neq = m['neq_count']
        ref_rate = (neq / tot_pairs * 100) if tot_pairs > 0 else 0.0

        n_inst = m['total_instances'] or 1
        avg_ds = (m['total_datasets'] / n_inst) if n_inst > 0 else 0.0
        avg_gen_time = (m['datagen_time'] / n_inst) if n_inst > 0 else 0.0
        time_per_pred = (m['total_time'] / tot_pairs) if tot_pairs > 0 else 0.0
        avg_tokens = (m['total_tokens'] / n_inst) if n_inst > 0 else 0.0

        k_str = str(cfg['k']) if cfg['k'] is not None else "∞ (Unres.)"

        rows1.append([
            cfg['label'],
            k_str,
            f"{tot_pairs:,}",
            f"{neq:,}",
            f"{ref_rate:.1f}%",
            f"{avg_ds:.2f}",
            f"{avg_gen_time:.2f}s",
            f"{time_per_pred:.3f}s",
            f"{avg_tokens:,.0f}",
            f"{m['total_tokens']:,}"
        ])

    output_lines.append("### Table 1: Overall Performance vs Dataset Bound (k)")
    output_lines.append(format_table(headers1, rows1))
    output_lines.append("")

    # --- TABLE 2: Per-Benchmark Refutation Rate Breakdown ---
    if sorted_bms:
        headers2 = ["Configuration"] + [bm.upper() for bm in sorted_bms] + ["OVERALL"]
        rows2 = []
        for cfg_key in ordered_keys:
            cfg = configs[cfg_key]
            row = [cfg['label']]
            for bm in sorted_bms:
                bm_m = config_metrics[cfg_key]['per_benchmark'].get(bm)
                if bm_m and bm_m['total_pairs'] > 0:
                    pct = (bm_m['neq_count'] / bm_m['total_pairs']) * 100
                    row.append(f"{bm_m['neq_count']}/{bm_m['total_pairs']} ({pct:.1f}%)")
                else:
                    row.append("--")

            tot_pairs = config_metrics[cfg_key]['overall']['total_pairs']
            tot_neq = config_metrics[cfg_key]['overall']['neq_count']
            tot_pct = (tot_neq / tot_pairs * 100) if tot_pairs > 0 else 0.0
            row.append(f"{tot_neq}/{tot_pairs} ({tot_pct:.1f}%)")
            rows2.append(row)

        output_lines.append("### Table 2: Refutation Rate by Benchmark vs Dataset Bound (k)")
        align2 = ['left'] + ['right'] * (len(sorted_bms) + 1)
        output_lines.append(format_table(headers2, rows2, alignments=align2))
        output_lines.append("")

    # Print report to stdout
    report_text = "\n".join(output_lines)
    print(report_text)

    # Save to file if requested
    if args.output_file:
        os.makedirs(os.path.dirname(os.path.abspath(args.output_file)), exist_ok=True)
        with open(args.output_file, 'w', encoding='utf-8') as f:
            f.write("# Gemini-TDG Bounded Dataset Study Results\n\n")
            f.write("## Overall Performance vs Dataset Bound (k)\n\n")
            f.write(format_markdown_table(headers1, rows1) + "\n\n")
            if sorted_bms:
                f.write("## Refutation Rate by Benchmark\n\n")
                f.write(format_markdown_table(headers2, rows2, alignments=align2) + "\n\n")
        print(f"\nMarkdown summary saved to: {args.output_file}")


if __name__ == '__main__':
    main()
