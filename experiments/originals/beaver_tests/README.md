# Beaver Benchmark (dw Schema) Test Suite

This experiment suite evaluates the test data generation capability of **LASSO**, **ParSEval**, **XData**, and **XDataPublic** on the top 10 queries from the `dw` schema in the [BeaverBench dataset](https://huggingface.co/datasets/beaverbench/beaver-query).

The primary evaluation metric is non-empty execution: whether each tool generates a test dataset that yields at least 1 row when executing the query.

---

## Directory Structure

- `schema.sql`: Clean SQLite DDL definitions for the 13 required tables in the `dw` schema.
- `sample_data.sql`: Extracted seed rows (INSERT statements) from the Beaver dump for XData/XDataPublic.
- `top10_queries.json`: Extracted top 10 queries (`dw_0` through `dw_9`) with SQL, required tables, and join keys.
- `run_all.sh`: Master benchmark execution script. Runs all 4 tools (or a selected tool) and displays a consolidated comparison table.
- `run_lasso.sh`: Setup and evaluation script for **LASSO**.
- `run_parseval.sh`: Setup and evaluation script for **ParSEval**.
- `run_xdata.sh`: Setup and evaluation script for **XData** (standard/internal build).
- `run_xdatapublic.sh`: Setup and evaluation script for **XDataPublic** (public GitHub build).
- `compare_results.py`: Aggregates `results.csv` from all tools and prints a formatted terminal/markdown table.
- `results_<tool>/`: Output directory containing generated datasets (`.sql`), query execution metrics, and `results.csv`.

---

## Running the Benchmark

### 1. Run All Tools
```bash
./experiments/beaver_tests/run_all.sh
```

### 2. Run a Specific Tool
```bash
./experiments/beaver_tests/run_all.sh --tool lasso
./experiments/beaver_tests/run_all.sh --tool parseval
./experiments/beaver_tests/run_all.sh --tool xdata
./experiments/beaver_tests/run_all.sh --tool xdatapublic
```

Or invoke the individual tool scripts directly:
```bash
./experiments/beaver_tests/run_lasso.sh
./experiments/beaver_tests/run_parseval.sh
./experiments/beaver_tests/run_xdata.sh
./experiments/beaver_tests/run_xdatapublic.sh
```

### 3. Filter Specific Queries or Adjust Timeout
Each runner accepts `--queries` and `--timeout`:
```bash
./experiments/beaver_tests/run_lasso.sh --queries dw_0,dw_1,dw_2
./experiments/beaver_tests/run_parseval.sh --queries dw_0,dw_1 --timeout 15
./experiments/beaver_tests/run_xdata.sh --queries dw_0 --timeout 60
```

### 4. View Consolidated Comparison
```bash
python3 experiments/beaver_tests/compare_results.py
```
