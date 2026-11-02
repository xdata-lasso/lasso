import os
import glob
import csv
from collections import Counter

results_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'results')
csv_files = glob.glob(os.path.join(results_dir, 'lasso_strategy_kills_*.csv'))

total_counter = Counter()
benchmark_counters = {}
benchmark_unique_pairs = {}
all_unique_pairs = set()

for fpath in sorted(csv_files):
    bench = os.path.basename(fpath).replace('lasso_strategy_kills_', '').replace('.csv', '')
    b_counter = Counter()
    b_pairs = set()
    with open(fpath, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        for row in reader:
            strat = row.get('attack_strategy', '').strip()
            iid = row.get('instance_id', '').strip()
            pid = row.get('prediction_id', '').strip()
            if strat and iid and pid:
                b_counter[strat] += 1
                total_counter[strat] += 1
                b_pairs.add((iid, pid))
                all_unique_pairs.add((bench, iid, pid))
    benchmark_counters[bench] = b_counter
    benchmark_unique_pairs[bench] = b_pairs

out_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'strategy_summary.txt')
with open(out_path, 'w', encoding='utf-8') as out:
    out.write(f"Total Unique Pairs Refuted Across All Benchmarks: {len(all_unique_pairs):,}\n")
    out.write(f"Total Strategy Kill Records: {sum(total_counter.values()):,}\n\n")

    out.write("Per-Benchmark Breakdown:\n")
    out.write(f"{'Benchmark':<15} | {'Unique Pairs Refuted':<22} | {'Total Strategy Kills':<22}\n")
    out.write("-" * 65 + "\n")
    for bench in sorted(benchmark_counters.keys()):
        out.write(f"{bench:<15} | {len(benchmark_unique_pairs[bench]):<22} | {sum(benchmark_counters[bench].values()):<22}\n")

    out.write("\n\nAll Strategies Kill Counts:\n")
    out.write(f"{'Rank':<5} | {'Attack Strategy':<45} | {'Kills':<10} | {'% of Pairs':<12}\n")
    out.write("-" * 80 + "\n")
    rank = 1
    for strat, count in total_counter.most_common():
        pct = (count / len(all_unique_pairs) * 100) if all_unique_pairs else 0
        out.write(f"{rank:<5} | {strat:<45} | {count:<10} | {pct:>6.2f}%\n")
        rank += 1

    out.write("\n\nPer-Benchmark Strategy Breakdown Table:\n")
    benchmarks = sorted(benchmark_counters.keys())
    header = f"{'Attack Strategy':<40} | " + " | ".join(f"{b:>8}" for b in benchmarks) + f" | {'Total':>8}\n"
    out.write(header)
    out.write("-" * len(header) + "\n")
    for strat, count in total_counter.most_common():
        row_str = f"{strat:<40} | "
        for b in benchmarks:
            row_str += f"{benchmark_counters[b].get(strat, 0):>8} | "
        row_str += f"{count:>8}\n"
        out.write(row_str)

print("Summary generated successfully.")
