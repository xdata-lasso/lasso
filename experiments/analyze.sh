#!/usr/bin/env bash
# ==============================================================================
# LASSO Analysis Runner
# Executes all result analyses, updates summary payloads, and ensures the
# research & evaluation web server (web/server.py) is active.
# ==============================================================================

if [ -z "$BASH_VERSION" ]; then
    exec bash "$0" "$@"
fi

set -e

REAL_SCRIPT="$(readlink -f "${BASH_SOURCE[0]}")"
EXPERIMENTS_DIR="$(cd "$(dirname "$REAL_SCRIPT")" && pwd)"
REPO_DIR="$(cd "${EXPERIMENTS_DIR}/.." && pwd)"

cd "${EXPERIMENTS_DIR}"

echo "============================================================"
echo "           LASSO Benchmark & Evaluation Analysis            "
echo "============================================================"
echo "Working directory: ${EXPERIMENTS_DIR}"
echo ""

# 1. Run Main Unified Benchmark Analysis
echo "--> [1/3] Running unified analysis (analyze_results.py)..."
python3 "${EXPERIMENTS_DIR}/analyze_results.py" "$@"

# 2. Run Strategy Breakdown Analysis (if kill CSVs exist)
if compgen -G "${EXPERIMENTS_DIR}/results/lasso_strategy_kills_*.csv" > /dev/null 2>&1; then
  echo "--> [2/3] Summarizing LASSO strategy kills..."
  python3 "${EXPERIMENTS_DIR}/summarize_strategy_results.py"
else
  echo "--> [2/3] Skipping strategy kills (no lasso_strategy_kills_*.csv found)."
fi

# 3. Run Gemini-TDG Bounded Study Analysis (if study directory exists)
if [ -f "${EXPERIMENTS_DIR}/gemini_tdg_study/analyze_bounded_study.py" ]; then
  echo "--> [3/3] Running Gemini-TDG bounded study analysis..."
  python3 "${EXPERIMENTS_DIR}/gemini_tdg_study/analyze_bounded_study.py" \
    --output-file "${EXPERIMENTS_DIR}/gemini_tdg_study/study_summary.md" 2>/dev/null || true
else
  echo "--> [3/3] Skipping Gemini-TDG bounded study analysis."
fi

# 4. Check and ensure Web Server (web/server.py) is running
echo ""
echo "--> Checking LASSO Web Server status..."
CONTAINER_NAME="lasso-analysis-server"

if command -v docker >/dev/null 2>&1 && docker info >/dev/null 2>&1; then
  "${EXPERIMENTS_DIR}/manage_server.sh" start
else
  if pgrep -f "python.*web/server.py" >/dev/null 2>&1; then
    echo "    Native Python web/server.py process is running."
  else
    echo "    Starting native web/server.py in background..."
    nohup python3 "${REPO_DIR}/web/server.py" > "${EXPERIMENTS_DIR}/server.log" 2>&1 &
    sleep 1
  fi
fi

# Determine host IP address
IP_ADDR=$(ip -4 addr show enp34s0 2>/dev/null | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | head -n 1)
if [ -z "$IP_ADDR" ]; then
  IP_ADDR=$(hostname -I 2>/dev/null | awk '{print $1}')
fi
if [ -z "$IP_ADDR" ]; then
  IP_ADDR="localhost"
fi

echo ""
echo "============================================================"
echo "Analysis complete! LASSO website & results are available at:"
echo "  - Research Home: http://localhost:8000/ (or http://${IP_ADDR}/)"
echo "  - Results Page:  http://localhost:8000/results (or http://${IP_ADDR}/results)"
echo "============================================================"
