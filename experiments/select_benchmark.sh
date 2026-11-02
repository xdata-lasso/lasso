# Parse CLI arguments if provided directly to the caller
cli_benchmark=""
cli_resume=""
cli_dialect=""
cli_input_file=""

prev=""
for arg in "$@"; do
    if [ "$prev" = "--benchmark" ]; then
        cli_benchmark="$arg"
    elif [ "$prev" = "--target-dialect" ]; then
        cli_dialect="--target-dialect $arg"
    elif [ "$prev" = "--input-file" ]; then
        cli_input_file="$arg"
    fi
    case "$arg" in
        --benchmark=*) cli_benchmark="${arg#*=}" ;;
        --target-dialect=*) cli_dialect="--target-dialect ${arg#*=}" ;;
        --input-file=*) cli_input_file="${arg#*=}" ;;
        --retry) cli_resume="--retry" ;;
        --resume) cli_resume="--resume" ;;
        --full|--rerun) cli_resume="" ;;
    esac
    prev="$arg"
done

if [ -n "$cli_benchmark" ]; then
    BENCHMARK="$cli_benchmark"
fi
if [ -n "$cli_resume" ] || case " $* " in *" --full "*|*" --rerun "*) true ;; *) false ;; esac; then
    RESUME_OPT="$cli_resume"
fi
if [ -n "$cli_dialect" ]; then
    DIALECT_OPT="$cli_dialect"
fi
if [ -n "$cli_input_file" ]; then
    INPUT_FILE="$cli_input_file"
fi

if [ -n "$BENCHMARK" ]; then
    RESUME_OPT="${RESUME_OPT:---retry}"
    DIALECT_OPT="${DIALECT_OPT:-}"
    export BENCHMARK RESUME_OPT DIALECT_OPT
    if [ -n "$INPUT_FILE" ]; then export INPUT_FILE; fi
    EXTRA_ARGS="--benchmark $BENCHMARK $RESUME_OPT $DIALECT_OPT"
    return 0 2>/dev/null || true
fi

if [ -z "$BENCHMARK" ] || [ -z "${RESUME_OPT+x}" ]; then
    echo "==========================================="
    echo "Benchmark Selection"
    echo "==========================================="
    
    if ! [ -t 0 ]; then
        has_retry=0
        has_full=0
        case " $* " in
            *" --retry "*) has_retry=1 ;;
            *" --full "*|*" --rerun "*) has_full=1 ;;
        esac
        if [ "$has_retry" -eq 1 ]; then
            default_resume="--retry"
        elif [ "$has_full" -eq 1 ]; then
            default_resume=""
        else
            default_resume="--retry"
        fi
        if [ -n "$ALLOWED_BENCHMARKS" ]; then
            BENCHMARK="${BENCHMARK:-$ALLOWED_BENCHMARKS}"
        else
            BENCHMARK="${BENCHMARK:-all}"
        fi
        RESUME_OPT="${RESUME_OPT:-$default_resume}"
        DIALECT_OPT="${DIALECT_OPT:-}"
        INPUT_FILE_OPT="${INPUT_FILE:-}"
        export BENCHMARK RESUME_OPT DIALECT_OPT
        if [ -n "$INPUT_FILE_OPT" ]; then export INPUT_FILE="$INPUT_FILE_OPT"; fi
        EXTRA_ARGS="--benchmark $BENCHMARK $RESUME_OPT $DIALECT_OPT"
        echo "Non-interactive shell detected (no TTY). Defaulting to: BENCHMARK=$BENCHMARK, RESUME_OPT=${RESUME_OPT:-[none]}"
        return 0 2>/dev/null || true
    fi
    
    # Detect Python interpreter with questionary, or fallback
    PYTHON_CMD="${PYTHON_EXEC:-python3}"
    if ! "$PYTHON_CMD" -c "import questionary" >/dev/null 2>&1; then
        for candidate in "$DIR"/.*/bin/python "$DIR"/../venv/bin/python "$(command -v python3 2>/dev/null)" "$(command -v python 2>/dev/null)"; do
            if [ -x "$candidate" ] && "$candidate" -c "import questionary" >/dev/null 2>&1; then
                PYTHON_CMD="$candidate"
                break
            fi
        done
    fi
    
    cat << 'EOF' > .cli_selector.py
import json
import sys
import os

try:
    import questionary
    HAS_QUESTIONARY = True
except ImportError:
    HAS_QUESTIONARY = False

def get_benchmark_counts():
    counts = {}
    bench_dir = 'benchmarks'
    if os.path.exists(bench_dir) and os.path.isdir(bench_dir):
        for entry in os.listdir(bench_dir):
            p = os.path.join(bench_dir, entry)
            if os.path.isdir(p) and not entry.startswith('.') and not os.path.islink(p):
                q_file = os.path.join(p, 'queries.json')
                if os.path.exists(q_file):
                    try:
                        with open(q_file, 'r', encoding='utf-8') as f:
                            q_data = json.load(f)
                        counts[entry] = sum(len(it.get('predictions', [])) for it in q_data)
                    except Exception:
                        pass
    return sorted(counts.items())

def text_fallback():
    bench_list = get_benchmark_counts()

    import os
    allowed_raw = os.environ.get('ALLOWED_BENCHMARKS')
    if allowed_raw:
        allowed_set = set(allowed_raw.split())
        bench_list = [b for b in bench_list if b[0] in allowed_set]

    print("\n--- Benchmark Selection ---")
    print("  1. Full Experiment (default)")
    print("  2. Random Mini Sample (100 queries)")
    try:
        exp_choice = input("Select experiment type [1]: ").strip()
    except (EOFError, KeyboardInterrupt):
        with open(".cli_selector_output.txt", "w") as f:
            f.write("all,--retry,,\n")
        sys.exit(0)
    
    input_file_opt = ""
    if exp_choice == "2":
        benchmarks_str = "all"
        import random, time
        default_seed = str(int(time.time()))
        try:
            seed_str = input(f"Enter random seed [{default_seed}]: ").strip()
        except (EOFError, KeyboardInterrupt):
            sys.exit(1)
        seed = int(seed_str) if seed_str else int(default_seed)
        random.seed(seed)
        
        by_source = {}
        for item in data:
            src = item.get('source', 'unknown')
            if not item.get('predictions'):
                continue
            by_source.setdefault(src, []).append(item)
            
        target_per_source = 100 // max(1, len(by_source))
        sampled_items = []
        for src, items in by_source.items():
            sampled_items.extend(random.sample(items, min(len(items), target_per_source)))
        while len(sampled_items) < 100:
            remaining = [it for src, items in by_source.items() for it in items if it not in sampled_items]
            if not remaining:
                break
            sampled_items.append(random.choice(remaining))
            
        final_sample = []
        for item in sampled_items:
            item_copy = item.copy()
            item_copy['predictions'] = [random.choice(item['predictions'])]
            final_sample.append(item_copy)
            
        input_file_opt = f"queries_mini_{seed}.json"
        with open(input_file_opt, 'w') as f:
            json.dump(final_sample, f, indent=2)
    else:
        print("\n--- Available Benchmarks ---")
        print("  0. all (default)")
        for idx, (src, c) in enumerate(bench_list, 1):
            print(f"  {idx}. {src} ({c} pairs)")
        try:
            b_input = input("Enter benchmark numbers separated by space [0 for all]: ").strip()
        except (EOFError, KeyboardInterrupt):
            sys.exit(1)
        if not b_input or b_input == "0":
            benchmarks_str = " ".join([b[0] for b in bench_list]) if allowed_raw else "all"
        else:
            selected = []
            for token in b_input.split():
                try:
                    num = int(token)
                    if 1 <= num <= len(bench_list):
                        selected.append(bench_list[num - 1][0])
                except ValueError:
                    selected.append(token)
            benchmarks_str = " ".join(selected) if selected else (" ".join([b[0] for b in bench_list]) if allowed_raw else "all")

    print("\n--- Target Dialect ---")
    print("  1. sqlite (default)")
    print("  2. native")
    print("  3. mysql")
    print("  4. postgresql")
    d_map = {"1": "sqlite", "2": "native", "3": "mysql", "4": "postgresql"}
    try:
        d_choice = input("Select target dialect [1]: ").strip()
    except (EOFError, KeyboardInterrupt):
        sys.exit(1)
    dialect_action = d_map.get(d_choice, "sqlite")

    print("\n--- Execution Mode ---")
    print("  1. Full (default)")
    print("  2. Resume")
    print("  3. Retry")
    try:
        r_choice = input("Select execution mode [1]: ").strip()
    except (EOFError, KeyboardInterrupt):
        sys.exit(1)
    if r_choice in ("2", "resume", "Resume"):
        resume_opt = "--resume"
    elif r_choice in ("3", "retry", "Retry"):
        resume_opt = "--retry"
    else:
        resume_opt = ""
    dialect_opt = f"--target-dialect {dialect_action}" if dialect_action != "native" else ""

    with open(".cli_selector_output.txt", "w") as f:
        f.write(f"{benchmarks_str},{resume_opt},{dialect_opt},{input_file_opt}\n")

def questionary_menu():
    experiment_type = questionary.select(
        "Select experiment type:",
        choices=["Full Experiment", "Random Mini Sample (100 queries)"],
        default="Full Experiment"
    ).ask()

    if experiment_type is None:
        sys.exit(1)

    input_file_opt = ""
    if experiment_type == "Random Mini Sample (100 queries)":
        benchmarks_str = "all"
        import random, time
        default_seed = str(int(time.time()))
        seed_str = questionary.text(
            "Enter random seed (or press Enter for a random seed):",
            default=default_seed
        ).ask()
        
        if seed_str is None:
            sys.exit(1)
            
        seed = int(seed_str)
        random.seed(seed)
        
        with open('queries.json') as f:
            data = json.load(f)
            
        by_source = {}
        for item in data:
            src = item.get('source', 'unknown')
            if not item.get('predictions'):
                continue
            if src not in by_source:
                by_source[src] = []
            by_source[src].append(item)
                
        num_sources = len(by_source)
        if num_sources > 0:
            target_per_source = 100 // num_sources
            sampled_items = []
            for src, items in by_source.items():
                if len(items) > target_per_source:
                    sampled_items.extend(random.sample(items, target_per_source))
                else:
                    sampled_items.extend(items)
            
            while len(sampled_items) < 100:
                remaining = [it for src, items in by_source.items() for it in items if it not in sampled_items]
                if not remaining:
                    break
                sampled_items.append(random.choice(remaining))
                
            final_sample = []
            for item in sampled_items:
                item_copy = item.copy()
                item_copy['predictions'] = [random.choice(item['predictions'])]
                final_sample.append(item_copy)
                
            input_file_opt = f"queries_mini_{seed}.json"
            with open(input_file_opt, 'w') as f:
                json.dump(final_sample, f, indent=2)
                
    else:
        counts = dict(get_benchmark_counts())
        choices = []
        allowed_raw = os.environ.get('ALLOWED_BENCHMARKS')
        allowed_set = set(allowed_raw.split()) if allowed_raw else None
        for src, c in sorted(counts.items()):
            if allowed_set is None or src in allowed_set:
                choices.append(f"{src} ({c} pairs)")
        if not choices:
            choices = ["bird", "lasso-bm"]
    
        benchmarks_selected = questionary.checkbox(
            "Select benchmark(s) (Space to toggle, Enter to confirm, defaults to 'all'):",
            choices=choices,
        ).ask()
    
        if benchmarks_selected is None:
            sys.exit(1)
    
        if not benchmarks_selected:
            benchmarks_str = " ".join([b.split(" ")[0] for b in choices]) if allowed_raw else "all"
        else:
            benchmarks_str = " ".join([b.split(" ")[0] for b in benchmarks_selected])
        
    dialect_action = questionary.select(
        "Choose target dialect for evaluation:",
        choices=["native", "sqlite", "mysql", "postgresql"],
        default="sqlite"
    ).ask()
    
    if dialect_action is None:
        sys.exit(1)
        
    resume_action = questionary.select(
        "Select execution mode:",
        choices=["Full", "Resume", "Retry"],
        default="Full"
    ).ask()
    
    if resume_action is None:
        sys.exit(1)
        
    if resume_action == "Retry" or (resume_action and "retry" in resume_action.lower()):
        resume_opt = "--retry"
    elif resume_action == "Resume" or (resume_action and "resume" in resume_action.lower()):
        resume_opt = "--resume"
    else:
        resume_opt = ""
    dialect_opt = f"--target-dialect {dialect_action}" if dialect_action != "native" else ""
    
    with open(".cli_selector_output.txt", "w") as f:
        f.write(f"{benchmarks_str},{resume_opt},{dialect_opt},{input_file_opt}\n")

def main():
    if HAS_QUESTIONARY:
        try:
            questionary_menu()
            return
        except Exception:
            pass
    text_fallback()

if __name__ == "__main__":
    main()
EOF

    "$PYTHON_CMD" .cli_selector.py
    if [ $? -ne 0 ]; then
        echo "Aborted."
        exit 1
    fi

    OLD_IFS="$IFS"
    IFS=',' read -r BENCHMARK RESUME_OPT DIALECT_OPT INPUT_FILE_OPT < .cli_selector_output.txt
    IFS="$OLD_IFS"
    rm -f .cli_selector.py .cli_selector_output.txt
    
    if [ -z "$BENCHMARK" ]; then
        BENCHMARK="all"
    fi
    
    export BENCHMARK
    export RESUME_OPT
    export DIALECT_OPT
    
    if [ ! -z "$INPUT_FILE_OPT" ]; then
        export INPUT_FILE="$INPUT_FILE_OPT"
    fi
    echo "==========================================="
    echo "To run this experiment again without prompts, use the following command:"
    
    cmd_str="BENCHMARK=\"$BENCHMARK\" RESUME_OPT=\"$RESUME_OPT\""
    if [ ! -z "$DIALECT_OPT" ]; then cmd_str="$cmd_str DIALECT_OPT=\"$DIALECT_OPT\""; fi
    if [ ! -z "$INPUT_FILE_OPT" ]; then cmd_str="$cmd_str INPUT_FILE=\"$INPUT_FILE_OPT\""; fi
    if [ ! -z "$MODE" ]; then cmd_str="MODE=\"$MODE\" $cmd_str"; fi
    if [ ! -z "$MAX_DATASETS" ]; then cmd_str="MAX_DATASETS=\"$MAX_DATASETS\" $cmd_str"; fi
    
    script_name=$(basename "$0")
    if [ "$script_name" = "select_benchmark.sh" ] && [ -n "${BASH_SOURCE[0]:-}" ]; then
        parent_script="${BASH_SOURCE[${#BASH_SOURCE[@]}-1]}"
        script_name=$(basename "$parent_script")
    fi
    echo "$cmd_str sh $script_name"
    echo "==========================================="
fi

EXTRA_ARGS="--benchmark $BENCHMARK"
if [ ! -z "$RESUME_OPT" ]; then
    EXTRA_ARGS="$EXTRA_ARGS $RESUME_OPT"
fi
if [ ! -z "$DIALECT_OPT" ]; then
    EXTRA_ARGS="$EXTRA_ARGS $DIALECT_OPT"
fi
