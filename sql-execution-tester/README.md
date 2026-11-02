# Execution Test + (EX+)

A Python library for **reliable SQL query comparison** via execution. Ideal for Text-to-SQL validation and equivalence refutation. 

## Quick Start

```python
from execution_tester import execution_test
from query_normalizer import normalize_sql

schema = "CREATE TABLE users (id INTEGER, name TEXT);"
gold_sql = "SELECT name FROM users"
prediction_sql = "SELECT name FROM users"

# 1. Normalize queries safely before data generation and testing
norm_gold = normalize_sql(gold_sql, schema, dialect="sqlite")
norm_pred = normalize_sql(prediction_sql, schema, dialect="sqlite")

# 2. Execute and compare
result = execution_test(
    schema=schema,
    dataset="INSERT INTO users VALUES (1, 'Alice');",
    gold_sql=norm_gold,
    prediction_sql=norm_pred,
    strict_type_checking=False,     # Differentiate float vs int
    ignore_order_for_order_by=False,# Force unordered comparison even if ORDER BY is present
    strict_column_ordering=True,    # Require exact column sequence matching
    allow_extra_columns_in_q2=True  # Allow prediction_sql to produce extra trailing columns
)

print(result) # {'status': 'EQ_EXEC', 'gold_sql_result': [('Alice',)], 'prediction_sql_result': [('Alice',)]}
```

## System Inputs & Outputs

**Inputs**:
- `schema`: SQL DDL statements (e.g., `CREATE TABLE`) defining the database structure.
- `dataset`: SQL DML statements (e.g., `INSERT`) to populate the database with test data.
- `gold_sql` & `prediction_sql`: The two SQL queries to be executed and compared.
- `db_config` (optional): A connection configuration dict for external databases (e.g., `{"host": "localhost", "port": 54320, "user": "postgres", "password": "postgres", "dbname": "postgres"}`). Needed for Postgres and MySQL testing. If not provided, it defaults to the exact credentials matching the `docker-compose.yml` provided in the `lasso` repository.

**Outputs**:
A dictionary containing the comparison status and results.
- `status`: The evaluation result. Possible values:
  - `"EQ"`: The queries are identical string matches (execution is skipped).
  - `"EQ_EXEC"`: Both queries executed successfully and produced matching results.
  - `"NEQ"`: Queries produced different results under some configuration, no matching outputs across the rows.
  - `"NEQ_SCO"`: Queries produced matching results except for strict column ordering.
  - `"ERROR_QUERY_EXECUTION"`: One of the queries failed to execute (e.g., constraints).
  - `"ERROR_SYNTAX"`: One of the queries had a syntax error.
  - `"ERROR_SCHEMA_LOADING"`: Schema loading failed.
  - `"ERROR_DATASET_LOADING"`: Dataset loading failed.
- `reason` (if `NEQ`): A string explaining the discrepancy (e.g., `row_count_mismatch`, `column_count_mismatch`, `value_mismatch`).
- `gold_sql_result` & `prediction_sql_result`: The raw row tuples retrieved from executing each query.

## Key Capabilities

- **Multi-Dialect Support**: Supports executing queries natively in `sqlite`, `postgres`, and `mysql` environments.
- **Isolated Execution**: Runs queries safely in an in-memory SQLite database or external disposable database schemas (`execution_tester.py`).
- **AST Normalization (`query_normalizer.py`)**:
  - **Function Mocking**: Replaces temporal functions (`CURRENT_TIMESTAMP`, `NOW()`) with fixed deterministic values and evaluates/removes `RANDOM()`.
  - **Stable Sorting**: Augments ambiguous `ORDER BY` clauses natively into the AST to resolve sorting ties predictably.
  - **Dialect Transpilation**: Normalizes ASTs according to the specific database dialect to ensure execution natively handles dialect-specific nuances.
- **Flexible Equivalence**: 
  - Optional strict Python type matching for results.
  - Configurable column order matching (`strict_column_ordering`).
  - Option to allow extra columns in the generated query (`allow_extra_columns_in_q2`).
- **Integrity Checks**: Validates dataset loading constraints.
- **Execution Error Handling**: If one query errors out while the other succeeds, it flags the comparison as `"NEQ"`.
- **Comprehensive Test Suite**: Includes test cases (`tests/`) to validate query comparisons, AST rewriting, and edge cases.

## External Databases

`sql-execution-tester` intentionally operates without internal container orchestrations. To run Postgres or MySQL execution tests, you should manage your database environments externally.

If you are using this library as part of the `lasso` repository, you can launch the required test databases using the provided Docker Compose configuration in the root directory:

```bash
cd /path/to/lasso
docker compose up -d
```

This will spin up `postgres:15` (on port `54320`) and `mysql:8.0` (on port `33060`). Because `sql-execution-tester` is pre-configured with these default credentials, **it works right away out-of-the-box without needing to pass `db_config`**. You only need to pass `db_config` securely to `execution_test()` if you use your own custom database environments.

## Roadmap

- [x] **More Dialects**: PostgreSQL, MySQL support.
- [x] **Ignore Column Order**: Compare query outputs securely regardless of the order of the projected columns (via `strict_column_ordering=False`).
- [ ] **Advanced Comparisons**: Static semantic equivalence checks.
- [ ] **CLI**: Execute SQL files or directories directly.
