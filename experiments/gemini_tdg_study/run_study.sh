#!/usr/bin/env bash
# Re-execute under bash if invoked via sh/dash
if [ -z "$BASH_VERSION" ]; then
    exec bash "$0" "$@"
fi

# ==============================================================================
# Gemini-TDG Bounded & Unrestricted Study Runner
# Sweeps across dataset bounds (k in K_SWEEP) and executes unrestricted mode
# to comprehensively compare bounded vs unrestricted test data generation.
# ==============================================================================

set -e

STUDY_DIR="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"
EXPERIMENTS_DIR="$( cd "$STUDY_DIR/.." >/dev/null 2>&1 && pwd )"
cd "$EXPERIMENTS_DIR"

# Detect Python interpreter (prefer existing venvs if available)
PYTHON_CMD=""
if [ -d "$EXPERIMENTS_DIR/../.venv" ] && [ -f "$EXPERIMENTS_DIR/../.venv/bin/python" ]; then
    PYTHON_EXEC="$EXPERIMENTS_DIR/../.venv/bin/python"
    export PATH="$EXPERIMENTS_DIR/../.venv/bin:$PATH"
elif [ -d "$EXPERIMENTS_DIR/../venv" ] && [ -f "$EXPERIMENTS_DIR/../venv/bin/python" ]; then
    PYTHON_EXEC="$EXPERIMENTS_DIR/../venv/bin/python"
    export PATH="$EXPERIMENTS_DIR/../venv/bin:$PATH"
elif [ -d "$EXPERIMENTS_DIR/.lasso_venv" ] && [ -f "$EXPERIMENTS_DIR/.lasso_venv/bin/python" ]; then
    PYTHON_EXEC="$EXPERIMENTS_DIR/.lasso_venv/bin/python"
    export PATH="$EXPERIMENTS_DIR/.lasso_venv/bin:$PATH"
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
fi

export PYTHON_EXEC

# Parse options
K_SWEEP="${K_SWEEP:-1 3 5 10}"
INCLUDE_UNRESTRICTED=1
RESUME_FLAG="--resume"

PASSED_BENCHMARK=""
FILTERED_ARGS=()

skip_next=0
for arg in "$@"; do
    if [ "$skip_next" -eq 1 ]; then
        skip_next=0
        continue
    fi
    case "$arg" in
        --k-sweep)
            skip_next=1
            ;;
        --k-sweep=*)
            K_SWEEP="${arg#*=}"
            ;;
        --skip-unrestricted)
            INCLUDE_UNRESTRICTED=0
            ;;
        --include-unrestricted)
            INCLUDE_UNRESTRICTED=1
            ;;
        --mode|--max-datasets)
            # Filter out explicit mode/max-datasets since this script orchestrates them
            skip_next=1
            ;;
        --mode=*|--max-datasets=*)
            ;;
        --full|--rerun)
            RESUME_FLAG=""
            ;;
        --retry)
            RESUME_FLAG="--retry"
            ;;
        --resume)
            RESUME_FLAG="--resume"
            ;;
        --benchmark)
            skip_next=1
            ;;
        --benchmark=*)
            PASSED_BENCHMARK="${arg#*=}"
            ;;
        *)
            FILTERED_ARGS+=("$arg")
            ;;
    esac
done

# Benchmark selection
if [ -n "$PASSED_BENCHMARK" ]; then
    BENCHMARK="$PASSED_BENCHMARK"
fi

if [ -z "$BENCHMARK" ]; then
    if [ -t 0 ]; then
        if [ -n "$ALLOWED_BENCHMARKS" ]; then
            export ALLOWED_BENCHMARKS
        fi
        . "$EXPERIMENTS_DIR/select_benchmark.sh" "$@"
    else
        # Default non-interactive benchmark for TDG study is xdata
        BENCHMARK="${BENCHMARK:-xdata}"
    fi
fi

INPUT_OPT=""
if [ -n "$INPUT_FILE" ]; then
    INPUT_OPT="--input-file $INPUT_FILE"
fi

echo "======================================================================"
echo "          Gemini-TDG Comprehensive Bounded & Unrestricted Study       "
echo "======================================================================"
echo "Benchmark(s):           $BENCHMARK"
echo "Bounds (k) to sweep:    $K_SWEEP"
echo "Include Unrestricted:   $([ "$INCLUDE_UNRESTRICTED" -eq 1 ] && echo 'Yes' || echo 'No')"
echo "Execution Resume Mode:  ${RESUME_FLAG:-Full (re-run all)}"
echo "Study Results Dir:      $STUDY_DIR/results"
echo "Main Results Dir:       $EXPERIMENTS_DIR/results"
echo "======================================================================"

# 1. Bounded Sweeps
for k in $K_SWEEP; do
    echo ""
    echo "----------------------------------------------------------------------"
    echo ">>> Phase 1: Running Bounded Sweep for k = $k"
    echo "----------------------------------------------------------------------"
    for bm in $BENCHMARK; do
        "$PYTHON_EXEC" "$EXPERIMENTS_DIR/evaluate_llm_tdg.py" \
            --benchmark "$bm" \
            --mode bounded \
            --max-datasets "$k" \
            $INPUT_OPT \
            $RESUME_FLAG \
            $DIALECT_OPT \
            "${FILTERED_ARGS[@]}"
    done
done

# 2. Unrestricted Run
if [ "$INCLUDE_UNRESTRICTED" -eq 1 ]; then
    echo ""
    echo "----------------------------------------------------------------------"
    echo ">>> Phase 2: Running Gemini-TDG in Unrestricted Mode"
    echo "----------------------------------------------------------------------"
    for bm in $BENCHMARK; do
        "$PYTHON_EXEC" "$EXPERIMENTS_DIR/evaluate_llm_tdg.py" \
            --benchmark "$bm" \
            --mode unrestricted \
            $INPUT_OPT \
            $RESUME_FLAG \
            $DIALECT_OPT \
            "${FILTERED_ARGS[@]}"
    done
fi

# 3. Comparative Analysis
echo ""
echo "======================================================================"
echo ">>> Phase 3: Generating Comparative Analysis Report..."
echo "======================================================================"
"$PYTHON_EXEC" "$STUDY_DIR/analyze_bounded_study.py" \
    --study-results-dir "$STUDY_DIR/results" \
    --main-results-dir "$EXPERIMENTS_DIR/results" \
    --output-file "$STUDY_DIR/study_summary.md"

IP_ADDR=$(ip -4 addr show enp34s0 2>/dev/null | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | head -n 1)
[ -z "$IP_ADDR" ] && IP_ADDR="localhost"

echo ""
echo "======================================================================"
echo "Study complete! View results at:"
echo "  - Results Page: http://${IP_ADDR}:8000/results"
echo "======================================================================"
