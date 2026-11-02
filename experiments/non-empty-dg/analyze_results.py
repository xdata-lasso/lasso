#!/usr/bin/env python3
"""
Analysis and HTML Report Generator for Non-Empty Data Generation Experiments.

Aggregates execution results across all benchmarks in benchmarks/<benchmark>/DDL.sql and queries.txt
and tools (LASSO, ParSEval, XData, XDataPublic, Gemini).
Produces:
  - Terminal formatted summary tables
  - Plain-text formatted report (analysis.txt)
  - Rich, interactive, styled HTML report (analysis.html)

Usage:
  python3 analyze_results.py [--html analysis.html] [--output analysis.txt] [--benchmark <name>]
"""

import os
import sys
import csv
import json
import re
import html
import argparse
from datetime import datetime
from collections import defaultdict
from typing import Dict, List, Tuple, Any

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
BENCHMARKS_DIR = os.path.join(SCRIPT_DIR, "benchmarks")
RESULTS_DIR = os.path.join(SCRIPT_DIR, "results")
DEFAULT_HTML_PATH = os.path.join(SCRIPT_DIR, "analysis.html")
DEFAULT_TXT_PATH = os.path.join(SCRIPT_DIR, "analysis.txt")

CANONICAL_TOOL_ORDER = [
    "lasso",
    "parseval",
    "xdata",
    "xdatapublic",
    "gemini",
]

TOOL_DISPLAY_NAMES = {
    "lasso": "LASSO",
    "parseval": "ParSEval",
    "xdata": "XData",
    "xdatapublic": "XDataPublic",
    "gemini": "Gemini (LLM)",
}


def natural_sort_key(s: str) -> list:
    parts = re.split(r'(\d+)', str(s))
    return [int(p) if p.isdigit() else p.lower() for p in parts]


def render_ascii_table(title: str, headers: List[str], rows: List[List[str]]) -> List[str]:
    """Renders a cleanly formatted ASCII table."""
    if not headers:
        return [title] if title else []

    num_cols = len(headers)
    col_widths = [len(str(h)) for h in headers]
    for row in rows:
        for i in range(min(len(row), num_cols)):
            col_widths[i] = max(col_widths[i], len(str(row[i])))

    col_widths = [w + 2 for w in col_widths]

    div_line = "+" + "+".join("-" * w for w in col_widths) + "+"
    hdr_line = "|" + "|".join(f" {str(headers[i]):<{col_widths[i]-2}} " for i in range(num_cols)) + "|"
    eq_line = "+" + "+".join("=" * w for w in col_widths) + "+"

    lines = []
    if title:
        lines.append(title)
    lines.append(div_line)
    lines.append(hdr_line)
    lines.append(eq_line)

    for row in rows:
        row_cells = []
        for i in range(num_cols):
            val = str(row[i]) if i < len(row) else ""
            if i == 0:
                row_cells.append(f" {val:<{col_widths[i]-2}} ")
            else:
                row_cells.append(f" {val:>{col_widths[i]-2}} ")
        lines.append("|" + "|".join(row_cells) + "|")

    lines.append(div_line)
    return lines


def load_all_benchmarks(bench_dir: str) -> Dict[str, Dict[str, Any]]:
    """Loads all benchmarks from subdirectories containing queries.txt and DDL.sql."""
    benchmarks = {}
    if not os.path.exists(bench_dir):
        return benchmarks

    for b_item in sorted(os.listdir(bench_dir)):
        if b_item in ["sqlite", "mysql", "postgres", "stats", "__pycache__"]:
            continue
        b_path = os.path.join(bench_dir, b_item)
        if not os.path.isdir(b_path):
            continue

        queries_json = os.path.join(b_path, "queries.json")
        queries_file = os.path.join(b_path, "queries.txt")
        ddl_file = os.path.join(b_path, "DDL.sql")
        if not os.path.exists(queries_file) and not os.path.exists(queries_json):
            continue

        q_ids = []
        if os.path.exists(queries_json):
            try:
                import json
                with open(queries_json, "r", encoding="utf-8") as f:
                    data = json.load(f)
                for idx, item in enumerate(data):
                    if isinstance(item, dict) and "id" in item:
                        q_ids.append(item["id"])
                    else:
                        q_ids.append(f"q{idx+1:02d}")
            except Exception:
                q_ids = []

        if not q_ids and os.path.exists(queries_file):
            with open(queries_file, "r", encoding="utf-8") as f:
                for idx, line in enumerate(f):
                    line_s = line.strip()
                    if not line_s or line_s.startswith("--"):
                        continue
                    if "|" in line_s and not line_s.upper().startswith("SELECT") and not line_s.upper().startswith("WITH"):
                        qid = line_s.split("|", 1)[0].strip()
                    else:
                        qid = f"q{idx+1:02d}"
                    q_ids.append(qid)

        display_name = "ManyRowsBM" if b_item in ["many_rows_bm", "manyrowsbm"] else b_item.replace("_", " ").title()
        benchmarks[b_item] = {
            "name": display_name,
            "query_ids": q_ids,
            "total_queries": len(q_ids)
        }
    return benchmarks


def load_all_results(results_dir: str) -> Dict[str, Dict[str, Dict[str, Any]]]:
    """
    Loads all tool evaluation results organized by benchmark and tool.
    Returns: {benchmark: {tool: {query_id: {status, row_count, elapsed_seconds, error}}}}
    """
    results = defaultdict(dict)
    if not os.path.exists(results_dir):
        return results

    try:
        csv.field_size_limit(sys.maxsize)
    except OverflowError:
        csv.field_size_limit(2147483647)

    for b_item in os.listdir(results_dir):
        b_path = os.path.join(results_dir, b_item)
        if not os.path.isdir(b_path):
            continue
        bench_name = b_item

        for t_item in os.listdir(b_path):
            t_path = os.path.join(b_path, t_item)
            if not os.path.isdir(t_path):
                continue

            tool_name = t_item
            if tool_name.startswith("results_"):
                tool_name = tool_name[len("results_"):]
            elif tool_name == "results":
                tool_name = "lasso"
            tool_name = tool_name.lower()

            csv_file = os.path.join(t_path, "results.csv")
            if not os.path.isfile(csv_file):
                continue

            tool_results = {}
            try:
                with open(csv_file, "r", encoding="utf-8", errors="ignore") as f:
                    reader = csv.DictReader(f)
                    for row in reader:
                        qid = str(row.get("query_id", "")).strip()
                        if not qid:
                            continue
                        status = str(row.get("status", "UNKNOWN")).strip().upper()
                        try:
                            rows_cnt = int(row.get("row_count", 0) or 0)
                        except ValueError:
                            rows_cnt = 0
                        time_raw = row.get("elapsed_seconds") or row.get("time_sec") or 0.0
                        try:
                            tm = float(time_raw)
                        except ValueError:
                            tm = 0.0
                        err = str(row.get("error_message") or row.get("error_msg") or "").strip()
                        tool_results[qid] = {
                            "status": status,
                            "rows": rows_cnt,
                            "time": tm,
                            "error": err
                        }
            except Exception:
                continue

            if tool_results:
                results[bench_name][tool_name] = tool_results

    return results


def build_analysis_data(benchmarks: Dict[str, Dict[str, Any]], results: Dict[str, Dict[str, Dict[str, Any]]]):
    """Aggregates benchmark metrics and query-level comparisons across all tools."""
    all_bench_names = sorted(list(set(benchmarks.keys()) | set(results.keys())), key=natural_sort_key)
    all_tools_set = set()
    for b in results:
        for t in results[b]:
            all_tools_set.add(t)

    tools = [t for t in CANONICAL_TOOL_ORDER if t in all_tools_set] + sorted(
        [t for t in all_tools_set if t not in CANONICAL_TOOL_ORDER]
    )

    bench_stats = {}
    for b_name in all_bench_names:
        b_info = benchmarks.get(b_name, {})
        display_name = b_info.get("name", b_name)
        q_ids = b_info.get("query_ids", [])

        if not q_ids and b_name in results:
            q_ids_set = set()
            for t in results[b_name]:
                q_ids_set.update(results[b_name][t].keys())
            q_ids = sorted(list(q_ids_set), key=natural_sort_key)

        bench_stats[b_name] = {
            "name": display_name,
            "query_ids": q_ids,
            "total_queries": len(q_ids),
            "tool_metrics": {}
        }

        for t in tools:
            t_res = results.get(b_name, {}).get(t, {})
            if not t_res:
                continue

            evaluated_qids = [q for q in q_ids if q in t_res]
            ok_cnt = sum(1 for q in evaluated_qids if t_res[q]["status"] == "OK" and t_res[q]["rows"] > 0)
            empty_cnt = sum(1 for q in evaluated_qids if t_res[q]["status"] == "EMPTY")
            err_cnt = sum(1 for q in evaluated_qids if t_res[q]["status"] == "ERROR")
            timeout_cnt = sum(1 for q in evaluated_qids if t_res[q]["status"] == "TIMEOUT")
            total_time = sum(t_res[q]["time"] for q in evaluated_qids)
            avg_time = (total_time / len(evaluated_qids)) if evaluated_qids else 0.0

            bench_stats[b_name]["tool_metrics"][t] = {
                "evaluated": len(evaluated_qids),
                "ok": ok_cnt,
                "empty": empty_cnt,
                "error": err_cnt,
                "timeout": timeout_cnt,
                "total_time": total_time,
                "avg_time": avg_time,
                "pct": (ok_cnt / len(q_ids) * 100.0) if q_ids else 0.0,
            }

    return all_bench_names, tools, bench_stats


def format_overview_table(bench_names: List[str], tools: List[str], bench_stats: Dict[str, Any]) -> Tuple[str, List[str], List[List[str]]]:
    """Formats the consolidated cross-benchmark summary table."""
    headers = ["Tool"]
    for b in bench_names:
        tot = bench_stats[b]["total_queries"]
        b_name = bench_stats[b]["name"]
        headers.append(f"{b_name} ({tot})")
        headers.append(f"{b_name} Time (s)")

    headers.append("Total Non-Empty")
    headers.append("Total Time (s)")

    rows = []
    total_queries_sum = sum(bench_stats[b]["total_queries"] for b in bench_names)

    for t in tools:
        t_display = TOOL_DISPLAY_NAMES.get(t, t.upper())
        row = [t_display]
        tool_total_ok = 0
        tool_total_time = 0.0
        participated_all = True

        for b in bench_names:
            metrics = bench_stats[b]["tool_metrics"].get(t)
            tot = bench_stats[b]["total_queries"]
            if metrics:
                ok = metrics["ok"]
                pct = metrics["pct"]
                tm = metrics["total_time"]
                row.append(f"{ok}/{tot} ({pct:.1f}%)")
                row.append(f"{tm:.2f}")
                tool_total_ok += ok
                tool_total_time += tm
            else:
                row.append("--")
                row.append("--")
                participated_all = False

        if participated_all and total_queries_sum > 0:
            tot_pct = (tool_total_ok / total_queries_sum * 100.0)
            row.append(f"{tool_total_ok}/{total_queries_sum} ({tot_pct:.1f}%)")
            row.append(f"{tool_total_time:.2f}")
        elif tool_total_ok > 0:
            row.append(f"{tool_total_ok} (partial)")
            row.append(f"{tool_total_time:.2f}")
        else:
            row.append("--")
            row.append("--")

        rows.append(row)

    return "Consolidated Non-Empty Data Generation Overview", headers, rows


def format_status_breakdown_table(bench_names: List[str], tools: List[str], bench_stats: Dict[str, Any]) -> Tuple[str, List[str], List[List[str]]]:
    """Formats detailed status breakdown table (OK, EMPTY, ERROR, TIMEOUT)."""
    headers = ["Tool", "Benchmark", "Evaluated", "Non-Empty (OK)", "Empty", "Error", "Timeout", "Total Time (s)"]
    rows = []

    for t in tools:
        t_display = TOOL_DISPLAY_NAMES.get(t, t.upper())
        for b in bench_names:
            metrics = bench_stats[b]["tool_metrics"].get(t)
            b_name = bench_stats[b]["name"]
            if not metrics:
                continue
            rows.append([
                t_display,
                b_name,
                str(metrics["evaluated"]),
                f"{metrics['ok']} ({metrics['pct']:.1f}%)",
                str(metrics["empty"]),
                str(metrics["error"]),
                str(metrics["timeout"]),
                f"{metrics['total_time']:.2f}"
            ])

    return "Detailed Tool Status Breakdown", headers, rows


def generate_html_report(
    bench_names: List[str],
    tools: List[str],
    bench_stats: Dict[str, Any],
    results: Dict[str, Dict[str, Dict[str, Any]]] = None,
    output_html_path: str = DEFAULT_HTML_PATH
):
    """Generates a standalone, responsive, modern HTML report with separate tables for each benchmark."""
    now_str = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    total_benchmarks = len(bench_names)
    total_queries = sum(bench_stats[b]["total_queries"] for b in bench_names)
    total_tools = len(tools)

    best_tool = "N/A"
    best_rate = -1.0
    for t in tools:
        tot_ok = sum(bench_stats[b]["tool_metrics"].get(t, {}).get("ok", 0) for b in bench_names)
        tot_eval = sum(bench_stats[b]["tool_metrics"].get(t, {}).get("evaluated", 0) for b in bench_names)
        if tot_eval > 0:
            rate = (tot_ok / tot_eval) * 100.0
            if rate > best_rate:
                best_rate = rate
                best_tool = TOOL_DISPLAY_NAMES.get(t, t.upper())

    # Benchmark quick jump navigation
    nav_pills = []
    for b in bench_names:
        b_name = bench_stats[b]["name"]
        tot = bench_stats[b]["total_queries"]
        nav_pills.append(
            f'<a href="#bench-{b}" class="nav-pill">{html.escape(b_name)} <span class="pill-count">({tot})</span></a>'
        )
    nav_html = f"""
    <div class="nav-card">
        <span class="nav-label">Benchmarks:</span>
        <div class="nav-pills">
            {''.join(nav_pills)}
        </div>
    </div>
    """

    # Build separate table for each benchmark
    table_headers = [
        "Tool",
        "Evaluated",
        "Non-Empty (OK)",
        "Error",
        "Timeout",
        "Total Time",
        "Avg Time",
    ]

    bench_tables_html = []
    chart_scripts = []
    for b in bench_names:
        b_name = bench_stats[b]["name"]
        tot_queries = bench_stats[b]["total_queries"]

        evaluated_tools = []
        unevaluated_tools = []
        for t in tools:
            metrics = bench_stats[b]["tool_metrics"].get(t)
            if metrics and metrics["evaluated"] > 0:
                evaluated_tools.append((t, metrics))
            else:
                unevaluated_tools.append(t)

        rows_html = []
        chart_html = ""
        if evaluated_tools:
            labels = [TOOL_DISPLAY_NAMES.get(t, t.upper()) for t, _ in evaluated_tools]
            ok_vals = [m["ok"] for _, m in evaluated_tools]
            time_vals = [round(m["avg_time"], 2) for _, m in evaluated_tools]
            safe_bid = re.sub(r'[^a-zA-Z0-9_]', '_', b)

            chart_html = f"""
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 16px; margin-bottom: 16px;">
                <div style="background: #f8fafc; border: 1px solid var(--border); border-radius: 8px; padding: 12px;">
                    <div style="font-size: 12px; font-weight: 600; color: #475569; margin-bottom: 4px;">Non-Empty OK Count by Tool</div>
                    <div style="height: 180px; position: relative;"><canvas id="chart_{safe_bid}_ok"></canvas></div>
                </div>
                <div style="background: #f8fafc; border: 1px solid var(--border); border-radius: 8px; padding: 12px;">
                    <div style="font-size: 12px; font-weight: 600; color: #475569; margin-bottom: 4px;">Average Time (seconds) by Tool</div>
                    <div style="height: 180px; position: relative;"><canvas id="chart_{safe_bid}_time"></canvas></div>
                </div>
            </div>
            """

            chart_scripts.append(f"""
            (function() {{
                const ctxOk = document.getElementById('chart_{safe_bid}_ok');
                if (ctxOk) {{
                    new Chart(ctxOk.getContext('2d'), {{
                        type: 'bar',
                        data: {{
                            labels: {json.dumps(labels)},
                            datasets: [{{
                                label: 'Non-Empty (OK)',
                                data: {json.dumps(ok_vals)},
                                backgroundColor: 'rgba(16, 185, 129, 0.85)',
                                borderColor: '#059669',
                                borderWidth: 1,
                                borderRadius: 4
                            }}]
                        }},
                        options: {{
                            indexAxis: 'y',
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: {{ legend: {{ display: false }} }},
                            scales: {{ x: {{ beginAtZero: true }} }}
                        }}
                    }});
                }}
                const ctxTime = document.getElementById('chart_{safe_bid}_time');
                if (ctxTime) {{
                    new Chart(ctxTime.getContext('2d'), {{
                        type: 'bar',
                        data: {{
                            labels: {json.dumps(labels)},
                            datasets: [{{
                                label: 'Avg Time (s)',
                                data: {json.dumps(time_vals)},
                                backgroundColor: 'rgba(59, 130, 246, 0.85)',
                                borderColor: '#2563eb',
                                borderWidth: 1,
                                borderRadius: 4
                            }}]
                        }},
                        options: {{
                            indexAxis: 'y',
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: {{ legend: {{ display: false }} }},
                            scales: {{ x: {{ beginAtZero: true }} }}
                        }}
                    }});
                }}
            }})();
            """)

            for t, m in evaluated_tools:
                t_display = TOOL_DISPLAY_NAMES.get(t, t.upper())
                eval_cnt = m["evaluated"]
                ok_cnt = m["ok"]
                err_cnt = m["error"]
                timeout_cnt = m["timeout"]
                tot_time = m["total_time"]
                avg_time = m["avg_time"]

                eval_display = f"{eval_cnt} / {tot_queries}"

                rows_html.append(f"""
                <tr>
                    <td class="tool-cell"><strong>{html.escape(t_display)}</strong></td>
                    <td class="num-cell">{eval_display}</td>
                    <td class="num-cell">{ok_cnt}</td>
                    <td class="num-cell">{err_cnt}</td>
                    <td class="num-cell">{timeout_cnt}</td>
                    <td class="num-cell">{tot_time:.2f}s</td>
                    <td class="num-cell">{avg_time:.2f}s</td>
                </tr>
                """)
        else:
            rows_html.append(f"""
            <tr>
                <td colspan="{len(table_headers)}" class="empty-cell" style="text-align: center; padding: 24px;">
                    No tool evaluation data available for this benchmark.
                </td>
            </tr>
            """)

        footer_note = ""
        if unevaluated_tools:
            uneval_names = [TOOL_DISPLAY_NAMES.get(t, t.upper()) for t in unevaluated_tools]
            footer_note = f"""
            <div class="card-footer-note">
                <span class="note-label">Not evaluated on this benchmark:</span> {html.escape(', '.join(uneval_names))}
            </div>
            """

        bench_tables_html.append(f"""
        <div class="benchmark-card" id="bench-{b}">
            <div class="benchmark-header">
                <div class="benchmark-title-group">
                    <h2 class="benchmark-title">{html.escape(b_name)}</h2>
                    <span class="benchmark-count-badge">{tot_queries} Queries</span>
                </div>
            </div>
            {chart_html}
            <div class="table-container">
                <table class="report-table">
                    <thead>
                        <tr>{''.join(f'<th>{html.escape(h)}</th>' for h in table_headers)}</tr>
                    </thead>
                    <tbody>
                        {''.join(rows_html)}
                    </tbody>
                </table>
            </div>
            {footer_note}
        </div>
        """)

    html_content = f"""<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Non-Empty Data Generation Evaluation Report</title>
    <!-- Chart.js for Benchmark Performance Bar Charts -->
    <script src="/static/chart.umd.min.js"></script>
    <script>
      if (typeof Chart === 'undefined') {{
        document.write('<script src="https://cdn.jsdelivr.net/npm/chart.js"><\\/script>');
      }}
    </script>
    <style>
        :root {{
            --primary: #1e3a8a;
            --bg: #f8fafc;
            --card-bg: #ffffff;
            --border: #e2e8f0;
            --text: #0f172a;
            --text-muted: #64748b;
        }}
        html {{ scroll-behavior: smooth; }}
        * {{ box-sizing: border-box; margin: 0; padding: 0; }}
        body {{
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            background-color: var(--bg);
            color: var(--text);
            line-height: 1.5;
            padding: 24px;
        }}
        .container {{ max-width: 1400px; margin: 0 auto; }}
        .header {{
            background: #1e3a8a;
            color: white;
            padding: 32px;
            border-radius: 12px;
            margin-bottom: 24px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }}
        .header h1 {{ font-size: 28px; font-weight: 700; margin-bottom: 8px; }}
        .header p {{ opacity: 0.9; font-size: 14px; }}
        .stats-grid {{
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 16px;
            margin-bottom: 24px;
        }}
        .stat-card {{
            background: var(--card-bg);
            padding: 20px;
            border-radius: 10px;
            border: 1px solid var(--border);
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }}
        .stat-card .label {{ font-size: 12px; color: var(--text-muted); text-transform: uppercase; font-weight: 600; }}
        .stat-card .value {{ font-size: 26px; font-weight: 700; color: var(--text); margin-top: 4px; }}
        .nav-card {{
            background: var(--card-bg);
            border-radius: 10px;
            border: 1px solid var(--border);
            padding: 16px 20px;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 12px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }}
        .nav-label {{
            font-size: 13px;
            font-weight: 700;
            color: var(--text-muted);
            text-transform: uppercase;
            white-space: nowrap;
        }}
        .nav-pills {{
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
        }}
        .nav-pill {{
            text-decoration: none;
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 500;
            background: #f1f5f9;
            color: #334155;
            transition: all 0.15s ease;
        }}
        .nav-pill:hover {{
            background: #e2e8f0;
            color: #0f172a;
        }}
        .nav-pill .pill-count {{
            font-size: 11px;
            opacity: 0.8;
            font-weight: normal;
        }}
        .benchmark-card {{
            background: var(--card-bg);
            border-radius: 12px;
            border: 1px solid var(--border);
            padding: 24px;
            margin-bottom: 24px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
            scroll-margin-top: 24px;
        }}
        .benchmark-header {{
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 16px;
            border-bottom: 1px solid var(--border);
            padding-bottom: 12px;
        }}
        .benchmark-title-group {{
            display: flex;
            align-items: center;
            gap: 12px;
        }}
        .benchmark-title {{
            font-size: 20px;
            font-weight: 700;
            color: var(--text);
        }}
        .benchmark-count-badge {{
            background: #f1f5f9;
            color: #475569;
            padding: 3px 10px;
            border-radius: 16px;
            font-size: 12px;
            font-weight: 600;
        }}
        .table-container {{ overflow-x: auto; }}
        .report-table {{
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
            text-align: left;
        }}
        .report-table th {{
            background: #f8fafc;
            color: #334155;
            font-weight: 600;
            padding: 12px 14px;
            border-bottom: 2px solid var(--border);
            white-space: nowrap;
            text-align: right;
        }}
        .report-table th:first-child {{
            text-align: left;
        }}
        .report-table td {{
            padding: 10px 14px;
            border-bottom: 1px solid var(--border);
            vertical-align: middle;
        }}
        .report-table td.num-cell {{
            text-align: right;
        }}
        .report-table tr:hover {{ background-color: #f8fafc; }}
        .tool-cell {{ font-size: 14px; text-align: left; }}
        .empty-cell {{ color: var(--text-muted); font-style: italic; }}
        .card-footer-note {{
            margin-top: 14px;
            font-size: 13px;
            color: var(--text-muted);
        }}
        .card-footer-note .note-label {{
            font-weight: 600;
            color: #475569;
        }}
        .footer {{
            text-align: center;
            font-size: 12px;
            color: var(--text-muted);
            margin-top: 32px;
            padding-top: 16px;
            border-top: 1px solid var(--border);
        }}
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Non-Empty Data Generation Evaluation</h1>
            <p>Evaluation of query test dataset generation capabilities across benchmark suites &bull; Generated: {now_str}</p>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="label">Benchmarks Evaluated</div>
                <div class="value">{total_benchmarks}</div>
            </div>
            <div class="stat-card">
                <div class="label">Total Benchmark Queries</div>
                <div class="value">{total_queries}</div>
            </div>
            <div class="stat-card">
                <div class="label">Tools Compared</div>
                <div class="value">{total_tools}</div>
            </div>
            <div class="stat-card">
                <div class="label">Top Performing Tool</div>
                <div class="value">{html.escape(best_tool)} ({best_rate:.1f}%)</div>
            </div>
        </div>

        {nav_html}

        <div class="benchmarks-section">
            {''.join(bench_tables_html)}
        </div>

        <div class="footer">
            LASSO Benchmarking Suite &bull; Non-Empty Data Generation Module
        </div>
    </div>
    <script>
        {''.join(chart_scripts)}
    </script>
</body>
</html>
"""

    with open(output_html_path, "w", encoding="utf-8") as f:
        f.write(html_content)


def main():
    parser = argparse.ArgumentParser(description="Analyze non-empty data generation results and produce HTML report")
    parser.add_argument("--html", type=str, default=DEFAULT_HTML_PATH, help="Path for generated HTML report")
    parser.add_argument("--output", type=str, default=DEFAULT_TXT_PATH, help="Path for generated plain-text report")
    parser.add_argument("--benchmark", type=str, default="all", help="Filter analysis to specific benchmark")
    parser.add_argument("--quiet", action="store_true", help="Suppress console printing")
    args = parser.parse_args()

    benchmarks = load_all_benchmarks(BENCHMARKS_DIR)
    results = load_all_results(RESULTS_DIR)

    if not results:
        print(f"No evaluation results found in {RESULTS_DIR}. Run tools first.")
        return

    bench_names, tools, bench_stats = build_analysis_data(benchmarks, results)

    if args.benchmark.lower() != "all":
        selected_bench = args.benchmark.lower()
        if selected_bench not in bench_names:
            print(f"Warning: Benchmark '{selected_bench}' not found in results. Available: {bench_names}")
        else:
            bench_names = [selected_bench]

    title1, headers1, rows1 = format_overview_table(bench_names, tools, bench_stats)
    title2, headers2, rows2 = format_status_breakdown_table(bench_names, tools, bench_stats)

    ascii_table1 = render_ascii_table(title1, headers1, rows1)
    ascii_table2 = render_ascii_table(title2, headers2, rows2)

    all_text_blocks = ["\n".join(ascii_table1), "\n".join(ascii_table2)]
    full_text_report = "\n\n".join(all_text_blocks) + "\n"

    with open(args.output, "w", encoding="utf-8") as f:
        f.write(full_text_report)

    generate_html_report(bench_names, tools, bench_stats, results, args.html)

    if not args.quiet:
        print("\n" + full_text_report)
        print(f"Summary text report written to: {args.output}")
        print(f"Interactive HTML report written to: {args.html}\n")


if __name__ == "__main__":
    main()
