#!/bin/bash
set -e

DIR="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

# Detect Python interpreter (prefer existing venvs if available)
PYTHON_CMD=""
if [ -d "$DIR/../.venv" ] && [ -f "$DIR/../.venv/bin/python" ]; then
    PYTHON_EXEC="$DIR/../.venv/bin/python"
    PIP_EXEC="$DIR/../.venv/bin/pip"
    export PATH="$DIR/../.venv/bin:$PATH"
elif [ -d "$DIR/../venv" ] && [ -f "$DIR/../venv/bin/python" ]; then
    PYTHON_EXEC="$DIR/../venv/bin/python"
    PIP_EXEC="$DIR/../venv/bin/pip"
    export PATH="$DIR/../venv/bin:$PATH"
elif [ -d "$DIR/.lasso_venv" ] && [ -f "$DIR/.lasso_venv/bin/python" ]; then
    PYTHON_EXEC="$DIR/.lasso_venv/bin/python"
    PIP_EXEC="$DIR/.lasso_venv/bin/pip"
    export PATH="$DIR/.lasso_venv/bin:$PATH"
else
    for cmd in python3 python3.12 python3.11 python3.10 python; do
        if command -v "$cmd" >/dev/null 2>&1 && "$cmd" -c "import sys; sys.exit(0 if sys.version_info >= (3,8) else 1)" >/dev/null 2>&1; then
            PYTHON_CMD="$cmd"
            break
        fi
    done
    if [ -z "$PYTHON_CMD" ]; then
        echo "Error: Python 3.8 or higher is required but not found."
        exit 1
    fi
    PYTHON_EXEC="$PYTHON_CMD"
    PIP_EXEC="pip3"
fi

export PYTHON_EXEC

# Parse mode and max-datasets from CLI arguments if present
cli_mode=""
cli_max_datasets=""
prev=""
for arg in "$@"; do
    if [ "$prev" = "--mode" ]; then
        cli_mode="$arg"
    elif [ "$prev" = "--max-datasets" ]; then
        cli_max_datasets="$arg"
    fi
    case "$arg" in
        --mode=*) cli_mode="${arg#*=}" ;;
        --max-datasets=*) cli_max_datasets="${arg#*=}" ;;
    esac
    prev="$arg"
done

MODE="${cli_mode:-${MODE:-}}"
MAX_DATASETS="${cli_max_datasets:-${MAX_DATASETS:-}}"

if [ -z "$MODE" ] || { [ "$MODE" = "bounded" ] && [ -z "$MAX_DATASETS" ]; }; then
    if [ -t 0 ]; then
        echo "==========================================="
        echo "LLM-TDG: Mode Selection"
        echo "==========================================="
        trap 'rm -f .tdg_mode_selector.py .tdg_mode_output.txt 2>/dev/null' INT TERM EXIT
        cat << 'EOF' > .tdg_mode_selector.py
import os
import sys

try:
    import questionary
    HAS_QUESTIONARY = True
except ImportError:
    HAS_QUESTIONARY = False

def questionary_menu(initial_mode):
    mode = initial_mode
    max_datasets = ""
    if not mode:
        choice = questionary.select(
            "Select Test Data Generation Mode:",
            choices=[
                "1. Unrestricted (LLM generates as many datasets as needed)",
                "2. Bounded (Limit the maximum number of datasets generated)"
            ],
            default="1. Unrestricted (LLM generates as many datasets as needed)"
        ).ask()
        if choice is None:
            sys.exit(1)
        if "2." in choice or "bounded" in choice.lower():
            mode = "bounded"
        else:
            mode = "unrestricted"

    if mode == "bounded":
        ans = questionary.text(
            "Enter maximum number of datasets (e.g. 1, 3, 5, 10) [default: 5]:",
            validate=lambda text: True if not text.strip() or (text.strip().isdigit() and int(text.strip()) > 0) else "Please enter a positive integer"
        ).ask()
        if ans is None:
            sys.exit(1)
        max_datasets = ans.strip() if ans.strip() else "5"

    return mode, max_datasets

def text_fallback(initial_mode):
    mode = initial_mode
    max_datasets = ""
    if not mode:
        print("\n--- Test Data Generation Mode ---")
        print("  1. Unrestricted (LLM generates as many datasets as needed) (default)")
        print("  2. Bounded (Limit the maximum number of datasets generated)")
        try:
            choice = input("Select mode [1]: ").strip()
        except (EOFError, KeyboardInterrupt):
            sys.exit(1)
        if choice in ("2", "bounded", "Bounded"):
            mode = "bounded"
        else:
            mode = "unrestricted"

    if mode == "bounded":
        try:
            ans = input("Enter maximum number of datasets [5]: ").strip()
        except (EOFError, KeyboardInterrupt):
            sys.exit(1)
        max_datasets = ans.strip() if (ans.strip() and ans.strip().isdigit() and int(ans.strip()) > 0) else "5"

    return mode, max_datasets

def main():
    initial_mode = os.environ.get("INITIAL_MODE", "").strip().lower()
    initial_max = os.environ.get("INITIAL_MAX_DATASETS", "").strip()

    if initial_mode in ("unrestricted", "bounded") and (initial_mode != "bounded" or initial_max):
        mode = initial_mode
        max_datasets = initial_max
    else:
        if HAS_QUESTIONARY:
            try:
                mode, max_datasets = questionary_menu(initial_mode)
            except Exception:
                mode, max_datasets = text_fallback(initial_mode)
        else:
            mode, max_datasets = text_fallback(initial_mode)

    with open(".tdg_mode_output.txt", "w", encoding="utf-8") as f:
        f.write(f"{mode},{max_datasets}\n")

if __name__ == "__main__":
    main()
EOF

        INITIAL_MODE="$MODE" INITIAL_MAX_DATASETS="$MAX_DATASETS" "$PYTHON_EXEC" .tdg_mode_selector.py
        status=$?
        if [ $status -ne 0 ]; then
            echo "Aborted."
            rm -f .tdg_mode_selector.py .tdg_mode_output.txt
            exit 1
        fi

        if [ -f .tdg_mode_output.txt ]; then
            OLD_IFS="$IFS"
            IFS=',' read -r sel_mode sel_max < .tdg_mode_output.txt
            IFS="$OLD_IFS"
            MODE="${sel_mode:-unrestricted}"
            MAX_DATASETS="${sel_max:-}"
            rm -f .tdg_mode_selector.py .tdg_mode_output.txt
        fi
        trap - INT TERM EXIT
    else
        MODE="${MODE:-unrestricted}"
        if [ "$MODE" = "bounded" ] && [ -z "$MAX_DATASETS" ]; then
            MAX_DATASETS="5"
        fi
    fi
fi

export MODE
export MAX_DATASETS

# Benchmark selection prompt
if [ -n "$ALLOWED_BENCHMARKS" ]; then
    export ALLOWED_BENCHMARKS
fi
. "$DIR/select_benchmark.sh" "$@"

INPUT_OPT=""
if [ ! -z "$INPUT_FILE" ]; then
    INPUT_OPT="--input-file $INPUT_FILE"
fi

EXEC_MODE_OPT=""
case " $* " in
    *" --mode "*|*" --mode="*) ;;
    *) EXEC_MODE_OPT="--mode $MODE" ;;
esac

EXEC_MAX_DATASETS_OPT=""
if [ "$MODE" = "bounded" ] && [ -n "$MAX_DATASETS" ]; then
    case " $* " in
        *" --max-datasets "*|*" --max-datasets="*) ;;
        *) EXEC_MAX_DATASETS_OPT="--max-datasets $MAX_DATASETS" ;;
    esac
fi

for bm in $BENCHMARK; do
    echo "==========================================="
    echo "Running LLM-TDG benchmark: $bm (Mode: $MODE${MAX_DATASETS:+, Bound: $MAX_DATASETS})"
    echo "==========================================="
    EXEC_RESUME_OPT="$RESUME_OPT"
    case " $* " in
        *" --retry "*|*" --resume "*) EXEC_RESUME_OPT="" ;;
    esac
    EXEC_BENCH_OPT=""
    if [ -n "$bm" ]; then
        case " $* " in
            *" --benchmark "*|*" --benchmark="*) ;;
            *) EXEC_BENCH_OPT="--benchmark $bm" ;;
        esac
    fi
    "$PYTHON_EXEC" "$DIR/evaluate_llm_tdg.py" $EXEC_BENCH_OPT $INPUT_OPT $EXEC_RESUME_OPT $DIALECT_OPT $EXEC_MODE_OPT $EXEC_MAX_DATASETS_OPT "$@"
done
