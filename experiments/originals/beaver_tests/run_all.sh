#!/bin/bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Default tool selection
TARGET_TOOL="all"
OTHER_ARGS=()

while [[ $# -gt 0 ]]; do
    case "$1" in
        --tool)
            TARGET_TOOL="$2"
            shift 2
            ;;
        *)
            OTHER_ARGS+=("$1")
            shift
            ;;
    esac
done

echo "=================================================================="
echo "BEAVER BENCHMARK SUITE (dw schema, top 10 queries)"
echo "Selected tool(s): $TARGET_TOOL"
echo "=================================================================="

run_tool() {
    local tool="$1"
    echo ""
    echo "=================================================================="
    echo "Starting $tool..."
    echo "=================================================================="
    if [ -f "$DIR/run_${tool}.sh" ]; then
        bash "$DIR/run_${tool}.sh" "${OTHER_ARGS[@]}" || {
            echo "Warning: $tool finished with non-zero exit code."
        }
    else
        echo "Error: Runner script $DIR/run_${tool}.sh not found."
    fi
}

case "$TARGET_TOOL" in
    lasso)
        run_tool "lasso"
        ;;
    parseval)
        run_tool "parseval"
        ;;
    xdata)
        run_tool "xdata"
        ;;
    xdatapublic)
        run_tool "xdatapublic"
        ;;
    all)
        run_tool "lasso"
        run_tool "parseval"
        run_tool "xdata"
        run_tool "xdatapublic"
        ;;
    *)
        echo "Unknown tool: $TARGET_TOOL. Options: lasso, parseval, xdata, xdatapublic, all"
        exit 1
        ;;
esac

echo ""
python3 "$DIR/compare_results.py" || true
