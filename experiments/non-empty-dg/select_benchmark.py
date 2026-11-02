#!/usr/bin/env python3
import os
import sys

try:
    import questionary
    HAS_QUESTIONARY = True
except ImportError:
    HAS_QUESTIONARY = False


def get_available_benchmarks(bench_dir):
    available = []
    if os.path.exists(os.path.join(bench_dir, "sqlite")):
        bench_dir = os.path.join(bench_dir, "sqlite")

    if os.path.exists(bench_dir):
        for item in sorted(os.listdir(bench_dir)):
            if item in ["sqlite", "postgres", "mysql", "stats", "__pycache__"]:
                continue
            p = os.path.join(bench_dir, item)
            q_file = os.path.join(p, "queries.txt")
            if os.path.isdir(p) and os.path.exists(q_file):
                with open(q_file, "r", encoding="utf-8") as f:
                    cnt = sum(
                        1
                        for line in f
                        if line.strip() and not line.strip().startswith("--")
                    )
                available.append((item, cnt))
    return available


def save_result(result_str):
    out_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), ".cli_selector_output.txt")
    with open(out_path, "w", encoding="utf-8") as f:
        f.write(result_str.strip() + "\n")
    print(result_str)


def main():
    bench_dir = sys.argv[1] if len(sys.argv) > 1 else "benchmarks"
    available = get_available_benchmarks(bench_dir)

    if not available:
        save_result("all")
        return

    if HAS_QUESTIONARY and sys.stdin.isatty():
        choices = [
            questionary.Choice("All Benchmarks", value="all")
        ]
        for name, cnt in available:
            choices.append(questionary.Choice(f"{name} ({cnt} queries)", value=name))

        selected = questionary.checkbox(
            "Select benchmark(s) (Space to toggle, Enter to confirm, defaults to 'all'):",
            choices=choices,
        ).ask()

        if selected is None:
            # User aborted (Ctrl+C / Esc)
            sys.exit(1)

        if not selected or "all" in selected:
            save_result("all")
        else:
            save_result(" ".join(selected))
    else:
        # Fallback text mode
        print("\n===========================================")
        print("Benchmark Selection (non-empty data generation)")
        print("===========================================")
        print("  0. All Benchmarks (default)")
        for idx, (name, cnt) in enumerate(available, 1):
            print(f"  {idx}. {name} ({cnt} queries)")
        try:
            b_input = input("\nEnter benchmark number(s) separated by space [0 for all]: ").strip()
        except (EOFError, KeyboardInterrupt):
            sys.exit(1)

        if not b_input or b_input == "0" or b_input.lower() == "all":
            save_result("all")
        else:
            chosen = []
            for token in b_input.split():
                try:
                    num = int(token)
                    if 1 <= num <= len(available):
                        chosen.append(available[num - 1][0])
                except ValueError:
                    chosen.append(token)
            save_result(" ".join(chosen) if chosen else "all")


if __name__ == "__main__":
    main()
