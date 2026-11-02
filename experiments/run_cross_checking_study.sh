#!/bin/bash
set -e

DIR="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

SAMPLE_SIZE="${SAMPLE_SIZE:-100}"
SEED="${SEED:-42}"
STRATEGY="${STRATEGY:-random}"
WORKERS="${WORKERS:-14}"
DIALECT="${DIALECT:-sqlite}"

# Detect Python interpreter
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

if [ -d "$DIR/../.venv" ] && [ -f "$DIR/../.venv/bin/python" ]; then
    PYTHON_EXEC="$DIR/../.venv/bin/python"
elif [ -d "$DIR/../venv" ] && [ -f "$DIR/../venv/bin/python" ]; then
    PYTHON_EXEC="$DIR/../venv/bin/python"
elif [ -d "$DIR/.lasso_venv" ] && [ -f "$DIR/.lasso_venv/bin/python" ]; then
    PYTHON_EXEC="$DIR/.lasso_venv/bin/python"
else
    PYTHON_EXEC="$PYTHON_CMD"
fi

echo "================================================================================"
echo "Starting Cross-Checking Study on BIRD Benchmark"
echo "  Sample Size : $SAMPLE_SIZE"
echo "  Random Seed : $SEED"
echo "  Strategy    : $STRATEGY"
echo "  Workers     : $WORKERS"
echo "  Dialect     : $DIALECT"
echo "  Python      : $PYTHON_EXEC"
echo "================================================================================"

"$PYTHON_EXEC" "$DIR/evaluate_cross_checking.py" \
    --sample-size "$SAMPLE_SIZE" \
    --seed "$SEED" \
    --sample-strategy "$STRATEGY" \
    --num-workers "$WORKERS" \
    --dialect "$DIALECT" \
    "$@"
