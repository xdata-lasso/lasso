# Non-Empty Test Data Generation Evaluation Suite (`non-empty-dg`)

This module provides a unified benchmark framework and runner suite for evaluating the **non-empty test data generation** capability of database test data generation tools:
- **LASSO**
- **ParSEval**
- **XData** (standard/internal)
- **XDataPublic** (public GitHub build)
- **Gemini** (LLM prompt-based data generator)

The primary evaluation metric is **non-empty execution**: whether each tool can generate a valid dataset conforming to schema and foreign key constraints such that executing the target query yields at least 1 output row (`status == 'OK'` and `row_count > 0`).

---

## Directory Structure

```text
experiments/non-empty-dg/
├── benchmarks/              # Benchmark directories (DDL.sql + queries.txt)
│   ├── beaver/              # BeaverBench dw schema
│   │   ├── DDL.sql
│   │   └── queries.txt
│   ├── beaver_nova/         # BeaverBench nova schema
│   │   ├── DDL.sql
│   │   └── queries.txt
│   ├── beaver_neutron/      # BeaverBench neutron schema
│   │   ├── DDL.sql
│   │   └── queries.txt
│   ├── tpch/                # TPC-H standard benchmark
│   │   ├── DDL.sql
│   │   └── queries.txt
│   ├── xdata_bm/            # XData-BM benchmark suite
│   │   ├── DDL.sql
│   │   └── queries.txt
│   └── largejoin/           # Large multi-table join suite
│       ├── DDL.sql
│       └── queries.txt
├── results/                 # Output datasets and execution metrics
│   ├── beaver/              # Per-benchmark result folders
│   │   ├── results_lasso/
│   │   ├── results_parseval/
│   │   ├── results_xdata/
│   │   ├── results_xdatapublic/
│   │   └── results_gemini/
│   ├── tpch/
│   │   ├── results_lasso/
│   │   └── results_xdata/
│   └── ...
├── build_benchmarks.py      # Extracts SQLite-compatible schemas & queries from HF/repos
├── select_benchmark.sh      # Helper for CLI and interactive benchmark selection
├── run_all.sh               # Master script to run all or selected tools across benchmarks
├── run_lasso.sh             # Runner script for LASSO
├── run_parseval.sh          # Runner script for ParSEval
├── run_xdata.sh             # Runner script for XData
├── run_xdatapublic.sh       # Runner script for XDataPublic
├── run_gemini.sh            # Runner script for Gemini
├── evaluate_lasso.py        # Python evaluator for LASSO
├── evaluate_parseval.py     # Python evaluator for ParSEval
├── evaluate_xdata.py        # Python evaluator for XData / XDataPublic
├── evaluate_gemini.py       # Python evaluator for Gemini
├── analyze_results.py       # Analyzes results, prints ASCII table, generates analysis.html
├── analysis.html            # Consolidated modern HTML report
└── analysis.txt             # Consolidated plain-text report
```

---

## Benchmark Storage Format

Each benchmark is stored in its own subfolder under `benchmarks/<benchmark_name>/` using two standard files:

1. **`DDL.sql`**: SQLite DDL containing `CREATE TABLE` statements with primary keys, column types, and foreign key constraints.
2. **`queries.txt`**: SQL queries, where **each query is formatted on a single line** (one line per query).

---

## Building Benchmarks

[`build_benchmarks.py`](file:///home/shreyas/xdata/lasso/experiments/non-empty-dg/build_benchmarks.py) handles extracting, converting, and validating benchmarks.

### Features
- **BeaverBench Support**:
  - Clones or loads schema definitions from `beaverbench/beaver-table` Parquet files (`dw`, `nova`, `neutron`).
  - Fetches queries from HuggingFace dataset `beaverbench/beaver-query`.
  - Translates MySQL-specific column types (e.g. `ENUM(...)`, `SET(...)`, `DATETIME`) into valid SQLite types (`TEXT`, `INTEGER`, etc.).
- **Strict SQLite Compatibility Validation**:
  - Executes every candidate query against an in-memory SQLite database initialized with `DDL.sql`.
  - Automatically filters out queries utilizing unsupported dialect constructs, non-standard built-in functions (e.g., `STDDEV`, `VARIANCE`, `REGEXP`), or syntax errors.
  - Formats every valid query onto a single line in `queries.txt`.

### Usage
```bash
# Build all benchmarks
python3 build_benchmarks.py

# Build specific benchmarks
python3 build_benchmarks.py --benchmark beaver
python3 build_benchmarks.py --benchmark beaver_nova
python3 build_benchmarks.py --benchmark beaver_neutron
python3 build_benchmarks.py --benchmark tpch
python3 build_benchmarks.py --benchmark xdata_bm
python3 build_benchmarks.py --benchmark largejoin

# Provide custom HuggingFace token if required
python3 build_benchmarks.py --hf-token <token>
```

---

## Running the Benchmark Tools

### 1. Interactive or Single Tool Execution
Each runner script supports `--benchmark <name>` or an interactive selection menu if executed without flags:
```bash
# Run LASSO on Beaver
./run_lasso.sh --benchmark beaver

# Run LASSO on Beaver Nova
./run_lasso.sh --benchmark beaver_nova

# Run LASSO on TPC-H
./run_lasso.sh --benchmark tpch

# Run ParSEval on Beaver
./run_parseval.sh --benchmark beaver

# Run XData on Beaver
./run_xdata.sh --benchmark beaver

# Run XDataPublic on Beaver
./run_xdatapublic.sh --benchmark beaver

# Run Gemini LLM on Beaver (requires GEMINI_API_KEY)
./run_gemini.sh --benchmark beaver
```

### 2. Query Filtering & Timeouts
Filter specific query indices or set custom execution timeouts (in seconds):
```bash
# Run queries 0 and 1 with a 15-second timeout
./run_lasso.sh --benchmark beaver --queries 0,1 --timeout 15

# Run query 0 with ParSEval
./run_parseval.sh --benchmark beaver --queries 0 --timeout 30
```

### 3. Master Runner (`run_all.sh`)
Execute all tools or a subset across selected benchmarks:
```bash
# Run all tools across Beaver
./run_all.sh --benchmark beaver

# Run all tools across all benchmarks
./run_all.sh --benchmark all

# Run only LASSO across all benchmarks
./run_all.sh --tool lasso --benchmark all
```

---

## Analyzing Results and Generating Reports

[`analyze_results.py`](file:///home/shreyas/xdata/lasso/experiments/non-empty-dg/analyze_results.py) parses the results across all benchmarks and tools to produce:
1. An ASCII summary table in the terminal.
2. A plain-text report saved to `analysis.txt`.
3. A self-contained, responsive HTML dashboard saved to `analysis.html` featuring:
   - Overall success rates and execution times.
   - Per-benchmark and per-tool comparison metrics.
   - Drill-down query-level execution status, generated row counts, generation times, and SQL queries.

```bash
# Analyze all results
python3 analyze_results.py

# Custom output paths or filtering
python3 analyze_results.py --html analysis.html --output analysis.txt
python3 analyze_results.py --benchmark beaver
```
