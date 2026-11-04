# LASSO: An LLM-Agent Synthesized System for SQL Validation

- **Project Website & Interactive Results:** [https://xdata-lasso.github.io](https://xdata-lasso.github.io)
- **Evaluation Results Explorer:** [https://xdata-lasso.github.io/results](https://xdata-lasso.github.io/results)
- **GitHub Repository:** [https://github.com/xdata-lasso/lasso](https://github.com/xdata-lasso/lasso)
- **arXiv Preprint:** [https://arxiv.org/abs/2610.38294](https://arxiv.org/abs/2610.38294)

This repository contains the official artifact evaluation reproduction package for **LASSO**, a framework for discovering semantic oversights, validating SQL query equivalence, and synthesizing deterministic counterexample datasets to refute incorrect SQL predictions.

---

## 1. Interactive Web Application

LASSO includes a self-contained web application (`web/server.py`) and a hosted static version at **[https://xdata-lasso.github.io](https://xdata-lasso.github.io)** featuring:
1. **Interactive Research Home & Live Try-Out (`/`)**: Enter a database schema (DDL), reference query, and candidate query to synthesize test datasets and counterexamples in real time ([https://xdata-lasso.github.io/](https://xdata-lasso.github.io/)).
2. **Evaluation Results Explorer (`/results`)**: Interactive visual charts, unified benchmark comparison tables, strategy kill breakdowns, and token usage/cost analysis across all 36,634 query pairs ([https://xdata-lasso.github.io/results](https://xdata-lasso.github.io/results)).

### Option A: Run Locally with Python (Full Live Execution for Arbitrary Queries)
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

## 3. Usage Guide: Generating Datasets & Using the Execution Tester

### A. Generating Test Datasets (`src/main.py`)

LASSO's core test data generator (`generate_test_data` in `src/main.py`) takes a SQL schema (DDL) and a single SQL query as input, executes its base data generation pipeline and applicable AST-driven attack strategies, and outputs a deduplicated list of test datasets.

#### Inputs to `generate_test_data(ddl_string, query_string, seed=42)`
- **`ddl_string` (`str`):** One or more SQL `CREATE TABLE` statements defining table names, column data types, `PRIMARY KEY`, `FOREIGN KEY ... REFERENCES ...`, `UNIQUE`, `NOT NULL`, and `CHECK` constraints.
- **`query_string` (`str`):** The target SQL `SELECT` query for which to synthesize test datasets. (Tip: normalize the query first with `normalize_sql` from `sql-execution-tester/query_normalizer.py` if it uses temporal functions or ambiguous `ORDER BY` clauses.)
- **`seed` (`int`, optional, default `42`):** Seed used to initialize LASSO's deterministic value generator (`DataFactory`).

#### Outputs (`list[Dataset]`)
Each `Dataset` object (defined in `src/models.py`) contains:
- **`strategy_name` (`str`):** Name(s) of the strategy that produced the dataset (e.g., `"BaseDatasetStrategy"`, `"JoinAttackStrategy"`, `"AggregateNullAttackStrategy"`).
- **`insert_statements` (`list[str]`):** Ready-to-execute SQL `INSERT INTO ... VALUES ...;` statements respecting foreign key order and schema constraints.
- **`data` (`dict[str, list[dict[str, Any]]]`):** Structured dictionary mapping each table name to its list of generated row dicts (`{col_name: value}`).
- **`tags` (`list[str]`):** Semantic tags indicating the targeted mutation class.
- **`description` (`str`):** Human-readable explanation of the semantic bug or edge case targeted by the dataset.

You can also call `generate_test_data_with_meta(ddl_string, query_string)` to receive `(datasets, meta)`, where `meta` includes `data_gen_time`, `num_datasets`, `attack_strategies`, and `error_message`.

#### Python Example: Generating Test Datasets
```python
import sys
sys.path.insert(0, "src")
sys.path.insert(0, "sql-execution-tester")

from main import generate_test_data
from query_normalizer import normalize_sql

schema_ddl = """
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    dept_id INT,
    salary INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);
"""

query = """
SELECT d.dept_name, COUNT(e.emp_id) AS emp_count
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name;
"""

# Optional: normalize query for deterministic execution
norm_query = normalize_sql(query, schema_ddl, dialect="sqlite")

# Generate test datasets
datasets = generate_test_data(schema_ddl, norm_query)

print(f"Synthesized {len(datasets)} test datasets:")
for idx, ds in enumerate(datasets, 1):
    print(f"\n--- Dataset #{idx} [{ds.strategy_name}] ---")
    print(f"Target: {ds.description}")
    print("\n".join(ds.insert_statements))
```

---

### B. Using the SQL Execution Tester (`sql-execution-tester/`)

The `sql-execution-tester/` module (EX+) provides isolated, multi-dialect SQL execution and result comparison across **SQLite** (in-memory), **PostgreSQL**, and **MySQL**.

#### Inputs to `execution_test(...)` and `execution_test_batch(...)`
- **`schema` (`str`):** SQL DDL (`CREATE TABLE ...`) statements defining the database schema.
- **`dataset` (`str`):** SQL DML (`INSERT INTO ...`) statements used to populate the database instance.
- **`gold_sql` (`str`):** The reference (gold) SQL query.
- **`prediction_sql` (`str`) / `prediction_sqls` (`list[str]`):** A single candidate query (`execution_test`) or a batch of candidate queries (`execution_test_batch`) to compare against `gold_sql` on the same populated database instance.
- **`dialect` (`str`, default `"sqlite"`):** Database engine to execute on (`"sqlite"`, `"postgres"`, or `"mysql"`).
- **Optional Comparison Flags:**
  - `strict_column_ordering` (`bool`, default `True`): Require projected columns to appear in the exact same order (returns `"NEQ_SCO"` if columns match only under permutation).
  - `allow_extra_columns_in_q2` (`bool`, default `True`): Allow `prediction_sql` to project extra trailing columns beyond those in `gold_sql`.
  - `strict_type_checking` (`bool`, default `False`): Differentiate Python types strictly (e.g., `int` vs. `float`).
  - `ignore_order_for_order_by` (`bool`, default `False`): Compare results as multisets even when `ORDER BY` is present.
  - `db_config` (`dict`, optional): Custom connection credentials for PostgreSQL/MySQL (defaults automatically to the containers in `docker-compose.yml`).

#### Outputs from `execution_test(...)`
Returns a dictionary containing:
- **`status` (`str`):**
  - `"EQ_EXEC"`: Both queries executed without error and produced equivalent results on the dataset.
  - `"NEQ"`: Queries produced divergent results (equivalence refuted).
  - `"NEQ_SCO"`: Queries produced matching values only after relaxing strict column order.
  - `"ERROR_SYNTAX"` / `"ERROR_QUERY_EXECUTION"` / `"ERROR_SCHEMA_LOADING"` / `"ERROR_DATASET_LOADING"`: Execution or setup error diagnostics.
- **`reason` (`str` or `None`):** Specific discrepancy reason when `status` is `"NEQ"` (e.g., `"row_count_mismatch"`, `"value_mismatch"`, `"row_order_mismatch"`, `"duplicate_count_mismatch"`, `"column_count_mismatch"`).
- **`gold_sql_result` & `prediction_sql_result` (`list[tuple]`):** Raw output rows from both queries.
- **`reproducible_cex` (`str`):** Self-contained `.sql` script (DDL + `INSERT`s + both queries + expected outputs) that reproduces the execution result standalone.

#### 1. Python API Usage (Combining Dataset Generation & Execution Testing)
```python
import sys
sys.path.insert(0, "src")
sys.path.insert(0, "sql-execution-tester")

from main import generate_test_data, evaluate_predictions
from execution_tester import execution_test
from query_normalizer import normalize_sql

schema = """
CREATE TABLE staff (
    id INT PRIMARY KEY,
    department VARCHAR(40) NOT NULL,
    salary INT NOT NULL,
    bonus INT NULL
);
"""
gold_sql = "SELECT department, COUNT(*) AS total_staff FROM staff GROUP BY department;"
pred_sql = "SELECT department, COUNT(bonus) AS total_staff FROM staff GROUP BY department;"

# Option 1: Step-by-step dataset generation + execution_test
norm_gold = normalize_sql(gold_sql, schema, dialect="sqlite")
norm_pred = normalize_sql(pred_sql, schema, dialect="sqlite")

for ds in generate_test_data(schema, norm_gold):
    dataset_sql = "\n".join(ds.insert_statements)
    res = execution_test(
        schema=schema,
        dataset=dataset_sql,
        gold_sql=norm_gold,
        prediction_sql=norm_pred,
        dialect="sqlite",
    )
    if res["status"].startswith("NEQ"):
        print(f"Refuted by {ds.strategy_name}! Reason: {res['reason']}")
        print("Gold Output:", res["gold_sql_result"])
        print("Pred Output:", res["prediction_sql_result"])
        break

# Option 2: End-to-end 2-way cross-checking helper (evaluate_predictions)
summary = evaluate_predictions(
    ddl_string=schema,
    gold_query=gold_sql,
    prediction_queries={"cand_1": pred_sql},
    dialect="sqlite",
)
print(summary["predictions"]["cand_1"]["status"])
```

#### 2. Command-Line Interface (`sql-execution-tester/cli.py`)
You can also invoke the execution tester directly from the command line by passing inline SQL strings or file paths for `--schema`, `--dataset`, `--gold_sql`, and `--prediction_sql`:
```bash
python3 sql-execution-tester/cli.py \
  --schema "CREATE TABLE users (id INT PRIMARY KEY, name TEXT, age INT);" \
  --dataset "INSERT INTO users VALUES (1, 'Alice', 20);" \
  --gold_sql "SELECT name FROM users WHERE age >= 20;" \
  --prediction_sql "SELECT name FROM users WHERE age > 20;" \
  --dialect sqlite
```

#### 3. Evaluating Custom JSON Test Cases (`test_runner.py`)
To evaluate a structured JSON file containing a schema, reference query, and one or more candidate/mutant queries, create a JSON file with the following structure:
```json
{
  "id": "custom_join_test",
  "dialect": "sqlite",
  "schema": "CREATE TABLE depts (id INT PRIMARY KEY, name TEXT); CREATE TABLE emps (id INT PRIMARY KEY, dept_id INT);",
  "correct_query": "SELECT d.name, COUNT(e.id) FROM depts d LEFT JOIN emps e ON d.id = e.dept_id GROUP BY d.id, d.name;",
  "expected_mutants_to_kill": [
    {
      "id": "inner_join_mutant",
      "query": "SELECT d.name, COUNT(e.id) FROM depts d INNER JOIN emps e ON d.id = e.dept_id GROUP BY d.id, d.name;"
    }
  ]
}
```
Then run:
```bash
python3 test_runner.py path/to/test_case.json --debug
```

---

## 4. Technical Documentation (Paper Appendix Content)

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

## 5. Running the LASSO Test Suite

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

## 6. Reproducing Benchmark Results

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

## 7. Official Evaluation Results & Analysis

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

## 8. Repository Layout

```
.
├── docs/                         # Extended technical documentation (from paper appendix)
│   ├── pipeline_details.md       # Equivalence classes, Z3 solving & value resolution
│   ├── theoretical_foundations.md# Academic lineage & literature citations for components
│   └── agent_scaffolding.md      # LLM agent scaffolding prompt & design guidelines
├── web/                          # Interactive Research & Evaluation Web Application
│   ├── server.py                 # HTTP server & live LASSO execution API
│   ├── pages/                    # HTML entry points (index.html, results.html)
│   └── static/                   # Frontend JS, CSS, static data, and vendor bundles
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
