#!/bin/bash
set -e

# Re-exec with bash if invoked via sh
if [ -z "$BASH_VERSION" ]; then
    exec bash "$0" "$@"
fi

DIR="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"
EXPERIMENTS_DIR="$( cd "$DIR/.." >/dev/null 2>&1 && pwd )"
REPO_ROOT="$( cd "$EXPERIMENTS_DIR/.." >/dev/null 2>&1 && pwd )"

# Parse tool option if provided
SELECTED_TOOL="all"
PASSTHROUGH_ARGS=()

prev=""
for arg in "$@"; do
    if [ "$prev" = "--tool" ]; then
        SELECTED_TOOL="$arg"
    elif [ "$arg" = "--tool" ]; then
        :
    elif [[ "$arg" == --tool=* ]]; then
        SELECTED_TOOL="${arg#*=}"
    else
        PASSTHROUGH_ARGS+=("$arg")
    fi
    prev="$arg"
done

# Benchmark selection
. "$DIR/select_benchmark.sh" "${PASSTHROUGH_ARGS[@]}"

echo "=================================================================="
echo "Master Runner: Non-Empty Data Generation"
echo "Target benchmark: $BENCHMARK"
echo "Selected tool(s): $SELECTED_TOOL"
echo "=================================================================="

# Function to run a tool safely
run_tool() {
    local tool_name="$1"
    local script_name="$2"
    echo ""
    echo ">>> Running $tool_name on $BENCHMARK..."
    if [ -x "$DIR/$script_name" ] || [ -f "$DIR/$script_name" ]; then
        bash "$DIR/$script_name" --benchmark "$BENCHMARK" "${PASSTHROUGH_ARGS[@]}" || {
            echo "Warning: $tool_name encountered an error or non-zero exit code."
        }
    else
        echo "Script $script_name not found. Skipping $tool_name."
    fi
}

case "$SELECTED_TOOL" in
    lasso)
        run_tool "LASSO" "run_lasso.sh"
        ;;
    parseval)
        run_tool "ParSEval" "run_parseval.sh"
        ;;
    xdata)
        run_tool "XData" "run_xdata.sh"
        ;;
    xdatapublic)
        run_tool "XDataPublic" "run_xdatapublic.sh"
        ;;
    gemini)
        run_tool "Gemini" "run_gemini.sh"
        ;;
    all)
        run_tool "LASSO" "run_lasso.sh"
        run_tool "ParSEval" "run_parseval.sh"
        run_tool "XData" "run_xdata.sh"
        run_tool "XDataPublic" "run_xdatapublic.sh"
        # Run Gemini if API key is present
        if [ -n "$GEMINI_API_KEY" ] || [ -n "$GOOGLE_API_KEY" ]; then
            run_tool "Gemini" "run_gemini.sh"
        fi
        ;;
    *)
        echo "Unknown tool '$SELECTED_TOOL'. Valid: lasso, parseval, xdata, xdatapublic, gemini, all."
        exit 1
        ;;
esac

echo ""
echo "=================================================================="
echo "Running Analysis on Non-Empty Data Generation Results..."
echo "=================================================================="

# Detect Python
PYTHON_EXEC="$(command -v python3 || command -v python)"
if [ -d "$REPO_ROOT/.venv" ] && [ -f "$REPO_ROOT/.venv/bin/python" ]; then
    PYTHON_EXEC="$REPO_ROOT/.venv/bin/python"
elif [ -d "$REPO_ROOT/venv" ] && [ -f "$REPO_ROOT/venv/bin/python" ]; then
    PYTHON_EXEC="$REPO_ROOT/venv/bin/python"
fi

"$PYTHON_EXEC" "$DIR/analyze_results.py"

echo "Done! Consolidated report available at $DIR/analysis.html"
