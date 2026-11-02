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

# Benchmark selection prompt
if [ -n "$ALLOWED_BENCHMARKS" ]; then
    export ALLOWED_BENCHMARKS
fi
. "$DIR/select_benchmark.sh" "$@"

INPUT_OPT=""
if [ ! -z "$INPUT_FILE" ]; then
    INPUT_OPT="--input-file $INPUT_FILE"
fi

for bm in $BENCHMARK; do
    echo "==========================================="
    echo "Running LLM-ER benchmark: $bm"
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
    "$PYTHON_EXEC" "$DIR/evaluate_llm_er.py" $EXEC_BENCH_OPT $INPUT_OPT $EXEC_RESUME_OPT $DIALECT_OPT "$@"
done
