#!/bin/bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
EXPERIMENTS_DIR="$( cd "$DIR/.." >/dev/null 2>&1 && pwd )"
REPO_ROOT="$( cd "$EXPERIMENTS_DIR/.." >/dev/null 2>&1 && pwd )"

# Ensure databases are up and healthy if needed
if [ -f "$EXPERIMENTS_DIR/start_databases.sh" ]; then
    . "$EXPERIMENTS_DIR/start_databases.sh"
fi

# Select Python environment for LASSO
PYTHON_EXEC=""
if [ -d "$REPO_ROOT/venv" ] && [ -f "$REPO_ROOT/venv/bin/python" ]; then
    PYTHON_EXEC="$REPO_ROOT/venv/bin/python"
elif [ -d "$REPO_ROOT/.venv" ] && [ -f "$REPO_ROOT/.venv/bin/python" ]; then
    PYTHON_EXEC="$REPO_ROOT/.venv/bin/python"
elif [ -d "$EXPERIMENTS_DIR/.lasso_venv" ] && [ -f "$EXPERIMENTS_DIR/.lasso_venv/bin/python" ]; then
    PYTHON_EXEC="$EXPERIMENTS_DIR/.lasso_venv/bin/python"
else
    PYTHON_EXEC="$(command -v python3 || command -v python)"
fi

echo "=================================================================="
echo "Running LASSO Benchmark for Beaver (dw schema)"
echo "Python interpreter: $PYTHON_EXEC"
echo "=================================================================="

"$PYTHON_EXEC" "$DIR/test_beaver_lasso.py" "$@"
