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
if [ -d "$DIR/originals/.spotit_venv" ] && [ -f "$DIR/originals/.spotit_venv/bin/python" ]; then
    PYTHON_EXEC="$DIR/originals/.spotit_venv/bin/python"
    PIP_EXEC="$DIR/originals/.spotit_venv/bin/pip"
    export PATH="$DIR/originals/.spotit_venv/bin:$PATH"
elif [ -d "$DIR/.spotit_venv" ] && [ -f "$DIR/.spotit_venv/bin/python" ]; then
    PYTHON_EXEC="$DIR/.spotit_venv/bin/python"
    PIP_EXEC="$DIR/.spotit_venv/bin/pip"
    export PATH="$DIR/.spotit_venv/bin:$PATH"
else
    echo "Creating SpotIt+ virtual environment..."
    "$PYTHON_CMD" -m venv "$DIR/originals/.spotit_venv" 2>/dev/null || "$PYTHON_CMD" -m virtualenv "$DIR/originals/.spotit_venv" 2>/dev/null || true
    if [ -f "$DIR/originals/.spotit_venv/bin/python" ]; then
        PYTHON_EXEC="$DIR/originals/.spotit_venv/bin/python"
        PIP_EXEC="$DIR/originals/.spotit_venv/bin/pip"
        export PATH="$DIR/originals/.spotit_venv/bin:$PATH"
    else
        PYTHON_EXEC="$PYTHON_CMD"
        PIP_EXEC="pip3"
    fi
fi

SPOTIT_DIR="$DIR/originals/SpotIt-plus"
if [ ! -d "$SPOTIT_DIR" ]; then
    SPOTIT_DIR="$DIR/SpotIt-plus"
fi

"$PIP_EXEC" install -q --upgrade pip 2>/dev/null || true
"$PIP_EXEC" install -q -r "$SPOTIT_DIR/requirements.txt" sqlglot psycopg2-binary pymysql questionary 2>/dev/null || \
"$PYTHON_EXEC" -m pip install -q -r "$SPOTIT_DIR/requirements.txt" sqlglot psycopg2-binary pymysql questionary 2>/dev/null || true

# Always ensure VeriEQL's custom Z3 bindings are properly linked in site-packages
for site_pkg in $("$PYTHON_EXEC" -c "import site; print(' '.join(site.getsitepackages()))" 2>/dev/null || echo ""); do
    if [ -d "$site_pkg" ]; then
        mkdir -p "$site_pkg/z3"
        cp -f "$SPOTIT_DIR/verieql/z3py_libs/"*.py "$site_pkg/z3/" 2>/dev/null || true
    fi
done

export PYTHON_EXEC

# Run spotit evaluation
. "$DIR/select_benchmark.sh"

INPUT_OPT=""
if [ ! -z "$INPUT_FILE" ]; then
    INPUT_OPT="--input-file $INPUT_FILE"
fi

for bm in $BENCHMARK; do
    echo "==========================================="
    echo "Running SpotIt benchmark: $bm"
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
    "$PYTHON_EXEC" "$DIR/evaluate_spotit.py" $EXEC_BENCH_OPT $INPUT_OPT $EXEC_RESUME_OPT $DIALECT_OPT "$@"
done
