#!/bin/bash
set -e

DIR="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

chmod +x "$DIR"/*.sh 2>/dev/null || true

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

# Ensure databases are up and healthy
. "$DIR/start_databases.sh"

# Check if benchmark datasets exist; build them if not present
if [ ! -f "$DIR/schemas.json" ] || [ ! -f "$DIR/queries.json" ] || [ ! -d "$DIR/benchmarks" ]; then
    echo "==========================================="
    echo "Reconstructing Benchmarks (benchmarks/)"
    echo "==========================================="
    "$PYTHON_CMD" "$DIR/build_benchmarks.py"
fi

# Benchmark selection
. "$DIR/select_benchmark.sh"

echo "==========================================="
echo "1. Running Lasso Evaluation"
echo "==========================================="
sh "$DIR/run_lasso.sh" "$@"

echo "==========================================="
echo "2. Running ParSEval Evaluation"
echo "==========================================="
sh "$DIR/run_parseval.sh" "$@"

echo "==========================================="
echo "3. Running SpotIt Evaluation"
echo "==========================================="
sh "$DIR/run_spotit.sh" "$@"

echo "==========================================="
echo "4. Running Polygon Evaluation"
echo "==========================================="
sh "$DIR/run_polygon.sh" "$@"

echo "==========================================="
echo "5. Running SQLWitness Evaluation"
echo "==========================================="
sh "$DIR/run_sqlwitness.sh" "$@"

echo "==========================================="
echo "6. Running XData-DataGen Evaluation"
echo "==========================================="
sh "$DIR/run_xdata.sh" "$@"

echo "==========================================="
echo "7. Running Analysis"
echo "==========================================="
"$PYTHON_CMD" "$DIR/analyze_results.py"

echo "==========================================="
echo "All tasks completed successfully!"
echo "==========================================="
