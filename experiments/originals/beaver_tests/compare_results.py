#!/usr/bin/env python3
import os
import sys
import csv
csv.field_size_limit(sys.maxsize)

CURR_DIR = os.path.dirname(os.path.abspath(__file__))

TOOLS = [
    ("LASSO", os.path.join(CURR_DIR, "results_lasso", "results.csv")),
    ("ParSEval", os.path.join(CURR_DIR, "results_parseval", "results.csv")),
    ("XData", os.path.join(CURR_DIR, "results_xdata", "results.csv")),
    ("XDataPublic", os.path.join(CURR_DIR, "results_xdatapublic", "results.csv")),
]

def load_tool_results(csv_path):
    if not os.path.exists(csv_path):
        return None
    res = {}
    with open(csv_path, "r", encoding="utf-8") as f:
        reader = csv.DictReader(f)
        for row in reader:
            res[row["query_id"]] = {
                "status": row.get("status", "UNKNOWN"),
                "rows": int(row.get("row_count", 0)),
                "time": float(row.get("elapsed_seconds") or row.get("time_sec") or 0.0),
                "error": row.get("error_msg", "")
            }
    return res

def main():
    loaded = {}
    all_qids = set()
    for tool_name, csv_path in TOOLS:
        data = load_tool_results(csv_path)
        if data is not None:
            loaded[tool_name] = data
            all_qids.update(data.keys())

    if not loaded:
        print("No results found yet. Run the benchmark tools first.")
        return

    qids = sorted(list(all_qids))

    header = f"{'Query ID':<10}"
    for tool_name in loaded:
        header += f" | {tool_name:<20}"
    
    print("\n" + "=" * len(header))
    print("BEAVER BENCHMARK (dw schema) - TOOL COMPARISON")
    print("=" * len(header))
    print(header)
    print("-" * len(header))

    totals = {tool: {"ok": 0, "empty": 0, "error": 0, "time": 0.0} for tool in loaded}

    for qid in qids:
        row = f"{qid:<10}"
        for tool_name, data in loaded.items():
            if qid in data:
                info = data[qid]
                st = info["status"]
                rows = info["rows"]
                tm = info["time"]
                totals[tool_name]["time"] += tm
                if st == "OK":
                    totals[tool_name]["ok"] += 1
                    cell = f"OK ({rows} rows, {tm:.2f}s)"
                elif st == "EMPTY":
                    totals[tool_name]["empty"] += 1
                    cell = f"EMPTY ({tm:.2f}s)"
                else:
                    totals[tool_name]["error"] += 1
                    cell = f"ERROR ({tm:.2f}s)"
            else:
                cell = "N/A"
            row += f" | {cell:<20}"
        print(row)

    print("-" * len(header))
    summary_row = f"{'NON-EMPTY':<10}"
    for tool_name in loaded:
        ok_cnt = totals[tool_name]["ok"]
        tot = len(qids)
        pct = (ok_cnt / tot * 100.0) if tot > 0 else 0.0
        summary_row += f" | {f'{ok_cnt}/{tot} ({pct:.1f}%)':<20}"
    print(summary_row)

    time_row = f"{'TOTAL TIME':<10}"
    for tool_name in loaded:
        tot_tm = totals[tool_name]["time"]
        time_row += f" | {f'{tot_tm:.2f}s':<20}"
    print(time_row)
    print("=" * len(header) + "\n")

if __name__ == "__main__":
    main()
