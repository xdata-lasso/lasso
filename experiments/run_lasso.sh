#!/bin/bash
set -e

DIR="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

# Ensure databases are up and healthy
. "$DIR/start_databases.sh"

# Detect Python 3.8+ interpreter
PYTHON_CMD=""
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

# Check if venv exists, create if not
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
    echo "Creating Lasso virtual environment..."
    "$PYTHON_CMD" -m venv "$DIR/.lasso_venv" 2>/dev/null || "$PYTHON_CMD" -m virtualenv "$DIR/.lasso_venv" 2>/dev/null || true
    if [ -f "$DIR/.lasso_venv/bin/python" ]; then
        PYTHON_EXEC="$DIR/.lasso_venv/bin/python"
        PIP_EXEC="$DIR/.lasso_venv/bin/pip"
        export PATH="$DIR/.lasso_venv/bin:$PATH"
    else
        PYTHON_EXEC="$PYTHON_CMD"
        PIP_EXEC="pip3"
    fi
fi

"$PIP_EXEC" install -q --upgrade pip 2>/dev/null || true
"$PIP_EXEC" install -q -r "$DIR/../requirements.txt" 2>/dev/null || \
"$PYTHON_EXEC" -m pip install -q -r "$DIR/../requirements.txt" 2>/dev/null || true
export PYTHON_EXEC

# Run lasso evaluation
. "$DIR/select_benchmark.sh"

INPUT_OPT=""
if [ ! -z "$INPUT_FILE" ]; then
    INPUT_OPT="--input-file $INPUT_FILE"
fi

for bm in $BENCHMARK; do
    echo "==========================================="
    echo "Running Lasso benchmark: $bm"
    echo "==========================================="
    EXEC_RESUME_OPT="$RESUME_OPT"
    case " $* " in
        *" --retry "*|*" --resume "*) EXEC_RESUME_OPT="" ;;
    esac
    EXEC_BENCH_OPT=""
    if [ -n "$bm" ]; then
        case " $* " in
            *" --benchmark "*) ;;
            *) EXEC_BENCH_OPT="--benchmark $bm" ;;
        esac
    fi
    "$PYTHON_EXEC" "$DIR/evaluate_lasso.py" $EXEC_BENCH_OPT $INPUT_OPT $EXEC_RESUME_OPT $DIALECT_OPT "$@"
done
