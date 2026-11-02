# Base Data Generation Pipeline Details

> **Source:** Adapted from Appendix B (*Base Data Generation Pipeline Details*) of the LASSO research paper.

This document provides a comprehensive, sub-step specification for the core phases of LASSO's base data generation pipeline. The goal of the base data generator is: given an input SQL query $Q$ and its relational database schema DDL $\mathcal{S}$, construct an initial valid, deterministic, non-empty database instance $D_{\text{base}}$ such that $Q(D_{\text{base}}) \neq \emptyset$.

---

## 1. Pipeline Overview

The base data generation pipeline proceeds through four coordinated phases:

```
Schema DDL & Query SQL
        │
        ▼
[ Phase 1: Equivalence Class Construction ]
        │  • Union-Find join & FK unification
        │  • Referential graph DAG traversal
        ▼
[ Phase 2: Constraint Collection & Cardinality Analysis ]
        │  • Single-pass AST extraction into ColumnSpec
        │  • Multi-column arithmetic solving via Z3 SMT
        │  • Group aggregate modeling (uniform group assumption)
        │  • Cardinality lower-bound computation (K_min)
        ▼
[ Phase 3: Column-Centric Value Resolution ]
        │  • Hierarchical seed selection
        │  • Programmatic single-column CHECK validation & repair
        │  • Padding, distinctness & subquery spread
        ▼
[ Phase 4: Row Assembly & Multi-Column CHECK Repair ]
        │  • Foreign-key & group alignment
        │  • Row materialization
        │  • Partial-row context CHECK repair
        │  • Intra-table deduplication
        ▼
Valid Base Dataset (Q(D_base) ≠ ∅)
```

---

## 2. Structure of `ColumnSpec`

In Phase 2, all column types, schema rules, and query filters are consolidated into a single `ColumnSpec` record per equivalence class root. This avoids re-parsing the query during subsequent value synthesis.

| Field | Type | Source / Populating Condition |
| :--- | :--- | :--- |
| `required` | `List[Any]` | Literals from equality (`col = 'A'`), `IN ('A','B')`, `LIKE` match values, Z3 model values, or attack strategy injections. |
| `lower` | `Numeric / Date` | Strictest lower bound from `col > X` or `col >= Y`. |
| `upper` | `Numeric / Date` | Strictest upper bound from `col < X` or `col <= Y`. |
| `disallowed` | `Set[Any]` | Excluded values from negative predicates (`col != X` or `NOT IN (...)`). |
| `must_be_unique` | `Boolean` | `PRIMARY KEY`, `UNIQUE` (schema), or `COUNT(DISTINCT col)` (query). |
| `is_group_key` | `Boolean` | Flagged if column appears in `GROUP BY`. |
| `is_subquery` | `Boolean` | Flagged if column participates in a subquery predicate. |
| `is_avg_subquery_col` | `Boolean` | Compared via inequality against an `AVG(...)` subquery. |
| `char_limit` | `Int / None` | Minimum `VARCHAR(N)` length declared across the equivalence class. |
| `check_exprs` | `List[Expr]` | `CHECK` constraint AST expressions parsed from schema DDL. |
| `column` | `Column` | Reference to schema `Column` metadata object. |
| `data_type` | `String` | DDL data type (e.g., `INT`, `VARCHAR(50)`, `DATE`, `DECIMAL(10,2)`). |
| `table_name` | `String` | Resolved schema table name (used for contextual CHECK repair). |
| `force_null` | `Boolean` | External override forcing all resolved values to `NULL`. |

---

## 3. Phase 1: Equivalence Class Construction

To guarantee relational consistency across joins, foreign keys, and set operations without fragile post-hoc patching, the pipeline identifies column references using canonical keys:
$$\mathrm{key}(\textit{alias\_or\_table},\, \textit{column})$$

A disjoint-set structure (`UnionFind`) partitions column references into equivalence classes induced by five structural sources:

1. **JOIN ON Equalities:** Explicit join predicates (e.g., `A.id = B.a_id`) unify the corresponding column keys.
2. **Implicit WHERE Equalities:** Equi-join predicates in `WHERE` clauses comparing two columns (e.g., `WHERE a.id = b.a_id`) are unified identically.
3. **Schema Foreign Keys:** For every DDL foreign-key constraint $T_1.C_1 \to T_2.C_2$, the child and parent columns are unified.
4. **Query Alias Identity:** For every query alias $A$ referring to base table $T$, $\mathrm{key}(A, C)$ is unified with $\mathrm{key}(T, C)$ for every column $C \in T$, ensuring alias-qualified and table-qualified references resolve to the same root.
5. **Set-Operation Alignment:** In `UNION`, `INTERSECT`, and `EXCEPT` queries, the $i$-th projected column of the left `SELECT` branch is positionally unified with the $i$-th projected column of the right `SELECT` branch.

### Graph Traversal & Symbol Caching
- **Referential Integrity Expansion:** The pipeline discovers all target tables referenced in the query and recursively traverses the schema's foreign-key DAG to include unreferenced parent tables, ensuring parent rows are synthesized to satisfy referential integrity.
- **Symbol Table Cache:** A symbol table cache is populated to map each query-level column reference $(\textit{alias}, \textit{column})$ directly to its underlying schema table and column definition in $O(1)$ time.

---

## 4. Phase 2: Constraint Collection & Cardinality Analysis

In a single pass over the schema DDL and parsed query AST, the pipeline builds a `ColumnSpec` for each equivalence class root and computes the minimum table row count $\mathcal{K}_{\min}$.

### Multi-Column Arithmetic Solving via Z3 SMT

Predicates on a single column (e.g., `WHERE age > 25`) are handled directly by interval bounds in `ColumnSpec`. However, conditions with arithmetic across multiple columns (e.g., `WHERE a.price * 1.1 > b.cap + 500`) cannot be solved column-by-column because the valid value for one column depends on the other.

When arithmetic operators ($+, -, \times, /, \%$) appear in `WHERE`, `HAVING`, or `JOIN ON` clauses, the expressions are translated into Z3 constraints:

1. **Typed Variables:** Each referenced column is mapped to a typed Z3 variable (`z3.Int`, `z3.Real`, or `z3.String`) matching its DDL data type.
2. **AST-to-SMT Translation:** The pipeline recursively walks expression ASTs. Column references link to typed variables, numeric literals to integer/real constants, and string literals to string constants. SQL boolean connectives (`AND`, `OR`, `NOT`), comparisons ($=, \neq, <, \le, >, \ge$), range checks (`BETWEEN a AND b` $\to x \ge a \land x \le b$), and list memberships (`IN (v1, v2)` $\to x = v_1 \lor x = v_2$) map directly to Z3 operators. For division operators, non-zero denominator constraints ($denominator > 0$) are asserted to avoid runtime zero-division errors.
3. **Uniform Group Aggregate Modeling:** SMT solvers cannot easily represent dynamic multi-row tables. Instead, grouped rows are modeled under a **uniform group assumption**: all rows in a group are assumed to share identical column values. This simplifies multi-row aggregates into closed-form arithmetic using an auxiliary integer variable $\texttt{ROW\_COUNT} \ge 1$ representing group size:
   - **`COUNT(*)` / `COUNT(col)`:** Maps directly to `ROW_COUNT`.  
     *Example:* `HAVING COUNT(*) >= 4` $\to \texttt{ROW\_COUNT} \ge 4$.
   - **`SUM(col)`:** Multiplies the column expression by `ROW_COUNT`. When a column is bounded by row-level filters (e.g., `WHERE bonus <= 500` alongside `HAVING SUM(bonus) > 2000`), a single row cannot satisfy the sum; the solver jointly solves $(\mathit{bonus} \le 500) \land (\mathit{bonus} \times \texttt{ROW\_COUNT} > 2000)$ to find both a valid column value ($\mathit{bonus} = 500$) and the minimum row count ($\texttt{ROW\_COUNT} \ge 5$).
   - **Point Aggregates (`AVG`, `MIN`, `MAX`):** Under the uniform group assumption, the mean, minimum, and maximum equal the expression itself.  
     *Example:* `HAVING AVG(salary) > 50000` $\to \mathit{salary} > 50000$.
   - **Scalar Subqueries:** When comparing a column against a scalar subquery (e.g., `budget > (SELECT SUM(cost) FROM expenses WHERE type = 1)`), the subquery's internal filter ($\mathit{type} = 1$) is asserted to the solver, and its projected aggregate ($\mathit{cost} \times \texttt{ROW\_COUNT}$) is substituted into the outer comparison: $\mathit{budget} > \mathit{cost} \times \texttt{ROW\_COUNT}$.
4. **Model Extraction:** Satisfying values extracted from the Z3 model are stored into $\texttt{spec.required}$ for their respective column equivalence classes, and the solved `ROW_COUNT` establishes the cardinality lower bound $\mathcal{K}_{\text{Z3}}$.

#### Concrete Example: SQL-to-SMT Solving

**Input SQL Query:**
```sql
SELECT e.dept_id, AVG(e.salary)
FROM employees e JOIN departments d ON e.dept_id = d.id
WHERE e.salary * 1.1 > d.budget_cap + 500
GROUP BY e.dept_id
HAVING SUM(e.bonus) > 2000 AND COUNT(*) >= 3;
```

**Translated Z3 Formulation:**
```python
from z3 import Real, Int, Solver, sat

E_SALARY     = Real("E_SALARY")
D_BUDGET_CAP = Real("D_BUDGET_CAP")
E_BONUS      = Real("E_BONUS")
ROW_COUNT    = Int("ROW_COUNT")

s = Solver()
s.add(ROW_COUNT >= 1)
# WHERE clause: multi-column arithmetic
s.add(E_SALARY * 1.1 > D_BUDGET_CAP + 500.0)
# HAVING clause: uniform group aggregate translation
s.add(E_BONUS * ROW_COUNT > 2000.0)
s.add(ROW_COUNT >= 3)
```

**Extracted Z3 Model:**
```python
# Solver Status: SAT
ROW_COUNT    = 4
E_SALARY     = 0.90909
E_BONUS      = 501.0
D_BUDGET_CAP = -500.0
```

The pipeline seeds $\texttt{spec}(\texttt{employees.salary}).\texttt{required} \gets [0.90909]$, $\texttt{spec}(\texttt{employees.bonus}).\texttt{required} \gets [501.0]$, $\texttt{spec}(\texttt{departments.budget\_cap}).\texttt{required} \gets [-500.0]$, and assigns $\mathcal{K}_{\text{Z3}} = 4$. Synthesizing 4 rows for `employees` sharing foreign key `dept_id = 1005` strictly satisfies all WHERE and HAVING conditions, returning the non-empty output `[(1005, 0.90909)]`.

### Cardinality Lower-Bound Computation

LASSO analyzes five structural features to determine the required row count $\mathcal{K}_{\min}$:
- $\mathcal{K}_{\text{Z3}}$: Solved `ROW_COUNT` from the Z3 model.
- $\mathcal{K}_{\text{HAVING}}$: Derived from `HAVING COUNT` predicates (`COUNT(*) > N` $\to N+1$, `COUNT(*) >= N` $\to N$).
- $\mathcal{K}_{\text{LIMIT/OFFSET}}$: Computed from `LIMIT M` and `OFFSET K` as $K + \min(M, 10) + 3$ (or $K+5$ if only `OFFSET` is present).
- $\mathcal{K}_{\text{Subquery}}$: Set to $\ge 3$ rows for subquery comparisons (e.g., `col > (SELECT AVG(...))`) to guarantee rows exist both above and below the aggregate.
- $\mathcal{K}_{\text{Injections}}$: Maximum length of value lists injected by attack strategies.

$$\mathcal{K}_{\min} = \max \big( 1, \; \mathcal{K}_{\text{Z3}}, \; \mathcal{K}_{\text{HAVING}}, \; \mathcal{K}_{\text{LIMIT/OFFSET}}, \; \mathcal{K}_{\text{Subquery}}, \; \mathcal{K}_{\text{Injections}} \big)$$

### Table-Level Cardinality Optimization
Tables not involved in any `COUNT` expression (and not joined to counting tables) need only 1 row to keep generated datasets minimal. Tables with multi-valued `IN` lists expand to $\max(\text{table\_row\_count}, |\text{spec.required}|)$.

---

## 5. Phase 3: Column-Centric Value Resolution

For each equivalence class root, the value resolver produces a list of exactly `count` concrete scalar values that strictly satisfy all constraints in the corresponding `ColumnSpec` via five sequential steps:

### Step 1: Seed Selection (Hierarchical Priority)
Evaluates constraint priority in strict hierarchical order:
1. **Null override:** If `force_null` is active, returns `count` copies of `NULL`.
2. **Explicit literals:** If `required` values exist (from equality, `IN` lists, `LIKE` patterns, Z3 models, or attack injections), returns them directly.
3. **Bounded interval:** If both `lower` and `upper` bounds exist, selects midpoint $\frac{lower + upper}{2}$.
4. **Lower bound only:** Steps strictly above ($lower + 1.0$ or $+1\text{ day}$).
5. **Upper bound only:** Steps strictly below ($upper - 1.0$ or $-1\text{ day}$).
6. **Disallowed exclusions:** When negative predicates ($\neq$, `NOT IN`, `IS NOT NULL`) define an exclusion set $\mathcal{S}_{\text{disallowed}}$:
   - *Candidate Generation:* Synthesizes a typed candidate $v$ (using Faker for text or monotonic counters for numeric/temporal types). If $v \notin \mathcal{S}_{\text{disallowed}}$ and satisfies schema rules, it is selected immediately.
   - *CHECK-Guided Domain Search:* If schema `CHECK` constraints apply, searches the domain: (i) iterates allowed `IN` literals; (ii) tests stepped offsets ($\Delta \in \{0, \pm 1, \pm 5, \dots\}$) around $v$ or constants in the AST; (iii) adjusts string length.
   - *Iterative Perturbation:* Appends distinct suffixes for strings or increments numbers until $v \notin \mathcal{S}_{\text{disallowed}}$.
7. **Unconstrained columns:** Synthesizes schema-appropriate fresh defaults:
   - *Textual (`VARCHAR`, `TEXT`):* Realistic strings via context-isolated Faker instances bounded by declared length limits, falling back to base-26 alphabetic encoding of a monotonic counter upon uniqueness exhaustion.
   - *Temporal (`DATE`, `TIMESTAMP`):* Deterministic ISO-8601 calendar dates derived from monotonic ordinal day offsets from a fixed epoch.
   - *Numeric and Identifiers (`INT`, `DECIMAL`):* Monotonic sequential counter (`pk_counter`), with floating-point values scaled modulo precision-scale ($10^{p-s}-1$) and offset fractionally ($+0.5$).

### Step 2: Single-Column CHECK Validation
Evaluates seed values against single-column `CHECK` ASTs in Python. Violations are repaired programmatically without solver overhead:
- `IN` enums: iterates allowed literals until valid.
- Numeric checks: stepped deltas ($\Delta \in \{0, \pm 1, \pm 5, \dots\}$) or offsets around AST constants.
- String length: pads or truncates strings to valid lengths.

### Step 3: Padding and Strategic Divergence
If the seed list is shorter than `count`, additional values are appended according to column flags:
- `must_be_unique`: Appends distinct values using deterministic offset generation.
- `required` non-empty: Cycles through required literals ($values[k \bmod |required|]$).
- Bounded range: Increments preceding value ($val + 1$ or $+1\text{ day}$), wrapping back to initial seed $values[0]$ if upper bound is exceeded.
- `is_group_key`: Replicates $values[0]$ across all rows to form uniform groups.
- Unconstrained columns: Appends distinct values parameterized by column index ($col\_idx$) to prevent accidental cross-column value collisions.

### Step 4: Uniqueness Enforcement
For `must_be_unique` columns (`PRIMARY KEY`, `UNIQUE`, `COUNT(DISTINCT)`), a deduplication pass filters out duplicate values and re-pads the list to `count` with fresh distinct values.

### Step 5: Subquery Value Spread
If `is_avg_subquery_col` is flagged on a numeric column (and it is neither unique nor a group key), the first value is offset ($values[0] \gets values[0] + 10$), intentionally pulling it away from the group average to guarantee values exist on both sides of the mean, exposing inequality boundary mutations ($>$ vs $\ge$).

---

## 6. Phase 4: Row Assembly & Multi-Column CHECK Repair

Once value lists are resolved per equivalence class, concrete table row dictionaries are assembled through four coordinated steps:

1. **Foreign-Key & Group Alignment:** Child table foreign-key and group-key columns replicate their first resolved value across all rows in that table. This guarantees that all synthesized child rows point to the exact same parent record and form uniform `GROUP BY` groups.
2. **Row Materialization:** For each row index $i$, column values are assigned from their resolved value list ($values[i]$). Nullable foreign keys to tables omitted by attack strategies and explicit null injections are set to `NULL`.
3. **Multi-Column CHECK Repair:** Multi-column `CHECK` constraints (e.g., `CHECK (end_date >= start_date)`) cannot be evaluated during single-column value generation. During row assembly, partial row context (values assigned to earlier columns in the same row) is substituted into the constraint AST and evaluated in Python. If violated, LASSO dynamically repairs the value relative to the assigned context (e.g., shifting dates by $+1\text{ day}$ relative to `start_date`, adjusting numeric offsets $\pm 1$, or selecting valid enum literals).
4. **Intra-Table Deduplication:** Each synthesized row is validated against previously assembled rows in the table to prevent primary key or unique constraint collisions.
