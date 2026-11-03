import os
import sys
import csv
import glob
import json
import re
import time
from collections import defaultdict
import html
import sqlglot
import sqlglot.expressions as exp
import csv_utils
import statistics
import argparse
try:
    import pandas as pd
except ImportError:
    pd = None

# Canonical tool presentation order matching the evaluation tables in paper/main.tex
CANONICAL_SYMBOLIC_ORDER = [
    'spotit',
    'polygon',
    'sqlwitness',
    'parseval',
    'parseval-tdg',
    'xdata_gold',
    'xdata_cc',
    'xdatapublic',
    'xdatapublic_cc',
]

CANONICAL_LASSO_ORDER = [
    'lasso',
    'lasso_cc'
]

CANONICAL_LLM_ORDER = [
    'gemini-4-argon-high-er',
    'gemini-4-argon-high-tdg',
    'gemini-4-argon-medium-er',
    'gemini-4-argon-medium-tdg',
    'gemini-4-argon-low-er',
    'gemini-4-argon-low-tdg',
]

CANONICAL_TOOL_ORDER = CANONICAL_SYMBOLIC_ORDER + CANONICAL_LLM_ORDER + CANONICAL_LASSO_ORDER

def is_llm_tool(name: str) -> bool:
    """Check whether a normalized tool name represents an LLM ER or TDG baseline."""
    n = str(name).strip().lower()
    if n in ("parseval-tdg", "parseval_tdg"):
        return False
    return n.endswith("-er") or n.endswith("-tdg") or n.startswith("gemini")

def normalize_tool_name(name: str) -> str:
    """Normalize tool names across CSV naming conventions."""
    name_clean = str(name).strip()
    if name_clean in ("sqlwitness", "sql_witness"):
        return "sqlwitness"
    if name_clean in ("parseval_tdg", "parseval-tdg"):
        return "parseval-tdg"
    if name_clean in ("gemini", "gemini_er", "gemini-er"):
        return "gemini-er"
    if name_clean in ("gemini_tdg", "gemini-tdg"):
        return "gemini-tdg"
    if name_clean.endswith("_er"):
        return name_clean[:-3].replace("_", "-") + "-er"
    if name_clean.endswith("_tdg"):
        return name_clean[:-4].replace("_", "-") + "-tdg"
    return name_clean

# Canonical benchmark presentation order matching the evaluation tables in paper/main.tex
CANONICAL_BENCHMARK_ORDER = [
    'bird',
    'cubes',
    'leetcode',
    'literature',
    'calcite',
    'xdata',
    'tpch',
    'largejoin',
    'lasso-bm',
    'mm-bm',
    'mmo-bm',
    'mmro-bm'
]

def has_order_by_or_limit(sql: str, dialect: str = None) -> bool:
    """
    Determines whether a SQL query contains an ORDER BY, LIMIT, FETCH, or TOP clause.
    Uses parsed SQL AST structure via sqlglot, with regex fallback for dialect-specific syntax.
    """
    if not sql or not isinstance(sql, str):
        return False
    upper_sql = sql.upper()
    if "ORDER" not in upper_sql and "LIMIT" not in upper_sql and "FETCH" not in upper_sql and "TOP" not in upper_sql:
        return False
    try:
        parsed = sqlglot.parse_one(sql, read=dialect)
        if parsed is not None:
            if (
                parsed.find(exp.Order) is not None
                or parsed.find(exp.Limit) is not None
                or parsed.find(exp.Fetch) is not None
                or parsed.find(exp.Top) is not None
            ):
                return True
            return False
    except Exception:
        pass

    if (
        re.search(r'\bORDER\s+BY\b', upper_sql)
        or re.search(r'\bLIMIT\b', upper_sql)
        or re.search(r'\bFETCH\s+(FIRST|NEXT)\b', upper_sql)
        or re.search(r'\bTOP\s+\d+\b', upper_sql)
    ):
        return True
    return False

def is_numeric_value(val: str) -> bool:
    """
    Checks if a cell value represents a numeric metric, count, percentage,
    inequality (<0.01), composite count (9 (90.0%)), or placeholder symbol (--).
    """
    v = str(val).strip()
    if not v or v == "--":
        return True
    if v.startswith("<") or v.startswith(">"):
        v = v[1:].strip()
    comp_match = re.match(r'^([\d\.,]+)\s*\(.*?\)$', v)
    if comp_match:
        v = comp_match.group(1).strip()
    if v.endswith("%"):
        v = v[:-1].strip()
    if v.startswith("+") or v.startswith("-"):
        v = v[1:].strip()
    try:
        float(v.replace(",", ""))
        return True
    except ValueError:
        return False

def parse_metric_value(val: str):
    """
    Parses a string metric value into a float for numerical comparison.
    Handles counts, floats, inequalities (<0.01, >100), percentages (12.5%),
    composite strings (9 (90.0%)), and signed values (+5). Returns None for non-numeric or placeholder symbols (--).
    """
    if val is None:
        return None
    v = str(val).strip()
    if not v or v == "--":
        return None
    factor = 1.0
    epsilon = 0.0
    if v.startswith("<"):
        epsilon = -1e-9
        v = v[1:].strip()
    elif v.startswith(">"):
        epsilon = 1e-9
        v = v[1:].strip()
    comp_match = re.match(r'^([\d\.,]+)\s*\(.*?\)$', v)
    if comp_match:
        v = comp_match.group(1).strip()
    if v.endswith("%"):
        factor = 0.01
        v = v[:-1].strip()
    if v.startswith("+"):
        v = v[1:].strip()
    try:
        return float(v.replace(",", "")) * factor + epsilon
    except ValueError:
        return None

def render_table(title: str, headers: list, rows: list) -> list:
    """
    Renders a cleanly formatted ASCII table with aligned columns,
    headers, and horizontal dividers.
    """
    if not headers:
        return [title] if title else []

    num_cols = len(headers)
    col_widths = [len(str(h)) for h in headers]
    for row in rows:
        for i in range(min(len(row), num_cols)):
            col_widths[i] = max(col_widths[i], len(str(row[i])))

    col_is_numeric = []
    for i in range(num_cols):
        if i == 0:
            col_is_numeric.append(False)
        else:
            is_num = all(is_numeric_value(row[i]) for row in rows if i < len(row))
            col_is_numeric.append(is_num)

    def sep_line(char='-'):
        return '+' + '+'.join(char * (w + 2) for w in col_widths) + '+'

    def fmt_row(row, is_header=False):
        cells = []
        for i in range(num_cols):
            val_str = str(row[i]) if i < len(row) else ""
            w = col_widths[i]
            if is_header:
                if col_is_numeric[i]:
                    cells.append(f" {val_str.rjust(w)} ")
                else:
                    cells.append(f" {val_str.ljust(w)} ")
            else:
                if col_is_numeric[i]:
                    cells.append(f" {val_str.rjust(w)} ")
                else:
                    cells.append(f" {val_str.ljust(w)} ")
        return '|' + '|'.join(cells) + '|'

    lines = []
    if title:
        lines.append(title)
    lines.append(sep_line('-'))
    lines.append(fmt_row(headers, is_header=True))
    lines.append(sep_line('='))
    for row in rows:
        first_cell = str(row[0]).strip().lower() if row else ""
        if first_cell in ("total", "overall", "non-empty"):
            lines.append(sep_line('-'))
        lines.append(fmt_row(row))
    lines.append(sep_line('-'))
    return lines

def save_summary_data(tables: list, output_json_path: str, benchmarks: list, tools: list, bench_totals: dict,
                      dialects: list = None, selected_dialect: str = 'all', by_dialect: dict = None):
    """
    Saves clean, structured analysis summary data to JSON for interactive web viewers.
    Avoids polluting code with raw HTML generation while enabling dynamic filtering and sorting.
    """
    summary_data = {
        'generated_at': time.strftime('%Y-%m-%d %H:%M:%S'),
        'timestamp': time.time(),
        'dialects': dialects or ['sqlite'],
        'selected_dialect': selected_dialect,
        'benchmarks': benchmarks,
        'tools': tools,
        'bench_totals': {b: bench_totals.get(b, 0) for b in benchmarks},
        'tables': [
            {
                'id': re.sub(r'[^a-zA-Z0-9]+', '-', t[0].lower()).strip('-'),
                'title': t[0],
                'headers': t[1],
                'rows': t[2],
                'highlight': t[3] if len(t) > 3 else None
            }
            for t in tables
        ]
    }
    if by_dialect:
        summary_data['by_dialect'] = by_dialect
    with open(output_json_path, 'w', encoding='utf-8') as f:
        json.dump(summary_data, f, indent=2)

def format_refutation_table(title, tools, benchmarks, tool_bench_stats, bench_totals, is_partial_tool_fn=None, tool_eval_stats=None):
    """
    Formats a refutation count comparison table matching the evaluation tables in paper/main.tex.
    Columns: Tool, {bench} ({bench_total}), ..., Total ({overall_total})
    """
    overall_total = sum(bench_totals.get(b, 0) for b in benchmarks)
    headers = ["Tool"] + [f"{b} ({bench_totals.get(b, 0)})" for b in benchmarks] + [f"Total ({overall_total})"]
    eval_stats = tool_eval_stats if tool_eval_stats is not None else tool_bench_stats
    rows = []

    for tool in tools:
        row_vals = [tool]
        is_partial = is_partial_tool_fn(tool) if is_partial_tool_fn else False
        total_neq = 0
        has_unevaluated = False
        for bench in benchmarks:
            pairs = sum(eval_stats[tool].get(bench, {}).values())
            if pairs == 0:
                has_unevaluated = True
                row_vals.append("--")
            else:
                neq = tool_bench_stats[tool][bench].get("NEQ", 0)
                total_neq += neq
                row_vals.append(str(neq))
        if is_partial or has_unevaluated:
            row_vals.append("--")
        else:
            row_vals.append(str(total_neq))
        rows.append(row_vals)
    return title, headers, rows

def format_refutation_origin_table(title, benchmarks, tool_bench_stats):
    """
    Formats the Refutation Origin in LASSO-CC table matching paper/main.tex.
    Columns: Benchmark,Total,Gold,Pred (CC),Gain
    """
    headers = ["Benchmark", "Total", "Gold", "Pred (CC)", "Gain"]
    rows = []
    total_all = 0
    gold_all = 0
    pred_all = 0

    for bench in benchmarks:
        total_refuted = tool_bench_stats['lasso_cc'][bench].get("NEQ", 0)
        gold_refuted = tool_bench_stats['lasso'][bench].get("NEQ", 0)
        pred_refuted = max(0, total_refuted - gold_refuted)
        gain_str = f"+{(pred_refuted / gold_refuted * 100):.1f}%" if gold_refuted > 0 else "+0.0%"
        rows.append([bench, str(total_refuted), str(gold_refuted), str(pred_refuted), gain_str])
        total_all += total_refuted
        gold_all += gold_refuted
        pred_all += pred_refuted

    overall_gain_str = f"+{(pred_all / gold_all * 100):.1f}%" if gold_all > 0 else "+0.0%"
    rows.append(["Overall", str(total_all), str(gold_all), str(pred_all), overall_gain_str])
    return title, headers, rows

def format_execution_time_table(title, tools, benchmarks, tool_bench_times, tool_bench_stats=None, is_partial_tool_fn=None):
    """
    Formats the Total Execution Time table matching paper/main.tex.
    Columns: Tool, {bench}..., Total Time (s)
    """
    headers = ["Tool"] + benchmarks + ["Total Time (s)"]
    rows = []

    for tool in tools:
        row_vals = [tool]
        is_partial = is_partial_tool_fn(tool) if is_partial_tool_fn else False
        total_time = 0.0
        has_unevaluated = False
        for bench in benchmarks:
            pairs = sum(tool_bench_stats[tool].get(bench, {}).values()) if tool_bench_stats else 1
            if tool_bench_stats and pairs == 0:
                has_unevaluated = True
                row_vals.append("--")
            else:
                t_val = tool_bench_times[tool].get(bench, 0.0)
                total_time += t_val
                row_vals.append(f"{t_val:.1f}")
        if is_partial or has_unevaluated:
            row_vals.append("--")
        else:
            row_vals.append(f"{total_time:.1f}")
        rows.append(row_vals)
    return title, headers, rows

def format_time_per_refutation_table(title, tools, benchmarks, tool_bench_times, tool_bench_stats, is_partial_tool_fn=None):
    """
    Formats the Average Time Per Refutation table matching paper/main.tex.
    Columns: Tool, {bench}..., Overall (s)
    """
    headers = ["Tool"] + benchmarks + ["Overall (s)"]
    rows = []

    for tool in tools:
        row_vals = [tool]
        is_partial = is_partial_tool_fn(tool) if is_partial_tool_fn else False
        total_time = 0.0
        total_ref = 0
        has_unevaluated = False
        for bench in benchmarks:
            pairs = sum(tool_bench_stats[tool].get(bench, {}).values()) if tool_bench_stats else 0
            if pairs == 0:
                has_unevaluated = True
                row_vals.append("--")
            else:
                t_val = tool_bench_times[tool].get(bench, 0.0)
                r_val = tool_bench_stats[tool][bench].get("NEQ", 0) if tool_bench_stats else 0
                total_time += t_val
                total_ref += r_val
                if r_val > 0:
                    avg_t = t_val / r_val
                    if avg_t < 0.01:
                        row_vals.append("<0.01")
                    else:
                        row_vals.append(f"{avg_t:.2f}")
                else:
                    row_vals.append("--")

        if is_partial or has_unevaluated:
            row_vals.append("--")
        else:
            overall_avg = (total_time / total_ref) if total_ref > 0 else 0.0
            row_vals.append(f"{overall_avg:.2f}")
        rows.append(row_vals)
    return title, headers, rows

def format_overall_status_table(title, tools, benchmarks, tool_bench_stats, ordered_statuses):
    """
    Formats the consolidated status breakdown table across all tools.
    Columns: Tool, Total query pairs, {ordered_statuses...}
    """
    headers = ["Tool", "Total query pairs"] + ordered_statuses
    rows = []

    for tool in tools:
        total_pairs = sum(sum(tool_bench_stats[tool][b].values()) for b in benchmarks)
        row_vals = [tool, str(total_pairs)]
        for st in ordered_statuses:
            count = sum(tool_bench_stats[tool][b].get(st, 0) for b in benchmarks)
            row_vals.append(str(count))
        rows.append(row_vals)
    return title, headers, rows

def format_tool_status_table(tool, benchmarks, tool_bench_stats, ordered_statuses):
    """
    Formats the per-benchmark status breakdown table for an individual tool.
    Columns: Benchmark, Total query pairs, {ordered_statuses...}
    """
    title = f"Status Breakdown: {tool}"
    headers = ["Benchmark", "Total query pairs"] + ordered_statuses
    rows = []

    overall_pairs = 0
    status_totals = {st: 0 for st in ordered_statuses}

    for bench in benchmarks:
        b_stats = tool_bench_stats[tool].get(bench, {})
        pairs = sum(b_stats.values())
        if pairs == 0:
            row_vals = [bench, "--"] + ["--" for _ in ordered_statuses]
            rows.append(row_vals)
            continue

        overall_pairs += pairs
        row_vals = [bench, str(pairs)]
        for st in ordered_statuses:
            c = b_stats.get(st, 0)
            status_totals[st] += c
            row_vals.append(str(c))
        rows.append(row_vals)

    total_row = ["Total", str(overall_pairs)] + [str(status_totals[st]) for st in ordered_statuses]
    rows.append(total_row)
    return title, headers, rows

def compute_dataset_stats(values):
    """
    Computes summary statistics for a list of integer dataset counts.
    Returns a dict containing: count, mean, median, std_dev, min, max
    """
    if not values:
        return {
            "count": 0, "mean": 0.0, "median": 0.0, "std_dev": 0.0, "min": 0, "max": 0
        }
    n = len(values)
    s = sorted(values)
    total = sum(values)
    mean = total / n
    median = statistics.median(s)
    std_dev = statistics.stdev(values) if n > 1 else 0.0

    return {
        "count": n,
        "mean": mean,
        "median": median,
        "std_dev": std_dev,
        "min": s[0],
        "max": s[-1]
    }

def format_dataset_stats_table(title, benchmarks, dataset_counts_dict, split="gold"):
    """
    Formats summary statistics table for generated datasets per query.
    Columns: Benchmark, Queries, Mean, Median, StdDev, Min, Max
    """
    headers = ["Benchmark", "Queries", "Mean", "Median", "StdDev", "Min", "Max"]
    rows = []

    all_vals = []
    for bench in benchmarks:
        vals = dataset_counts_dict[bench].get(split, [])
        all_vals.extend(vals)
        st = compute_dataset_stats(vals)
        row = [
            bench,
            str(st["count"]),
            f"{st['mean']:.2f}",
            f"{st['median']:.1f}",
            f"{st['std_dev']:.2f}",
            str(st["min"]),
            str(st["max"])
        ]
        rows.append(row)

    tot_st = compute_dataset_stats(all_vals)
    total_row = [
        "Overall",
        str(tot_st["count"]),
        f"{tot_st['mean']:.2f}",
        f"{tot_st['median']:.1f}",
        f"{tot_st['std_dev']:.2f}",
        str(tot_st["min"]),
        str(tot_st["max"])
    ]
    rows.append(total_row)
    return title, headers, rows

def count_cex_rows(file_path: str) -> int:
    """
    Counts the total number of inserted rows/tuples in a reproducible counterexample SQL file.
    """
    if not file_path or not os.path.exists(file_path):
        return 0
    row_count = 0
    try:
        with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
            for line in f:
                line_str = line.strip().upper()
                if line_str.startswith("INSERT INTO"):
                    row_count += 1
    except Exception:
        pass
    return row_count

def compute_cex_stats(values):
    """
    Computes summary statistics for a list of counterexample row counts.
    Returns a dict containing: count, mean, median, std_dev, min, max
    """
    if not values:
        return {
            "count": 0, "mean": 0.0, "median": 0.0, "std_dev": 0.0, "min": 0, "max": 0
        }
    n = len(values)
    s = sorted(values)
    total = sum(values)
    mean = total / n
    median = statistics.median(s)
    std_dev = statistics.stdev(values) if n > 1 else 0.0

    return {
        "count": n,
        "mean": mean,
        "median": median,
        "std_dev": std_dev,
        "min": s[0],
        "max": s[-1]
    }

def format_cex_stats_table(title, benchmarks, cex_row_counts_dict):
    """
    Formats summary statistics table for counterexample dataset sizes (rows per CEX).
    Columns: Benchmark, Refutations, Mean, Median, StdDev, Min, Max
    """
    headers = ["Benchmark", "Refutations", "Mean", "Median", "StdDev", "Min", "Max"]
    rows = []

    all_vals = []
    for bench in benchmarks:
        vals = cex_row_counts_dict.get(bench, [])
        all_vals.extend(vals)
        st = compute_cex_stats(vals)
        row = [
            bench,
            str(st["count"]),
            f"{st['mean']:.2f}",
            f"{st['median']:.1f}",
            f"{st['std_dev']:.2f}",
            str(st["min"]),
            str(st["max"])
        ]
        rows.append(row)

    tot_st = compute_cex_stats(all_vals)
    total_row = [
        "Overall",
        str(tot_st["count"]),
        f"{tot_st['mean']:.2f}",
        f"{tot_st['median']:.1f}",
        f"{tot_st['std_dev']:.2f}",
        str(tot_st["min"]),
        str(tot_st["max"])
    ]
    rows.append(total_row)
    return title, headers, rows

def format_gemini_token_table(title, gemini_token_stats, ordered_benchmarks):
    """
    Formats summary statistics table for LLM token consumption.
    Columns: Experiment, Queries, Input Tokens, Output Tokens, Thinking Tokens, Total Tokens, Avg Input Tokens, Avg Output Tokens, Avg Thinking Tokens
    """
    headers = [
        "Experiment", "Queries", "Input Tokens", "Output Tokens", "Thinking Tokens",
        "Total Tokens", "Avg Input Tokens", "Avg Output Tokens", "Avg Thinking Tokens"
    ]
    rows = []

    total_queries = 0
    total_input = 0
    total_output = 0
    total_thinking = 0
    total_tokens = 0

    exp_keys = [b for b in ordered_benchmarks if b in gemini_token_stats] + [b for b in sorted(gemini_token_stats.keys()) if b not in ordered_benchmarks]

    for exp in exp_keys:
        st = gemini_token_stats[exp]
        q_cnt = st.get("queries", 0)
        inp = st.get("input_tokens", 0)
        out = st.get("output_tokens", 0)
        thk = st.get("thinking_tokens", max(0, st.get("total_tokens", 0) - inp - out))
        tot = st.get("total_tokens", 0)
        avg_inp = (inp / q_cnt) if q_cnt > 0 else 0.0
        avg_out = (out / q_cnt) if q_cnt > 0 else 0.0
        avg_thk = (thk / q_cnt) if q_cnt > 0 else 0.0

        row = [
            exp,
            str(q_cnt),
            str(inp),
            str(out),
            str(thk),
            str(tot),
            f"{avg_inp:.1f}",
            f"{avg_out:.1f}",
            f"{avg_thk:.1f}"
        ]
        rows.append(row)

        total_queries += q_cnt
        total_input += inp
        total_output += out
        total_thinking += thk
        total_tokens += tot

    overall_avg_inp = (total_input / total_queries) if total_queries > 0 else 0.0
    overall_avg_out = (total_output / total_queries) if total_queries > 0 else 0.0
    overall_avg_thk = (total_thinking / total_queries) if total_queries > 0 else 0.0

    total_row = [
        "Overall",
        str(total_queries),
        str(total_input),
        str(total_output),
        str(total_thinking),
        str(total_tokens),
        f"{overall_avg_inp:.1f}",
        f"{overall_avg_out:.1f}",
        f"{overall_avg_thk:.1f}"
    ]
    rows.append(total_row)
    return title, headers, rows


def normalize_dialect_name(d: str) -> str:
    if not d:
        return 'sqlite'
    clean = str(d).strip().lower()
    if clean in ('postgres', 'postgresql'):
        return 'postgresql'
    if clean in ('sqlite', 'sqlite3', 'native'):
        return 'sqlite'
    if clean == 'mysql':
        return 'mysql'
    return clean

def discover_result_csvs(results_dir: str, filter_dialect: str = "all"):
    """
    Discovers all evaluation and datagen CSV files across root results_dir (default SQLite)
    and any dialect-specific subdirectories (e.g. postgresql/, mysql/).
    Returns a list of dicts: {'path': full_path, 'dialect': dialect, 'base_dir': dir_path, 'is_datagen': bool}
    """
    filter_norm = normalize_dialect_name(filter_dialect) if filter_dialect != "all" else "all"
    discovered = []

    # 1. Root results_dir: default (sqlite)
    for f in sorted(glob.glob(os.path.join(results_dir, "*.csv"))):
        basename = os.path.basename(f)
        if basename.startswith("lasso_strategy_kills"):
            continue
        if filter_norm in ("all", "sqlite"):
            discovered.append({
                'path': f,
                'dialect': 'sqlite',
                'base_dir': results_dir,
                'is_datagen': '_datagen_' in basename
            })

    # 2. Dialect subdirectories
    ignored_subdirs = {'raw_cex', 'reproducible_cex', 'lasso_exclusive', 'error_msg', 'arch', 'cross_checking_study', '__pycache__', 'static'}
    if os.path.isdir(results_dir):
        for entry in sorted(os.listdir(results_dir)):
            sub_path = os.path.join(results_dir, entry)
            if os.path.isdir(sub_path) and entry not in ignored_subdirs:
                dialect = normalize_dialect_name(entry)
                if filter_norm not in ("all", dialect):
                    continue
                for f in sorted(glob.glob(os.path.join(sub_path, "*.csv"))):
                    basename = os.path.basename(f)
                    if basename.startswith("lasso_strategy_kills"):
                        continue
                    discovered.append({
                        'path': f,
                        'dialect': dialect,
                        'base_dir': sub_path,
                        'is_datagen': '_datagen_' in basename
                    })
    return discovered

def compute_analysis_tables(eval_items, datagen_items, valid_query_pairs, valid_pairs_per_bench,
                            valid_datagen_keys_per_bench, all_valid_datagen_keys, order_limit_queries_per_bench,
                            order_limit_datagen_keys, script_dir):
    all_tools = set()
    all_benchmarks = set()

    tool_bench_times = defaultdict(lambda: defaultdict(float))
    tools_with_datagen = set()
    lasso_dataset_counts = defaultdict(lambda: defaultdict(list))
    lasso_cex_row_counts = defaultdict(list)
    llm_token_stats = defaultdict(
        lambda: defaultdict(
            lambda: {
                "queries": 0,
                "input_tokens": 0,
                "output_tokens": 0,
                "thinking_tokens": 0,
                "total_tokens": 0
            }
        )
    )

    # 1. Process Datagen Rows
    for item in datagen_items:
        file_path = item['path']
        basename = os.path.basename(file_path)
        name_no_ext = basename[:-4]
        if "_datagen_" not in name_no_ext:
            continue
        raw_prefix, bench_name = name_no_ext.split("_datagen_", 1)
        if raw_prefix.startswith("lasso_strategy_kills"):
            continue
        
        all_benchmarks.add(bench_name)
        tool_prefix = normalize_tool_name(raw_prefix)
        
        with open(file_path, 'r', encoding='utf-8') as f:
            reader = csv.DictReader(f)
            for row in reader:
                try:
                    dg_time = float(row.get("data_gen_time", 0.0))
                except ValueError:
                    dg_time = 0.0
                try:
                    num_ds = int(row.get("num_datasets", 0))
                except ValueError:
                    num_ds = 0

                q_type = row.get("query_type", "gold")
                inst_id = str(row.get("instance_id", "")).strip()
                q_id = str(row.get("query_id", row.get("prediction_id", ""))).strip()

                if all_valid_datagen_keys and (inst_id, q_id) not in all_valid_datagen_keys and (inst_id, "gold") not in all_valid_datagen_keys:
                    continue

                if tool_prefix == "lasso":
                    all_tools.add("lasso")
                    all_tools.add("lasso_cc")
                    tools_with_datagen.add("lasso")
                    tools_with_datagen.add("lasso_cc")

                    # lasso_cc receives all datagen rows (both gold and pred queries)
                    tool_bench_times["lasso_cc"][bench_name] += dg_time
                    # lasso (1-way) receives only gold datagen rows
                    if q_type == "gold":
                        tool_bench_times["lasso"][bench_name] += dg_time

                    # Record dataset counts per query
                    lasso_dataset_counts[bench_name]['all'].append(num_ds)
                    if q_type == "gold":
                        lasso_dataset_counts[bench_name]['gold'].append(num_ds)
                    elif q_type == "pred":
                        lasso_dataset_counts[bench_name]['pred'].append(num_ds)
                elif tool_prefix == "xdata":
                    all_tools.add("xdata_gold")
                    all_tools.add("xdata_cc")
                    tools_with_datagen.add("xdata_gold")
                    tools_with_datagen.add("xdata_cc")

                    tool_bench_times["xdata_cc"][bench_name] += dg_time
                    if q_type == "gold":
                        tool_bench_times["xdata_gold"][bench_name] += dg_time
                elif tool_prefix == "xdatapublic":
                    all_tools.add("xdatapublic")
                    all_tools.add("xdatapublic_cc")
                    tools_with_datagen.add("xdatapublic")
                    tools_with_datagen.add("xdatapublic_cc")

                    tool_bench_times["xdatapublic_cc"][bench_name] += dg_time
                    if q_type == "gold":
                        tool_bench_times["xdatapublic"][bench_name] += dg_time
                elif is_llm_tool(tool_prefix):
                    all_tools.add(tool_prefix)
                    tools_with_datagen.add(tool_prefix)
                    tool_bench_times[tool_prefix][bench_name] += dg_time
                    if tool_prefix.endswith("-tdg"):
                        try:
                            p_tok = int(row.get("prompt_tokens", 0) or 0)
                        except ValueError:
                            p_tok = 0
                        try:
                            c_tok = int(row.get("candidates_tokens", 0) or 0)
                        except ValueError:
                            c_tok = 0
                        try:
                            t_tok = int(row.get("total_tokens", 0) or 0)
                        except ValueError:
                            t_tok = 0
                        try:
                            th_raw = row.get("thoughts_tokens")
                            th_tok = int(th_raw) if (th_raw is not None and str(th_raw).strip() != "") else max(0, t_tok - p_tok - c_tok)
                        except ValueError:
                            th_tok = max(0, t_tok - p_tok - c_tok)
                        llm_token_stats[tool_prefix][bench_name]["queries"] += 1
                        llm_token_stats[tool_prefix][bench_name]["input_tokens"] += p_tok
                        llm_token_stats[tool_prefix][bench_name]["output_tokens"] += c_tok
                        llm_token_stats[tool_prefix][bench_name]["thinking_tokens"] += th_tok
                        llm_token_stats[tool_prefix][bench_name]["total_tokens"] += t_tok
                else:
                    all_tools.add(tool_prefix)
                    tools_with_datagen.add(tool_prefix)
                    tool_bench_times[tool_prefix][bench_name] += dg_time

    # 2. Process Evaluation Rows
    eval_rows = []
    query_tool_statuses = defaultdict(lambda: defaultdict(dict))

    for item in eval_items:
        file_path = item['path']
        base_dir = item['base_dir']
        basename = os.path.basename(file_path)
        name_no_ext = basename[:-4]
        if name_no_ext.startswith("lasso_strategy_kills"):
            continue
        parts = name_no_ext.rsplit('_', 1)
        if len(parts) != 2:
            continue
        raw_tool_name, bench_name = parts
        if raw_tool_name.startswith("lasso_strategy_kills"):
            continue
        tool_name = normalize_tool_name(raw_tool_name)
        
        all_benchmarks.add(bench_name)
        
        with open(file_path, 'r', encoding='utf-8') as f:
            reader = csv.DictReader(f)
            for row in reader:
                status = row.get("EXTEST_STATUS", "").strip()
                time_taken_str = row.get("time_taken", "0")
                try:
                    time_taken = float(time_taken_str) if time_taken_str else 0.0
                except ValueError:
                    time_taken = 0.0
                
                inst_id = str(row.get("instance_id", "")).strip()
                pred_id = str(row.get("prediction_id", "")).strip()
                qid = (inst_id, pred_id)

                if valid_query_pairs and qid not in valid_query_pairs:
                    continue

                ds_source = row.get("dataset_source", row.get("cex_source", "")).strip()

                if tool_name == "lasso":
                    all_tools.add("lasso")
                    all_tools.add("lasso_cc")

                    # 1. lasso (1-way: gold data generation only)
                    if status in ("NEQ", "NEQ_SCO"):
                        cex_rel = row.get("reproducible_cex", "").strip()
                        if cex_rel:
                            full_cex_path = os.path.join(base_dir, cex_rel) if not os.path.isabs(cex_rel) else cex_rel
                            if os.path.exists(full_cex_path):
                                r_cnt = count_cex_rows(full_cex_path)
                                lasso_cex_row_counts[bench_name].append(r_cnt)

                        if ds_source in ("gold", "gold_query"):
                            lasso_status = status
                        else:
                            lasso_status = "EQ_EXEC"
                    elif ds_source.startswith("pred"):
                        lasso_status = "EQ_EXEC"
                    else:
                        lasso_status = status

                    query_tool_statuses[bench_name][qid]["lasso"] = lasso_status
                    eval_rows.append({
                        'tool': 'lasso',
                        'bench': bench_name,
                        'instance_id': inst_id,
                        'prediction_id': pred_id,
                        'status': lasso_status,
                        'time_taken': time_taken
                    })

                    # 2. lasso_cc (cross-checking: gold + pred data generation)
                    query_tool_statuses[bench_name][qid]["lasso_cc"] = status
                    eval_rows.append({
                        'tool': 'lasso_cc',
                        'bench': bench_name,
                        'instance_id': inst_id,
                        'prediction_id': pred_id,
                        'status': status,
                        'time_taken': time_taken
                    })
                elif tool_name == "xdata":
                    all_tools.add("xdata_gold")
                    all_tools.add("xdata_cc")

                    # 1. xdata_gold (1-way: gold data generation only)
                    if status in ("NEQ", "NEQ_SCO"):
                        if ds_source in ("gold", "gold_query"):
                            xdata_status = status
                        else:
                            xdata_status = "EQ_EXEC"
                    elif ds_source.startswith("pred"):
                        xdata_status = "EQ_EXEC"
                    else:
                        xdata_status = status

                    query_tool_statuses[bench_name][qid]["xdata_gold"] = xdata_status
                    eval_rows.append({
                        'tool': 'xdata_gold',
                        'bench': bench_name,
                        'instance_id': inst_id,
                        'prediction_id': pred_id,
                        'status': xdata_status,
                        'time_taken': time_taken
                    })

                    # 2. xdata_cc (cross-checking: gold + pred data generation)
                    query_tool_statuses[bench_name][qid]["xdata_cc"] = status
                    eval_rows.append({
                        'tool': 'xdata_cc',
                        'bench': bench_name,
                        'instance_id': inst_id,
                        'prediction_id': pred_id,
                        'status': status,
                        'time_taken': time_taken
                    })
                elif tool_name == "xdatapublic":
                    all_tools.add("xdatapublic")
                    all_tools.add("xdatapublic_cc")

                    # 1. xdatapublic (1-way: gold data generation only)
                    if status in ("NEQ", "NEQ_SCO"):
                        if ds_source in ("gold", "gold_query"):
                            xdp_status = status
                        else:
                            xdp_status = "EQ_EXEC"
                    elif ds_source.startswith("pred"):
                        xdp_status = "EQ_EXEC"
                    else:
                        xdp_status = status

                    query_tool_statuses[bench_name][qid]["xdatapublic"] = xdp_status
                    eval_rows.append({
                        'tool': 'xdatapublic',
                        'bench': bench_name,
                        'instance_id': inst_id,
                        'prediction_id': pred_id,
                        'status': xdp_status,
                        'time_taken': time_taken
                    })

                    # 2. xdatapublic_cc (cross-checking: gold + pred data generation)
                    query_tool_statuses[bench_name][qid]["xdatapublic_cc"] = status
                    eval_rows.append({
                        'tool': 'xdatapublic_cc',
                        'bench': bench_name,
                        'instance_id': inst_id,
                        'prediction_id': pred_id,
                        'status': status,
                        'time_taken': time_taken
                    })
                else:
                    all_tools.add(tool_name)
                    query_tool_statuses[bench_name][qid][tool_name] = status
                    eval_rows.append({
                        'tool': tool_name,
                        'bench': bench_name,
                        'instance_id': inst_id,
                        'prediction_id': pred_id,
                        'status': status,
                        'time_taken': time_taken
                    })
                    if tool_name not in tools_with_datagen:
                        tool_bench_times[tool_name][bench_name] += time_taken

                    if is_llm_tool(tool_name) and not tool_name.endswith("-tdg"):
                        try:
                            p_tok = int(row.get("prompt_tokens", 0) or 0)
                        except ValueError:
                            p_tok = 0
                        try:
                            c_tok = int(row.get("candidates_tokens", 0) or 0)
                        except ValueError:
                            c_tok = 0
                        try:
                            t_tok = int(row.get("total_tokens", 0) or 0)
                        except ValueError:
                            t_tok = 0
                        try:
                            th_raw = row.get("thoughts_tokens")
                            th_tok = int(th_raw) if (th_raw is not None and str(th_raw).strip() != "") else max(0, t_tok - p_tok - c_tok)
                        except ValueError:
                            th_tok = max(0, t_tok - p_tok - c_tok)
                        llm_token_stats[tool_name][bench_name]["queries"] += 1
                        llm_token_stats[tool_name][bench_name]["input_tokens"] += p_tok
                        llm_token_stats[tool_name][bench_name]["output_tokens"] += c_tok
                        llm_token_stats[tool_name][bench_name]["thinking_tokens"] += th_tok
                        llm_token_stats[tool_name][bench_name]["total_tokens"] += t_tok

    # Sort tools strictly according to canonical paper presentation order:
    # 1. Symbolic baselines
    # 2. LLM tools (sorted by model name, with -er before -tdg)
    # 3. LASSO & LASSO-CC
    symbolic_tools = [t for t in CANONICAL_SYMBOLIC_ORDER if t in all_tools]
    canonical_llm_tools = [t for t in CANONICAL_LLM_ORDER if t in all_tools]
    lasso_tools = [t for t in CANONICAL_LASSO_ORDER if t in all_tools]
    other_tools = sorted(
        [t for t in all_tools if t not in CANONICAL_SYMBOLIC_ORDER and t not in CANONICAL_LLM_ORDER and t not in CANONICAL_LASSO_ORDER],
        key=lambda x: (
            x[:-3] if x.endswith("-er") else (x[:-4] if x.endswith("-tdg") else x),
            0 if x.endswith("-er") else (1 if x.endswith("-tdg") else 2),
            x
        )
    )
    tools = symbolic_tools + canonical_llm_tools + other_tools + lasso_tools
    benchmarks = [b for b in CANONICAL_BENCHMARK_ORDER if b in all_benchmarks] + [b for b in sorted(all_benchmarks) if b not in CANONICAL_BENCHMARK_ORDER]

    # Identify query pairs with TOOL_ERROR in ANY evaluated tool per benchmark
    unsupported_queries_per_bench = defaultdict(set)
    for bench_name, q_map in query_tool_statuses.items():
        for qid, tool_statuses in q_map.items():
            if any(st == "TOOL_ERROR" for st in tool_statuses.values()):
                unsupported_queries_per_bench[bench_name].add(qid)

    # 3. Aggregate statistics across query subsets
    tool_bench_stats = defaultdict(lambda: defaultdict(lambda: defaultdict(int)))
    tool_bench_stats_common = defaultdict(lambda: defaultdict(lambda: defaultdict(int)))
    tool_bench_stats_no_ol = defaultdict(lambda: defaultdict(lambda: defaultdict(int)))

    for row in eval_rows:
        t = row['tool']
        b = row['bench']
        st = row['status']
        qid = (row['instance_id'], row['prediction_id'])

        tool_bench_stats[t][b][st] += 1

        if qid not in unsupported_queries_per_bench.get(b, set()):
            tool_bench_stats_common[t][b][st] += 1

        if qid not in order_limit_queries_per_bench.get(b, set()):
            tool_bench_stats_no_ol[t][b][st] += 1

    bench_totals = {
        b: max((sum(tool_bench_stats[t].get(b, {}).values()) for t in tools if b in tool_bench_stats[t]), default=0)
        for b in benchmarks
    }
    common_bench_totals = {
        b: max((sum(tool_bench_stats_common[t].get(b, {}).values()) for t in tools if b in tool_bench_stats_common[t]), default=0)
        for b in benchmarks
    }
    no_ol_bench_totals = {
        b: max((sum(tool_bench_stats_no_ol[t].get(b, {}).values()) for t in tools if b in tool_bench_stats_no_ol[t]), default=0)
        for b in benchmarks
    }

    all_global_statuses = set()
    for tool in tools:
        for bench in benchmarks:
            for st in tool_bench_stats[tool].get(bench, {}).keys():
                if st and st not in ("EQ", "EQU"):
                    all_global_statuses.add(st)

    priority_statuses = [
        "NEQ",
        "NEQ_SCO",
        "EQ_EXEC",
        "TOOL_ERROR",
        "TIMEOUT",
        "ERROR_QUERY_EXECUTION",
        "ERROR_DATASET_LOADING",
        "ERROR_SYNTAX",
        "NO_CEX",
        "NO_DATASETS"
    ]
    ordered_statuses = [s for s in priority_statuses if s in all_global_statuses] + sorted(
        [s for s in all_global_statuses if s not in priority_statuses]
    )

    table1 = format_refutation_table(
        "Refutations on the Unified Benchmark",
        tools, benchmarks, tool_bench_stats, bench_totals,
        is_partial_tool_fn=lambda t: t.startswith("xdata")
    )

    table2 = format_refutation_table(
        "Refutations on Common Supported Queries",
        tools, benchmarks, tool_bench_stats_common, common_bench_totals,
        is_partial_tool_fn=lambda t: t.startswith("xdata"),
        tool_eval_stats=tool_bench_stats
    )

    table3 = format_refutation_table(
        "Refutations on Queries Excluding ORDER BY and LIMIT",
        tools, benchmarks, tool_bench_stats_no_ol, no_ol_bench_totals,
        is_partial_tool_fn=lambda t: t.startswith("xdata"),
        tool_eval_stats=tool_bench_stats
    )

    table4 = format_refutation_origin_table(
        "Refutation Origin in LASSO-CC",
        benchmarks, tool_bench_stats
    )

    table5 = format_execution_time_table(
        "Total Execution Time (seconds)",
        tools, benchmarks, tool_bench_times,
        tool_bench_stats=tool_bench_stats,
        is_partial_tool_fn=lambda t: t.startswith("xdata")
    )

    table5b = format_time_per_refutation_table(
        "Average Time Per Refutation (seconds)",
        tools, benchmarks, tool_bench_times, tool_bench_stats,
        is_partial_tool_fn=lambda t: t.startswith("xdata")
    )

    table6 = format_dataset_stats_table(
        "LASSO Generated Datasets per Query (All Evaluated Queries)",
        benchmarks, lasso_dataset_counts, split="all"
    )

    table7 = format_cex_stats_table(
        "LASSO Counterexample Dataset Row Counts (Confirmed Refutations)",
        benchmarks, lasso_cex_row_counts
    )

    gemini_token_tables = []
    ordered_llm_tools = [t for t in tools if t in llm_token_stats] + [t for t in sorted(llm_token_stats.keys()) if t not in tools]
    for llm_tool in ordered_llm_tools:
        t_stats = llm_token_stats[llm_tool]
        if t_stats:
            t_tbl = format_gemini_token_table(
                f"{llm_tool} Token Usage Analysis",
                t_stats,
                benchmarks
            )
            gemini_token_tables.append((t_tbl[0], t_tbl[1], t_tbl[2], None))
    if not gemini_token_tables:
        t8_empty = format_gemini_token_table(
            "LLM Token Usage Analysis",
            {},
            benchmarks
        )
        gemini_token_tables.append((t8_empty[0], t8_empty[1], t8_empty[2], None))

    overall_status_table = format_overall_status_table(
        "Overall Status Breakdown",
        tools, benchmarks, tool_bench_stats, ordered_statuses
    )

    tool_status_tables = [
        format_tool_status_table(t, benchmarks, tool_bench_stats, ordered_statuses)
        for t in tools
    ]

    all_tables = [
        (table1[0], table1[1], table1[2], "max"),
        (table2[0], table2[1], table2[2], "max"),
        (table3[0], table3[1], table3[2], "max"),
        (table4[0], table4[1], table4[2], None),
        (table5[0], table5[1], table5[2], "min"),
        (table5b[0], table5b[1], table5b[2], "min"),
        (table6[0], table6[1], table6[2], None),
        (table7[0], table7[1], table7[2], None),
    ] + gemini_token_tables + [
        (overall_status_table[0], overall_status_table[1], overall_status_table[2], {"NEQ": "max"}),
    ] + [(t[0], t[1], t[2], None) for t in tool_status_tables]

    return all_tables, benchmarks, tools, bench_totals


def format_dialect_comparison_table(title, tools, benchmarks, sqlite_results_dir, pg_results_dir, valid_query_pairs=None):
    """
    Formats a dedicated comparison section showing SQLite vs PostgreSQL refutation numbers
    for each tool and each benchmark where PostgreSQL results are available.
    If everything is dash for a benchmark or tool, it is omitted.
    """
    if not os.path.isdir(pg_results_dir):
        return None

    pg_csvs = [
        f for f in glob.glob(os.path.join(pg_results_dir, "*.csv"))
        if not os.path.basename(f).startswith("lasso_strategy_kills") and "_datagen_" not in os.path.basename(f)
    ]
    if not pg_csvs:
        return None

    pg_tool_bench_eval = defaultdict(lambda: defaultdict(dict))
    pg_bench_queries = defaultdict(set)

    for f in pg_csvs:
        basename = os.path.basename(f)[:-4]
        if '_' not in basename:
            continue
        raw_tool, bench_name = basename.rsplit('_', 1)
        tool_name = normalize_tool_name(raw_tool)

        with open(f, 'r', encoding='utf-8') as rf:
            reader = csv.DictReader(rf)
            for row in reader:
                inst_id = str(row.get("instance_id", "")).strip()
                pred_id = str(row.get("prediction_id", "")).strip()
                qid = (inst_id, pred_id)
                if valid_query_pairs and qid not in valid_query_pairs:
                    continue

                status = row.get("EXTEST_STATUS", "").strip()
                ds_source = row.get("dataset_source", row.get("cex_source", "")).strip()
                pg_bench_queries[bench_name].add(qid)

                if tool_name == "lasso":
                    if status in ("NEQ", "NEQ_SCO"):
                        lasso_status = status if ds_source in ("gold", "gold_query") else "EQ_EXEC"
                    elif ds_source.startswith("pred"):
                        lasso_status = "EQ_EXEC"
                    else:
                        lasso_status = status
                    pg_tool_bench_eval['lasso'][bench_name][qid] = lasso_status
                    pg_tool_bench_eval['lasso_cc'][bench_name][qid] = status
                elif tool_name == "xdata":
                    if status in ("NEQ", "NEQ_SCO"):
                        xdata_status = status if ds_source in ("gold", "gold_query") else "EQ_EXEC"
                    elif ds_source.startswith("pred"):
                        xdata_status = "EQ_EXEC"
                    else:
                        xdata_status = status
                    pg_tool_bench_eval['xdata_gold'][bench_name][qid] = xdata_status
                    pg_tool_bench_eval['xdata_cc'][bench_name][qid] = status
                elif tool_name == "xdatapublic":
                    if status in ("NEQ", "NEQ_SCO"):
                        xdp_status = status if ds_source in ("gold", "gold_query") else "EQ_EXEC"
                    elif ds_source.startswith("pred"):
                        xdp_status = "EQ_EXEC"
                    else:
                        xdp_status = status
                    pg_tool_bench_eval['xdatapublic'][bench_name][qid] = xdp_status
                    pg_tool_bench_eval['xdatapublic_cc'][bench_name][qid] = status
                else:
                    pg_tool_bench_eval[tool_name][bench_name][qid] = status

    # Find matching SQLite evaluations for the exact same query pairs
    sqlite_tool_bench_eval = defaultdict(lambda: defaultdict(dict))
    for tool, b_map in pg_tool_bench_eval.items():
        for bench_name, qids in b_map.items():
            base_tool = tool
            if tool in ('lasso_cc', 'lasso'):
                base_tool = 'lasso'
            elif tool in ('xdata_cc', 'xdata_gold'):
                base_tool = 'xdata'
            elif tool in ('xdatapublic_cc', 'xdatapublic'):
                base_tool = 'xdatapublic'
            elif tool == 'parseval-tdg':
                base_tool = 'parseval_tdg'
            elif tool == 'gemini-tdg':
                base_tool = 'gemini_tdg'
            elif tool == 'gemini-er':
                base_tool = 'gemini'

            sqlite_csv = os.path.join(sqlite_results_dir, f"{base_tool}_{bench_name}.csv")
            if not os.path.exists(sqlite_csv):
                sqlite_csv = os.path.join(sqlite_results_dir, "sqlite", f"{base_tool}_{bench_name}.csv")

            if os.path.exists(sqlite_csv):
                with open(sqlite_csv, 'r', encoding='utf-8') as rf:
                    reader = csv.DictReader(rf)
                    for row in reader:
                        inst_id = str(row.get("instance_id", "")).strip()
                        pred_id = str(row.get("prediction_id", "")).strip()
                        qid = (inst_id, pred_id)
                        if qid in qids:
                            st = row.get("EXTEST_STATUS", "").strip()
                            ds_src = row.get("dataset_source", row.get("cex_source", "")).strip()
                            if tool == "lasso":
                                if st in ("NEQ", "NEQ_SCO"):
                                    l_st = st if ds_src in ("gold", "gold_query") else "EQ_EXEC"
                                elif ds_src.startswith("pred"):
                                    l_st = "EQ_EXEC"
                                else:
                                    l_st = st
                                sqlite_tool_bench_eval[tool][bench_name][qid] = l_st
                            elif tool == "lasso_cc":
                                sqlite_tool_bench_eval[tool][bench_name][qid] = st
                            elif tool == "xdata_gold":
                                if st in ("NEQ", "NEQ_SCO"):
                                    xd_st = st if ds_src in ("gold", "gold_query") else "EQ_EXEC"
                                elif ds_src.startswith("pred"):
                                    xd_st = "EQ_EXEC"
                                else:
                                    xd_st = st
                                sqlite_tool_bench_eval[tool][bench_name][qid] = xd_st
                            elif tool == "xdata_cc":
                                sqlite_tool_bench_eval[tool][bench_name][qid] = st
                            elif tool == "xdatapublic":
                                if st in ("NEQ", "NEQ_SCO"):
                                    xdp_st = st if ds_src in ("gold", "gold_query") else "EQ_EXEC"
                                elif ds_src.startswith("pred"):
                                    xdp_st = "EQ_EXEC"
                                else:
                                    xdp_st = st
                                sqlite_tool_bench_eval[tool][bench_name][qid] = xdp_st
                            elif tool == "xdatapublic_cc":
                                sqlite_tool_bench_eval[tool][bench_name][qid] = st
                            else:
                                sqlite_tool_bench_eval[tool][bench_name][qid] = st

    active_bms = [
        b for b in CANONICAL_BENCHMARK_ORDER
        if any(b in pg_tool_bench_eval[t] and len(pg_tool_bench_eval[t][b]) > 0 for t in tools)
    ] + [
        b for b in sorted(pg_bench_queries.keys())
        if b not in CANONICAL_BENCHMARK_ORDER and any(b in pg_tool_bench_eval[t] and len(pg_tool_bench_eval[t][b]) > 0 for t in tools)
    ]
    if not active_bms:
        return None

    headers = ["Tool"]
    for b in active_bms:
        pair_cnt = len(pg_bench_queries[b])
        headers.append(f"{b} SQLite ({pair_cnt})")
        headers.append(f"{b} Postgres ({pair_cnt})")

    rows = []
    for t in tools:
        row_vals = [t]
        has_any_available_number = False

        for b in active_bms:
            if t in pg_tool_bench_eval and b in pg_tool_bench_eval[t] and len(pg_tool_bench_eval[t][b]) > 0:
                pg_neq = sum(1 for st in pg_tool_bench_eval[t][b].values() if st in ("NEQ", "NEQ_SCO"))
                sq_neq = sum(1 for st in sqlite_tool_bench_eval[t][b].values() if st in ("NEQ", "NEQ_SCO"))
                row_vals.append(str(sq_neq))
                row_vals.append(str(pg_neq))
                has_any_available_number = True
            else:
                row_vals.append("--")
                row_vals.append("--")

        # If everything is dash, omit this tool row! Only show available numbers.
        if has_any_available_number:
            rows.append(row_vals)

    if not rows:
        return None

    return title, headers, rows


def main():
    script_dir = os.path.dirname(os.path.abspath(__file__))
    results_dir = os.path.join(script_dir, "results")

    # Parse command-line arguments
    parser = argparse.ArgumentParser(description="Analyze results and generate analysis.txt and analysis_summary.json")
    parser.add_argument("--dialect", type=str, default="sqlite",
                        choices=["sqlite", "postgresql", "postgres", "mysql", "all"],
                        help="Dialect to analyze or filter by: 'sqlite' (default), 'postgresql', etc.")
    parser.add_argument("--skip-verify", "--fast", action="store_true",
                        help="Skip expensive operations such as verifying with queries.json and deduplicating CSVs")
    parser.add_argument("--input-file", type=str, default=None,
                        help="Input queries JSON file (default: queries.json)")
    parser.add_argument("--output-file", type=str, default=None,
                        help="Output text file (default: analysis.txt)")
    args = parser.parse_args()

    # Discover CSV files in results_dir and dialect subdirectories
    discovered = discover_result_csvs(results_dir, filter_dialect=args.dialect)
    datagen_items = [x for x in discovered if x['is_datagen']]
    eval_csv_items = [x for x in discovered if not x['is_datagen']]

    output_filename = args.output_file or os.environ.get('OUTPUT_FILE') or 'analysis.txt'
    output_file = os.path.join(script_dir, output_filename) if not os.path.isabs(output_filename) else output_filename

    skip_verify = args.skip_verify or os.environ.get('SKIP_VERIFY') == '1'
    input_file = args.input_file or os.environ.get('INPUT_FILE') or 'queries.json'
    queries_json_path = os.path.join(script_dir, input_file)
    valid_query_pairs = None
    valid_pairs_per_bench = defaultdict(set)
    valid_datagen_keys_per_bench = defaultdict(set)
    all_valid_datagen_keys = set()
    order_limit_queries_per_bench = defaultdict(set)
    order_limit_datagen_keys = set()

    if skip_verify:
        print("Skipping verification with benchmark queries (--skip-verify flag set).")
    elif os.path.exists(os.path.join(script_dir, 'benchmarks')):
        print("Loading valid queries from benchmarks/...")
        try:
            import benchmark_loader
            queries_data, _ = benchmark_loader.load_benchmark_data(benchmark='all', base_dir=script_dir)
            valid_query_pairs = set()
            for item in queries_data:
                src = item.get('source', '')
                inst_id = str(item.get('id') or item.get('instance_id', '')).strip()
                if not inst_id:
                    continue

                gold_sql = item.get('gold_sql', '')
                dialect = item.get('dialect')
                gold_has_ol = has_order_by_or_limit(gold_sql, dialect)

                valid_datagen_keys_per_bench[src].add((inst_id, "gold"))
                valid_datagen_keys_per_bench[src].add((inst_id, inst_id))
                all_valid_datagen_keys.add((inst_id, "gold"))
                all_valid_datagen_keys.add((inst_id, inst_id))

                if gold_has_ol:
                    order_limit_datagen_keys.add((inst_id, "gold"))
                    order_limit_datagen_keys.add((inst_id, inst_id))

                for pred in item.get('predictions', []):
                    pred_id = str(pred.get('prediction_id', '')).strip()
                    if pred_id:
                        valid_query_pairs.add((inst_id, pred_id))
                        if src:
                            valid_pairs_per_bench[src].add((inst_id, pred_id))
                        valid_datagen_keys_per_bench[src].add((inst_id, pred_id))
                        all_valid_datagen_keys.add((inst_id, pred_id))

                        pred_sql = pred.get('prediction_sql', '')
                        pred_has_ol = has_order_by_or_limit(pred_sql, dialect)
                        if not pred_has_ol:
                            for k, v in pred.items():
                                if k.startswith('prediction_sql_') and isinstance(v, str):
                                    if has_order_by_or_limit(v, dialect):
                                        pred_has_ol = True
                                        break

                        if pred_has_ol:
                            order_limit_datagen_keys.add((inst_id, pred_id))

                        if gold_has_ol or pred_has_ol:
                            if src:
                                order_limit_queries_per_bench[src].add((inst_id, pred_id))

            total_ol = sum(len(s) for s in order_limit_queries_per_bench.values())
            print(f"  Loaded {len(valid_query_pairs)} valid query pairs across {len(valid_pairs_per_bench)} benchmarks ({total_ol} pairs with ORDER BY / LIMIT).")
        except Exception as e:
            print(f"  Warning: Could not load {queries_json_path}: {e}")
            valid_query_pairs = None

    # Deduplicate and filter all evaluation and datagen CSV files
    if not skip_verify:
        print("Deduplicating and filtering CSV files in results directory...")
        total_eval_dups = 0
        total_eval_orphans = 0
        for item in eval_csv_items:
            file_path = item['path']
            basename = os.path.basename(file_path)
            bench_name = basename[:-4].rsplit('_', 1)[-1] if '_' in basename[:-4] else ''
            bench_valid_pairs = valid_pairs_per_bench.get(bench_name, valid_query_pairs) if valid_query_pairs is not None else None
            dups, orphans = csv_utils.deduplicate_csv(file_path, valid_query_pairs=bench_valid_pairs)
            if dups > 0 or orphans > 0:
                msg = []
                if dups > 0:
                    msg.append(f"{dups} duplicate rows")
                if orphans > 0:
                    msg.append(f"{orphans} orphaned rows not in {os.path.basename(queries_json_path)}")
                print(f"  Cleaned {os.path.basename(file_path)}: removed {', '.join(msg)}")
                total_eval_dups += dups
                total_eval_orphans += orphans

        total_datagen_dups = 0
        total_datagen_orphans = 0
        for item in datagen_items:
            file_path = item['path']
            basename = os.path.basename(file_path)
            bench_name = basename[:-4].split('_datagen_', 1)[-1] if '_datagen_' in basename[:-4] else ''
            bench_valid_dg = valid_datagen_keys_per_bench.get(bench_name, all_valid_datagen_keys) if all_valid_datagen_keys else None
            dups, orphans = csv_utils.deduplicate_datagen_csv(file_path, valid_datagen_keys=bench_valid_dg)
            if dups > 0 or orphans > 0:
                msg = []
                if dups > 0:
                    msg.append(f"{dups} duplicate rows")
                if orphans > 0:
                    msg.append(f"{orphans} orphaned rows not in {os.path.basename(queries_json_path)}")
                print(f"  Cleaned {os.path.basename(file_path)}: removed {', '.join(msg)}")
                total_datagen_dups += dups
                total_datagen_orphans += orphans

        if total_eval_dups > 0 or total_eval_orphans > 0 or total_datagen_dups > 0 or total_datagen_orphans > 0:
            print(f"Deduplication and filtering complete: removed {total_eval_dups} eval duplicates, {total_eval_orphans} orphaned eval rows, {total_datagen_dups} datagen duplicates, {total_datagen_orphans} orphaned datagen rows.\n")
        else:
            print("All CSV files are clean (no duplicates or orphaned rows found).\n")
    else:
        print("Skipping CSV deduplication and filtering (--skip-verify flag set).\n")

    # Compute main dialect tables
    all_tables, benchmarks, tools, bench_totals = compute_analysis_tables(
        eval_csv_items, datagen_items, valid_query_pairs, valid_pairs_per_bench,
        valid_datagen_keys_per_bench, all_valid_datagen_keys, order_limit_queries_per_bench,
        order_limit_datagen_keys, script_dir
    )

    # Compute dedicated Dialect Comparison table (SQLite vs PostgreSQL)
    pg_results_dir = os.path.join(results_dir, "postgresql")
    dialect_comp_table = format_dialect_comparison_table(
        "Dialect Comparison: SQLite vs. PostgreSQL",
        tools, benchmarks, results_dir, pg_results_dir,
        valid_query_pairs=valid_query_pairs
    )
    if dialect_comp_table:
        all_tables.append((dialect_comp_table[0], dialect_comp_table[1], dialect_comp_table[2], "max"))

    norm_d = normalize_dialect_name(args.dialect)
    by_dialect = {
        norm_d: {
            'benchmarks': benchmarks,
            'tools': tools,
            'bench_totals': {b: bench_totals.get(b, 0) for b in benchmarks},
            'tables': [
                {
                    'id': re.sub(r'[^a-zA-Z0-9]+', '-', t[0].lower()).strip('-'),
                    'title': t[0],
                    'headers': t[1],
                    'rows': t[2],
                    'highlight': t[3] if len(t) > 3 else None
                }
                for t in all_tables
            ]
        }
    }

    # If analyzing SQLite and PostgreSQL results exist, also compute PostgreSQL tables for by_dialect['postgresql']
    pg_discovered = discover_result_csvs(results_dir, filter_dialect="postgresql")
    discovered_dialects = [norm_d]
    if norm_d == "sqlite" and pg_discovered:
        pg_dg = [x for x in pg_discovered if x['is_datagen']]
        pg_eval = [x for x in pg_discovered if not x['is_datagen']]
        if pg_eval or pg_dg:
            p_tables, p_benchmarks, p_tools, p_bench_totals = compute_analysis_tables(
                pg_eval, pg_dg, valid_query_pairs, valid_pairs_per_bench,
                valid_datagen_keys_per_bench, all_valid_datagen_keys, order_limit_queries_per_bench,
                order_limit_datagen_keys, script_dir
            )
            if dialect_comp_table:
                p_tables.append((dialect_comp_table[0], dialect_comp_table[1], dialect_comp_table[2], "max"))
            by_dialect['postgresql'] = {
                'benchmarks': p_benchmarks,
                'tools': p_tools,
                'bench_totals': {b: p_bench_totals.get(b, 0) for b in p_benchmarks},
                'tables': [
                    {
                        'id': re.sub(r'[^a-zA-Z0-9]+', '-', t[0].lower()).strip('-'),
                        'title': t[0],
                        'headers': t[1],
                        'rows': t[2],
                        'highlight': t[3] if len(t) > 3 else None
                    }
                    for t in p_tables
                ]
            }
            discovered_dialects.append("postgresql")

    all_blocks = [render_table(t[0], t[1], t[2]) for t in all_tables]

    # Write single consolidated text file
    with open(output_file, 'w', encoding='utf-8') as out:
        for idx, block in enumerate(all_blocks):
            out.write("\n".join(block) + "\n")
            if idx < len(all_blocks) - 1:
                out.write("\n")

    # Write structured summary JSON for interactive viewer
    json_output_path = os.path.splitext(output_file)[0] + '_summary.json'
    save_summary_data(
        all_tables, json_output_path, benchmarks, tools, bench_totals,
        dialects=discovered_dialects, selected_dialect=args.dialect, by_dialect=by_dialect
    )
    if json_output_path != os.path.join(script_dir, 'analysis_summary.json'):
        save_summary_data(
            all_tables, os.path.join(script_dir, 'analysis_summary.json'), benchmarks, tools, bench_totals,
            dialects=discovered_dialects, selected_dialect=args.dialect, by_dialect=by_dialect
        )



    print(f"Analysis saved successfully to {output_file}")
    print(f"Analysis summary JSON saved to {json_output_path}\n")

    # Clean up obsolete separate analysis files if they exist
    for obsolete_file in ["analysis_common_supported.csv", "analysis_no_order_by_limit.csv", "analysis.csv"]:
        obs_path = os.path.join(script_dir, obsolete_file)
        if os.path.exists(obs_path) and obs_path != output_file:
            try:
                os.remove(obs_path)
                print(f"Removed obsolete file: {obsolete_file}")
            except Exception:
                pass

    # Print clean summary tables to console
    for block in all_blocks:
        print("\n".join(block))
        print()

if __name__ == '__main__':
    main()
