"""
Fast analysis of row counts in LASSO counterexample datasets.
Uses efficient file scanning with parallel processing.

Counterexample datasets: experiments/results/reproducible_cex/lasso_gold/*.sql
Each INSERT INTO statement = one row in the dataset.
"""

import os
import re
import json
import statistics
import subprocess
from collections import defaultdict
from pathlib import Path

RESULTS_DIR = Path(__file__).parent / "results"
CEX_LASSO_GOLD = RESULTS_DIR / "reproducible_cex" / "lasso_gold"

BENCHMARKS = ["bird", "calcite", "cubes", "leetcode", "literature", "tpch", "xdata"]


def fast_count_inserts_shell():
    """
    Use a single shell command to count INSERT lines across all files.
    Output: file:count pairs via grep -c, then parse in Python.
    """
    # Use find + xargs with parallel processing
    cmd = (
        f"find {CEX_LASSO_GOLD} -name '*.sql' -print0 | "
        f"xargs -0 -P 8 grep -ci '^INSERT INTO' 2>/dev/null"
    )
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True, timeout=300)
    
    entries = []
    for line in result.stdout.strip().split('\n'):
        if not line or ':' not in line:
            continue
        # Format: /path/to/file.sql:COUNT
        # Split from the last colon (filenames may contain colons)
        last_colon = line.rfind(':')
        if last_colon == -1:
            continue
        filepath = line[:last_colon]
        try:
            count = int(line[last_colon + 1:])
        except ValueError:
            continue
        entries.append((filepath, count))
    
    return entries


def fast_count_inserts_python():
    """
    Count INSERT lines using Python with minimal overhead.
    Only reads the first few bytes of each line to check for INSERT.
    """
    entries = []
    sql_files = list(CEX_LASSO_GOLD.glob("*.sql"))
    total = len(sql_files)
    
    for i, fpath in enumerate(sql_files):
        if i % 5000 == 0:
            print(f"  Processing {i}/{total}...")
        count = 0
        try:
            with open(fpath, 'rb') as f:  # binary mode for speed
                for line in f:
                    # Check first 12 bytes for INSERT INTO (case insensitive)
                    if line[:12].upper().startswith(b'INSERT INTO'):
                        count += 1
        except Exception:
            continue
        entries.append((str(fpath), count))
    
    return entries


def identify_benchmark(filepath):
    """Identify which benchmark a file belongs to from its filename."""
    fname = os.path.basename(filepath).lower()
    
    # Check for benchmark patterns in filename
    for bm in BENCHMARKS:
        if f"_{bm}_" in fname or fname.startswith(f"{bm}_"):
            return bm
    
    # BIRD files often start with db_id like "california_schools_bird_0"
    if "bird_" in fname:
        return "bird"
    if "cubes_" in fname:
        return "cubes"
    if "leetcode_" in fname or "leet_" in fname:
        return "leetcode"
    if "tpch_" in fname:
        return "tpch"
    if "xdata_" in fname or "xdatabm_" in fname:
        return "xdata"
    if "literature_" in fname or "lit_" in fname:
        return "literature"
    if "calcite_" in fname:
        return "calcite"
    
    return "unknown"


def print_stats(row_counts, label=""):
    """Print detailed statistics."""
    if not row_counts:
        print(f"  No data for {label}")
        return

    sorted_counts = sorted(row_counts)
    n = len(sorted_counts)
    
    print(f"\n  Count:  {n}")
    print(f"  Min:    {min(row_counts)}")
    print(f"  Max:    {max(row_counts)}")
    print(f"  Mean:   {statistics.mean(row_counts):.2f}")
    print(f"  Median: {statistics.median(row_counts):.1f}")
    if n > 1:
        print(f"  Stdev:  {statistics.stdev(row_counts):.2f}")
    
    # Percentiles
    for p in [5, 10, 25, 50, 75, 90, 95, 99]:
        idx = min(int(n * p / 100), n - 1)
        print(f"  P{p:>2}:    {sorted_counts[idx]}")


def print_distribution(row_counts, label=""):
    """Print distribution in buckets."""
    if not row_counts:
        return

    buckets = [
        ("0",     0, 0),
        ("1-2",   1, 2),
        ("3-5",   3, 5),
        ("6-10",  6, 10),
        ("11-15", 11, 15),
        ("16-20", 16, 20),
        ("21-30", 21, 30),
        ("31-50", 31, 50),
        (">50",   51, 999999),
    ]

    total = len(row_counts)
    print(f"\n{'='*60}")
    print(f"Distribution of Rows per Counterexample Dataset {label}")
    print(f"{'='*60}")
    print(f"{'Rows Range':<12} {'Count':>8} {'Percentage':>12}  {'Bar'}")
    print(f"{'-'*50}")

    for bucket_name, lo, hi in buckets:
        count = sum(1 for x in row_counts if lo <= x <= hi)
        pct = (count / total) * 100
        bar = "█" * int(pct / 2)
        print(f"{bucket_name:<12} {count:>8} {pct:>10.1f}%  {bar}")

    print(f"{'-'*50}")
    print(f"{'Total':<12} {total:>8}")
    return buckets


def main():
    print("=" * 70)
    print("LASSO Counterexample Dataset — Row Count Analysis")
    print("=" * 70)
    
    if not CEX_LASSO_GOLD.exists():
        print(f"ERROR: Directory not found: {CEX_LASSO_GOLD}")
        return

    num_files = len(list(CEX_LASSO_GOLD.glob("*.sql")))
    print(f"\nFound {num_files} LASSO counterexample files in lasso_gold/")
    print("Counting INSERT rows per file (this may take a minute)...\n")
    
    # Use Python approach (more reliable across platforms)
    entries = fast_count_inserts_python()
    
    print(f"\nProcessed {len(entries)} files.")
    
    # Classify by benchmark
    per_benchmark = defaultdict(list)
    all_row_counts = []
    
    for filepath, row_count in entries:
        bm = identify_benchmark(filepath)
        per_benchmark[bm].append(row_count)
        all_row_counts.append(row_count)
    
    # Per-benchmark summary table
    print("\n" + "=" * 70)
    print("PER-BENCHMARK STATISTICS")
    print("=" * 70)
    print(f"{'Benchmark':<15} {'Datasets':>10} {'Min':>6} {'Max':>6} {'Mean':>8} {'Median':>8} {'Stdev':>8}")
    print("-" * 65)
    
    for bm in BENCHMARKS + ["unknown"]:
        counts = per_benchmark.get(bm, [])
        if not counts:
            continue
        std = statistics.stdev(counts) if len(counts) > 1 else 0
        print(f"{bm:<15} {len(counts):>10} {min(counts):>6} {max(counts):>6} "
              f"{statistics.mean(counts):>8.1f} {statistics.median(counts):>8.1f} "
              f"{std:>8.1f}")
    
    # Overall
    if all_row_counts:
        std = statistics.stdev(all_row_counts) if len(all_row_counts) > 1 else 0
        print("-" * 65)
        print(f"{'OVERALL':<15} {len(all_row_counts):>10} {min(all_row_counts):>6} {max(all_row_counts):>6} "
              f"{statistics.mean(all_row_counts):>8.1f} {statistics.median(all_row_counts):>8.1f} "
              f"{std:>8.1f}")
        
        # Percentiles
        sorted_counts = sorted(all_row_counts)
        n = len(sorted_counts)
        print(f"\nPercentiles (Overall):")
        for p in [5, 10, 25, 50, 75, 90, 95, 99]:
            idx = min(int(n * p / 100), n - 1)
            print(f"  P{p:>2}: {sorted_counts[idx]} rows")
        
        # Distribution
        print_distribution(all_row_counts, "(All Benchmarks)")
        
        # Per-benchmark distributions
        for bm in BENCHMARKS:
            if bm in per_benchmark and per_benchmark[bm]:
                print_distribution(per_benchmark[bm], f"({bm})")
        
        # LaTeX-ready data
        buckets = [
            ("0", 0, 0),
            ("1--2", 1, 2),
            ("3--5", 3, 5),
            ("6--10", 6, 10),
            ("11--15", 11, 15),
            ("16--20", 16, 20),
            ("21--30", 21, 30),
            ("31--50", 31, 50),
            (">50", 51, 999999),
        ]
        
        total = len(all_row_counts)
        print("\n" + "=" * 70)
        print("LaTeX-READY DATA (tikz histogram)")
        print("=" * 70)
        print("\\addplot[fill=colorLassoCC, draw=black!60] coordinates {")
        for label, lo, hi in buckets:
            count = sum(1 for x in all_row_counts if lo <= x <= hi)
            pct = (count / total) * 100
            print(f"    ({label}, {pct:.2f})")
        print("};")
        
        # Save JSON output
        output_data = {
            "total_datasets": len(all_row_counts),
            "min_rows": min(all_row_counts),
            "max_rows": max(all_row_counts),
            "mean_rows": round(statistics.mean(all_row_counts), 2),
            "median_rows": statistics.median(all_row_counts),
            "std_rows": round(std, 2),
            "per_benchmark": {},
            "distribution": {},
        }
        
        for bm in BENCHMARKS:
            if bm in per_benchmark and per_benchmark[bm]:
                c = per_benchmark[bm]
                output_data["per_benchmark"][bm] = {
                    "count": len(c),
                    "min": min(c),
                    "max": max(c),
                    "mean": round(statistics.mean(c), 2),
                    "median": statistics.median(c),
                }
        
        for label, lo, hi in buckets:
            count = sum(1 for x in all_row_counts if lo <= x <= hi)
            pct = round((count / total) * 100, 2)
            output_data["distribution"][label] = {"count": count, "percentage": pct}
        
        output_path = RESULTS_DIR / "dataset_row_stats.json"
        with open(output_path, "w") as f:
            json.dump(output_data, f, indent=2)
        print(f"\nSaved stats to: {output_path}")
    else:
        print("\nNo counterexample datasets found!")


if __name__ == "__main__":
    main()
