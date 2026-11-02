# Gemini-TDG Bounded Dataset Study

This study evaluates the effect of bounding the maximum number of synthesized test datasets ($k$) in **Gemini-TDG** compared to **Unrestricted** generation (where the LLM freely determines the dataset count).

## Overview

- **Unrestricted Mode:** The prompt instructs the LLM to generate as many diverse test datasets as needed to thoroughly exercise the query logic. Results are stored in `experiments/results/` (`gemini_tdg_{benchmark}.csv`) and are integrated into the main evaluation analysis (`experiments/analyze_results.py`).
- **Bounded Mode:** The LLM is explicitly requested to produce at most $k$ test datasets (e.g., $k \in \{1, 3, 5, 10\}$), and the evaluator enforces this upper bound. Results are stored in this isolated directory: `experiments/gemini_tdg_study/results/` (`gemini_tdg_k{N}_{benchmark}.csv`).

## Directory Structure

- `analyze_bounded_study.py`: Discovers all bounded evaluation runs in `results/` plus the unrestricted runs in `../results/` and compiles comparative tables (Refutation Rate vs $k$, Token Usage vs $k$, Datasets Generated vs $k$, Runtime vs $k$).
- `run_study.sh`: Automates running a parameter sweep over $k \in \{1, 3, 5, 10\}$ (or custom `K_SWEEP`).
- `results/`: Isolated storage for bounded CSVs (`gemini_tdg_k1_*.csv`, `gemini_tdg_k3_*.csv`, etc.) and associated artifacts (`raw_cex/`, `reproducible_cex/`, `error_msg/`).
- `study_summary.md`: Generated Markdown report comparing bounded configurations against unrestricted TDG.

## Running the Study

### 1. Interactive or Single Bound Run
You can run an individual bounded configuration using `run_llm_tdg.sh` from `experiments/`:
```bash
# Interactive selection: choose "2. Bounded" and enter k (e.g. 3)
sh experiments/run_llm_tdg.sh

# Non-interactive CLI invocation:
sh experiments/run_llm_tdg.sh --mode bounded --max-datasets 3 --benchmark leetcode
```

### 2. Full Parameter Sweep
To run a sweep across multiple bounds (e.g., $k=1, 3, 5, 10$):
```bash
# Run on a specific benchmark (e.g. literature):
K_SWEEP="1 3 5 10" sh experiments/gemini_tdg_study/run_study.sh --benchmark literature

# Or run on all benchmarks:
sh experiments/gemini_tdg_study/run_study.sh --benchmark all
```

### 3. Analyzing the Results
To inspect the comparative performance across all discovered $k$ values and unrestricted mode:
```bash
python3 experiments/gemini_tdg_study/analyze_bounded_study.py
```
To export a Markdown summary table:
```bash
python3 experiments/gemini_tdg_study/analyze_bounded_study.py --output-file experiments/gemini_tdg_study/study_summary.md
```
