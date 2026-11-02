#!/bin/bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
EXPERIMENTS_DIR="$( cd "$DIR/.." >/dev/null 2>&1 && pwd )"
REPO_ROOT="$( cd "$EXPERIMENTS_DIR/.." >/dev/null 2>&1 && pwd )"

# Ensure databases are up and healthy if needed
if [ -f "$EXPERIMENTS_DIR/start_databases.sh" ]; then
    . "$EXPERIMENTS_DIR/start_databases.sh"
fi

# Detect Python interpreter
PYTHON_CMD=""
for cmd in python3 python3.12 python3.11 python3.10 python; do
    if command -v "$cmd" >/dev/null 2>&1 && "$cmd" -c "import sys; sys.exit(0 if sys.version_info >= (3,8) else 1)" >/dev/null 2>&1; then
        PYTHON_CMD="$cmd"
        break
    fi
done

# Ensure ParSEval virtual environment
if [ ! -d "$EXPERIMENTS_DIR/.parseval_venv" ]; then
    echo "Creating ParSEval virtual environment at $EXPERIMENTS_DIR/.parseval_venv..."
    "$PYTHON_CMD" -m venv "$EXPERIMENTS_DIR/.parseval_venv" 2>/dev/null || true
fi

if [ -f "$EXPERIMENTS_DIR/.parseval_venv/bin/python" ]; then
    PYTHON_EXEC="$EXPERIMENTS_DIR/.parseval_venv/bin/python"
    PIP_EXEC="$EXPERIMENTS_DIR/.parseval_venv/bin/pip"
else
    PYTHON_EXEC="$PYTHON_CMD"
    PIP_EXEC="pip3"
fi

# Ensure requirements installed
"$PIP_EXEC" install -q --no-compile -r "$EXPERIMENTS_DIR/ParSEval/requirements.txt" questionary psycopg2-binary pymysql 2>/dev/null || \
"$PYTHON_EXEC" -m pip install -q --no-compile -r "$EXPERIMENTS_DIR/ParSEval/requirements.txt" questionary psycopg2-binary pymysql 2>/dev/null || true

echo "=================================================================="
echo "Running ParSEval Benchmark for Beaver (dw schema)"
echo "Python interpreter: $PYTHON_EXEC"
echo "=================================================================="

"$PYTHON_EXEC" "$DIR/test_beaver_parseval.py" "$@"
