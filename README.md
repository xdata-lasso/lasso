# LASSO: An LLM-Agent Synthesized System for SQL Validation

- **arXiv Preprint:** [https://arxiv.org/abs/2610.38294](https://arxiv.org/abs/2610.38294)

This repository contains the official artifact evaluation reproduction package for **LASSO**, a framework for discovering semantic oversights, validating SQL query equivalence, and synthesizing deterministic counterexample datasets to refute incorrect SQL predictions.

---

## 1. Interactive Web Application

LASSO includes a self-contained web application (`web/server.py`) featuring:
1. **Interactive Research Home & Live Try-Out (`/`)**: Enter a database schema (DDL), reference query, and candidate query to synthesize test datasets and counterexamples in real time.
2. **Evaluation Results Explorer (`/results`)**: Interactive visual charts, unified benchmark comparison tables, strategy kill breakdowns, and token usage/cost analysis across all 36,634 query pairs.

### Option A: Run Directly with Python (No Docker Required)
```bash
source venv/bin/activate
python3 web/server.py
```
By default, the server listens on port `8000` (configurable via `PORT=8080 python3 web/server.py`):
- **Research Home & Try-Out:** [http://localhost:8000/](http://localhost:8000/)
- **Evaluation Results Viewer:** [http://localhost:8000/results](http://localhost:8000/results)

### Option B: Run via Docker Server Manager
```bash
bash experiments/manage_server.sh start
# Other commands: status | restart | stop | logs
```

---

## 2. System Requirements & Environment Setup

- **Operating System:** Linux (Ubuntu 20.04+ or Debian recommended) or macOS
- **Python:** Python 3.10 or higher
- **Java:** OpenJDK 11+ (required only for XData-DataGen baseline)
- **Docker & Docker Compose:** Required only for PostgreSQL / MySQL multi-engine tests

### A. Quick Setup
```bash
chmod +x setup_env.sh
./setup_env.sh
source venv/bin/activate
```

### B. Manual Setup
```bash
python3 -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt
```

### C. Start Test Databases (Docker)
To start PostgreSQL (port `54320`) and MySQL (port `33060`):
```bash
docker compose up -d
docker compose ps
```

---

## 3. Technical Documentation (Paper Appendix Content)

The extended technical specifications and theoretical foundations from the paper's appendices are included directly in the repository under `docs/`:

1. **[Base Data Generation Pipeline Details (`docs/pipeline_details.md`)](docs/pipeline_details.md):**
   - Detailed specification of the 4-phase data generation pipeline.
   - Disjoint-set `UnionFind` join equivalence class construction.
   - Multi-column arithmetic solving and uniform group aggregate modeling in Z3 SMT (`COUNT`, `SUM`, `AVG`, `MIN`, `MAX`, scalar subqueries).
   - Complete field structure and populating sources for `ColumnSpec`.
   - Cardinality lower-bound derivation $\mathcal{K}_{\min} = \max(1, \mathcal{K}_{\text{Z3}}, \mathcal{K}_{\text{HAVING}}, \dots)$.
   - Five-step column value resolution and multi-column `CHECK` constraint repair.

2. **[Theoretical Foundations & Academic Lineage (`docs/theoretical_foundations.md`)](docs/theoretical_foundations.md):**
   - Comprehensive academic lineage mapping core LASSO modules and attack strategies to foundational database literature.
   - Relational algebra, SMT theories, Codd's Three-Valued Logic (3VL), mutation testing taxonomy, and OLAP window semantics.
   - Full formal bibliography with complete citations.

3. **[Agent Scaffolding Prompt & Design Philosophy (`docs/agent_scaffolding.md`)](docs/agent_scaffolding.md):**
   - The original scaffolding prompt and core tenets provided to the LLM agent.
   - Architectural principles: modular attack separation, AST-derived reasoning, and imperative-first procedural synthesis.
   - Engineering rules governing deterministic test data generation.
   - Example human-agent dialogue and interaction log during iterative feature expansion.

---

## 4. Running the LASSO Test Suite

LASSO includes an extensive test suite covering semantic mutation categories (aggregates, joins, nulls, order/limit, subqueries, datetime, predicates, window functions, CTEs, etc.).

### Run All Test Cases
```bash
python3 run_all.py
```
To view detailed per-test mutation tables:
```bash
python3 run_all.py --verbose
```

### Run an Individual Test Case
```bash
python3 test_runner.py test_cases/join/join_type_mismatch_medium.json --debug
```

---

## 5. Reproducing Benchmark Results

All evaluation scripts, baseline tools, benchmark datasets (12 benchmarks, 36,634 query pairs), and official experimental results are located in the `experiments/` directory (and accessible via `results/`).

```bash
cd experiments
```

### A. Master Evaluation Runner
To run the full evaluation suite across all tools:
```bash
./run_all.sh
```

### B. Running LASSO & Baseline Tools Individually
- **LASSO (1-way & 2-way Cross-Checking):**
  ```bash
  ./run_lasso.sh --benchmark all
  ```
- **LLM Equivalence Refutation (`gemini-4-argon-{high,medium,low}-er`):**
  ```bash
  ./run_llm_er.sh --model gemini-4-argon-high --benchmark all
  ```
- **LLM Test Data Generation (`gemini-4-argon-{high,medium,low}-tdg`):**
  ```bash
  ./run_llm_tdg.sh --model gemini-4-argon-high --benchmark all
  ```
- **SQLWitness:**
  ```bash
  ./run_sqlwitness.sh --benchmark all
  ```
- **ParSEval:**
  ```bash
  ./run_parseval.sh --benchmark all
  ```
- **Polygon:**
  ```bash
  ./run_polygon.sh --benchmark all
  ```
- **SpotIt+:**
  ```bash
  ./run_spotit.sh --benchmark all
  ```
- **XData-DataGen:**
  ```bash
  ./run_xdata.sh --benchmark xdata
  ./run_xdatapublic.sh --benchmark xdata
  ```

### C. Running Cross-Checking Study
```bash
./run_cross_checking_study.sh
```

---

## 6. Official Evaluation Results & Analysis

Precomputed evaluation results, counterexample databases, error diagnostics, and analysis scripts are included directly in `results/` (and `experiments/results/`):

- **Precomputed Benchmark CSVs (`results/*.csv`):** Per-tool raw and datagen execution results across all 12 benchmarks (`lasso_*.csv`, `gemini-4-argon-{high,medium,low}-{er,tdg}_*.csv`, `sqlwitness_*.csv`, `parseval_*.csv`, `polygon_*.csv`, `spotit_*.csv`, `xdata_*.csv`, `xdatapublic_*.csv`).
- **Reproducible Counterexamples (`results/reproducible_cex/`):** Exact synthesized SQLite/PostgreSQL database scripts demonstrating query non-equivalence.
- **Cross-Checking Study (`results/cross_checking_study/`):** Mutual cross-validation results across all tools.

### Summarize Benchmark Comparison Results
To aggregate results across all tools and compute the paper's comparison tables and JSON summary:
```bash
cd experiments
python3 analyze_results.py
```
This outputs `experiments/analysis.txt` and `experiments/analysis_summary.json`.

### Summarize Strategy Kill Breakdown
To examine the kill contribution of each individual attack strategy:
```bash
cd experiments
python3 summarize_strategy_results.py
```
The summary breakdown is written to `experiments/strategy_summary.txt`.

---

## 7. Repository Layout

```
.
├── docs/                         # Extended technical documentation (from paper appendix)
│   ├── pipeline_details.md       # Equivalence classes, Z3 solving & value resolution
│   ├── theoretical_foundations.md# Academic lineage & literature citations for components
│   └── agent_scaffolding.md      # LLM agent scaffolding prompt & design guidelines
├── web/                          # Interactive Research & Evaluation Web Application
│   ├── server.py                 # HTTP server & live LASSO execution API
│   ├── pages/                    # HTML entry points (index.html, results.html)
│   └── static/                   # Frontend JS, CSS, and vendor bundles
├── results/                      # Precomputed evaluation results (symlink to experiments/results)
├── src/                          # Core LASSO implementation
│   ├── attacks/                  # Modular AST-driven attack strategy implementations
│   ├── dataset_generator/        # Symbolic dataset generation & constraint solving
│   ├── parser.py                 # SQL AST parser & normalizer
│   ├── z3_solver.py              # Z3 SMT constraint solving
│   └── main.py                   # Generation entry point
├── sql-execution-tester/         # Multi-dialect SQL execution and comparator engine
├── test_cases/                   # Structured semantic mutation test suites
├── tests/                        # Unit tests
├── test_runner.py                # Single test case execution runner
├── run_all.py                    # Test suite batch runner
├── find_improvements.py          # Helper script to partition unrefuted benchmark queries
├── docker-compose.yml            # Postgres, MySQL & execution tester containers
├── requirements.txt              # Python dependencies
└── experiments/                  # Evaluation reproduction suite
    ├── run_all.sh                # Master evaluation pipeline
    ├── manage_server.sh          # Web server container manager
    ├── analyze_results.py        # Table generator & JSON summary script
    ├── evaluate_lasso.py         # LASSO evaluator
    ├── evaluate_llm_er.py        # LLM pairwise equivalence refutation evaluator
    ├── evaluate_llm_tdg.py       # LLM single-query test data generation evaluator
    ├── benchmarks/               # Per-benchmark SQLite/Postgres/MySQL query & DDL suites
    ├── queries.json              # Unified 12-benchmark query suite (36,634 pairs)
    ├── schemas.json              # Unified database schemas
    ├── results/                  # Precomputed CSVs & reproducible SQL counterexamples
    └── originals/                # Baseline tool artifacts (SpotIt+, ParSEval, SQLWitness, XData, Polygon)
```
