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
if [ -d "$DIR/originals/.parseval_venv" ] && [ -f "$DIR/originals/.parseval_venv/bin/python" ]; then
    PYTHON_EXEC="$DIR/originals/.parseval_venv/bin/python"
    PIP_EXEC="$DIR/originals/.parseval_venv/bin/pip"
    export PATH="$DIR/originals/.parseval_venv/bin:$PATH"
elif [ -d "$DIR/.parseval_venv" ] && [ -f "$DIR/.parseval_venv/bin/python" ]; then
    PYTHON_EXEC="$DIR/.parseval_venv/bin/python"
    PIP_EXEC="$DIR/.parseval_venv/bin/pip"
    export PATH="$DIR/.parseval_venv/bin:$PATH"
else
    echo "Creating ParSEval virtual environment..."
    "$PYTHON_CMD" -m venv "$DIR/originals/.parseval_venv" 2>/dev/null || "$PYTHON_CMD" -m virtualenv "$DIR/originals/.parseval_venv" 2>/dev/null || true
    if [ -f "$DIR/originals/.parseval_venv/bin/python" ]; then
        PYTHON_EXEC="$DIR/originals/.parseval_venv/bin/python"
        PIP_EXEC="$DIR/originals/.parseval_venv/bin/pip"
        export PATH="$DIR/originals/.parseval_venv/bin:$PATH"
    else
        PYTHON_EXEC="$PYTHON_CMD"
        PIP_EXEC="pip3"
    fi
fi

PARSEVAL_REQ="$DIR/originals/ParSEval/requirements.txt"
if [ ! -f "$PARSEVAL_REQ" ]; then
    PARSEVAL_REQ="$DIR/ParSEval/requirements.txt"
fi
"$PIP_EXEC" install -q --no-compile -r "$PARSEVAL_REQ" questionary psycopg2-binary pymysql 2>/dev/null || \
"$PYTHON_EXEC" -m pip install -q --no-compile -r "$PARSEVAL_REQ" questionary psycopg2-binary pymysql 2>/dev/null || true

export PYTHON_EXEC

# Run parseval evaluation
. "$DIR/select_benchmark.sh"

INPUT_OPT=""
if [ ! -z "$INPUT_FILE" ]; then
    INPUT_OPT="--input-file $INPUT_FILE"
fi

for bm in $BENCHMARK; do
    echo "==========================================="
    echo "Running ParSEval benchmark: $bm"
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
    "$PYTHON_EXEC" "$DIR/evaluate_parseval.py" $EXEC_BENCH_OPT $INPUT_OPT $EXEC_RESUME_OPT $DIALECT_OPT "$@"
done
