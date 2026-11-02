#!/bin/bash
set -e

# Re-exec with bash if invoked via sh
if [ -z "$BASH_VERSION" ]; then
    exec bash "$0" "$@"
fi

DIR="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"
EXPERIMENTS_DIR="$( cd "$DIR/.." >/dev/null 2>&1 && pwd )"
REPO_ROOT="$( cd "$EXPERIMENTS_DIR/.." >/dev/null 2>&1 && pwd )"

# Start databases if needed
if [ -f "$EXPERIMENTS_DIR/start_databases.sh" ]; then
    . "$EXPERIMENTS_DIR/start_databases.sh"
fi

# Detect Python interpreter
PYTHON_EXEC=""
if [ -d "$REPO_ROOT/.venv" ] && [ -f "$REPO_ROOT/.venv/bin/python" ]; then
    PYTHON_EXEC="$REPO_ROOT/.venv/bin/python"
elif [ -d "$REPO_ROOT/venv" ] && [ -f "$REPO_ROOT/venv/bin/python" ]; then
    PYTHON_EXEC="$REPO_ROOT/venv/bin/python"
elif [ -d "$EXPERIMENTS_DIR/originals/.lasso_venv" ] && [ -f "$EXPERIMENTS_DIR/originals/.lasso_venv/bin/python" ]; then
    PYTHON_EXEC="$EXPERIMENTS_DIR/originals/.lasso_venv/bin/python"
else
    PYTHON_EXEC="$(command -v python3 || command -v python)"
fi

# Auto-build benchmarks if directory is empty or missing
if [ ! -d "$DIR/benchmarks" ] || [ -z "$(ls -A "$DIR/benchmarks" 2>/dev/null)" ]; then
    echo "Benchmark directory empty. Building benchmarks..."
    "$PYTHON_EXEC" "$DIR/build_benchmarks.py"
fi

# Benchmark selection
. "$DIR/select_benchmark.sh"

echo "=================================================================="
echo "Running LASSO Non-Empty Data Generation"
echo "Target benchmark(s): $BENCHMARK"
echo "Python interpreter: $PYTHON_EXEC"
echo "=================================================================="

"$PYTHON_EXEC" "$DIR/evaluate_lasso.py" --benchmark "$BENCHMARK" "$@"
