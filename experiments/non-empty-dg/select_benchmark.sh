#!/bin/bash
# Helper script to select benchmarks for non-empty-dg test runners.
# Can be sourced or executed by runner scripts.

# Determine directory safely across sh and bash
if [ -n "$BASH_SOURCE" ]; then
    _SCRIPT_PATH="${BASH_SOURCE[0]}"
else
    _SCRIPT_PATH="$0"
fi
DIR="$( cd "$( dirname "$_SCRIPT_PATH" )" >/dev/null 2>&1 && pwd )"
BENCH_DIR="$DIR/benchmarks"

# 1. Check CLI arguments
cli_benchmark=""
prev=""
for arg in "$@"; do
    if [ "$prev" = "--benchmark" ]; then
        cli_benchmark="$arg"
    fi
    case "$arg" in
        --benchmark=*) cli_benchmark="${arg#*=}" ;;
    esac
    prev="$arg"
done

if [ -n "$cli_benchmark" ]; then
    BENCHMARK="$cli_benchmark"
    export BENCHMARK
    return 0 2>/dev/null || exit 0
fi

# 2. Check if BENCHMARK is already set in environment
if [ -n "$BENCHMARK" ]; then
    return 0 2>/dev/null || exit 0
fi

# 3. Interactive selection
SEL_PYTHON="${PYTHON_EXEC:-$(command -v python3 || command -v python)}"

# Detect python with questionary if available
if ! "$SEL_PYTHON" -c "import questionary" >/dev/null 2>&1; then
    for candidate in "$DIR/../../venv/bin/python" "$DIR/../originals/.lasso_venv/bin/python" "$(command -v python3 2>/dev/null)"; do
        if [ -x "$candidate" ] && "$candidate" -c "import questionary" >/dev/null 2>&1; then
            SEL_PYTHON="$candidate"
            break
        fi
    done
fi

OUT_FILE="$DIR/.cli_selector_output.txt"
rm -f "$OUT_FILE"

if [ -t 0 ]; then
    "$SEL_PYTHON" "$DIR/select_benchmark.py" "$BENCH_DIR"
    exit_code=$?
    if [ $exit_code -ne 0 ]; then
        exit $exit_code
    fi
    if [ -f "$OUT_FILE" ]; then
        BENCHMARK="$(cat "$OUT_FILE" 2>/dev/null)"
        rm -f "$OUT_FILE"
    else
        BENCHMARK="all"
    fi
else
    BENCHMARK="all"
fi

if [ -z "$BENCHMARK" ]; then
    BENCHMARK="all"
fi

export BENCHMARK
