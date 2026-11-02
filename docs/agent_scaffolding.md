# Agent Scaffolding Prompt, Architecture & Design Philosophy

> **Source:** Adapted from Appendix A (*Agent Scaffolding Prompt*) and Section 3 (*LLM-Agent-Assisted Framework Development*) of the LASSO research paper.

This document records the foundational scaffolding prompt, core design tenets, and software engineering rules provided to the LLM agent to guide the construction, extension, and maintenance of LASSO.

---

## 1. Summarized Scaffolding Prompt

```text
You are implementing a research-grade SQL dataset synthesis framework for generating test datasets that kill non-equivalent mutants in SQL queries or wrong prediction queries from Text-to-SQL systems. 

Core Concepts: Mutations, Mutant Killing & Test Data Generation
- Mutation Query (Mutant): Errors in formulating SQL queries are modeled as mutations. A mutation of a reference query Q is a syntactically valid variant query Q' representing a potential semantic error (e.g., flipped comparison operators, join type alterations, omitted DISTINCT, or aggregate mismatches).
- Killing a Mutation: A test dataset D kills a mutation Q' if executing Q and Q' on D produces divergent outputs (Q(D) ≠ Q'(D)). If Q(D) = Q'(D), the mutant survives.
- Test Data Generation Workflow: Given a query Q and its schema, the system first constructs a base dataset producing non-empty results (Q(D) ≠ ∅, killing mutations that yield empty results), and then executes modular attack strategies to synthesize targeted datasets that systematically kill non-equivalent mutants.

Design Goals:
Prioritize semantic correctness, generalized reasoning, simplicity, readability, modular attacks, maintainability for LLM agents, and realistic dataset synthesis.

Architecture:
A parsing module that parses the input data into intermediate format. A base data generator that aims to generate dataset that will yield non-empty results on the given query.
Lightweight collection of independent attack strategies. Each attack should:
  (1) determine applicability from the parsed SQL AST to detect relevant structural patterns;
  (2) generate datasets that kill the targeted mutant.

Workflow:
  Parse SQL ──> Extract semantic info ──> Run applicable attacks ──> Generate datasets ──> Validate query behavior

Example Attack Strategies:
- NullHandlingAttackStrategy: Injects NULL values into nullable columns in IS NULL / IS NOT NULL checks to kill mutants that drop or invert null predicates.
- DistinctAttackStrategy: Synthesizes duplicate rows with identical projected values so that queries with DISTINCT collapse them while mutants without DISTINCT output duplicates.
- ComparisonAttackStrategy: Targets comparison boundaries (>, <, =, BETWEEN) by generating exact boundary values and offsets (V, V ± 1) to kill comparison operator mutants.

Testing Setup:
Test cases consist of a reference query, schema DDL, and expected semantic mutants that generated datasets must successfully kill.

Semantic Correctness:
Preserve correct SQL semantics (Three-Valued Logic, multiset semantics, deterministic sorting). Never simplify SQL semantics for implementation convenience.

Dataset Generation Principles:
Generate minimal and realistic test datasets rather than large random data. Satisfy schema constraints, kill only targeted mutants, and use Faker for realistic textual domains.

Imperative-First Implementation:
Prefer procedural construction of datasets and avoid full symbolic encoding in SMT; use Z3 selectively for localized arithmetic and multi-column constraints that are difficult to construct procedurally.

Implementation Guidelines:
Derive reasoning from parsed SQL ASTs, operate structurally rather than lexically, keep code readable for future extensions by LLM agents.
```

---

## 2. Framework Architecture & Modular Attack Design

LASSO structures the test data synthesis problem into modular, composable stages:

1. **Intermediate AST Representation (`src/parser.py`):**
   - Transpiles and parses input queries across diverse dialects (SQLite, PostgreSQL, MySQL) into normalized `sqlglot` expressions.
   - Extracts join conditions, filter trees, projection lists, grouping attributes, and window function expressions.

2. **Base Dataset Generator (`src/dataset_generator/`):**
   - Synthesizes an initial valid database instance $D_{\text{base}}$ satisfying all schema integrity constraints (PKs, FKs, NOT NULL, CHECK expressions) such that $Q(D_{\text{base}}) \neq \emptyset$.
   - Solves multi-column arithmetic and grouped aggregates using localized Z3 SMT instances under the uniform group assumption.

3. **Modular Attack Strategies (`src/attacks/`):**
   - 37 independent, single-purpose attack modules organized into targeted categories:
     - **Nulls & 3VL:** `null_attack.py`, `null_in_subquery_attack.py`, `nullable_join_attack.py`, `aggregate_null_attack.py`.
     - **Aggregates & Grouping:** `aggregate_attack.py`, `having_count_attack.py`, `group_by_attack.py`, `distinct_attack.py`, `duplicates_attack.py`.
     - **Joins & Cardinality:** `join_attack.py`, `left_join_attack.py`, `join_cardinality_attack.py`.
     - **Predicates & Boundaries:** `comparison_attack.py`, `datetime_function_attack.py`, `date_part_projection_attack.py`, `division_attack.py`.
     - **Subqueries & Limits:** `subquery_attack.py`, `subquery_limit_attack.py`, `subquery_attribute_attack.py`, `subquery_join_attack.py`.
     - **Window Functions:** `window_partition_attack.py`, `window_tie_attack.py`.
   - Each attack implements `is_applicable(ast)` to detect whether the query contains the vulnerable construct, and `generate_datasets(...)` to construct targeted counterexample databases.

4. **Multi-Dialect Execution Engine (`sql-execution-tester/`):**
   - Tests generated datasets on SQLite, Dockerized PostgreSQL, and MySQL.
   - Computes EX+ equivalence diagnostics, accounting for multiset equality, list ordering, and column permutations.

---

## 3. Engineering Guidelines for LLM Agents

- **Formal SQL Semantics:** Logic derives strictly from the parsed SQL AST structure and relational algebra. Never rely on lexical heuristics, column naming conventions, or hardcoded assumptions.
- **Deterministic Synthesis:** Random data generation is prohibited. Every value in synthesized datasets must be chosen with deliberate semantic intent.
- **Imperative-First over SMT:** Procedural dataset crafting is preferred for performance and readability. SMT solving (via Z3) is reserved for non-linear arithmetic, multi-column dependencies, and grouped sums that cannot be easily derived procedurally.
- **Independent Attack Roles:** Each strategy must target a distinct semantic bug category. Code should remain modular and concise so future agents can inspect and modify strategies in isolation without context degradation.

---

## 4. Human-Agent Interaction Example

Below is a summarized conversation log illustrating the iterative dialog between a human researcher and the LLM coding agent during benchmark expansion over the *XDataBM* suite (specifically adding support for `CHECK` constraints):

> **Human:**
> *"Lots of queries from XDATA_BM are failing due to violation of check constraints... Update lasso source code to support it. Suggest implementation plan first."*
>
> **Agent:**
> **Proposed Changes:**
> 1. Add `check_constraints` attribute to the `Table` model.
> 2. Enhance parser to extract `CHECK` constraints.
> 3. Integrate constraint satisfaction in `generate_base_dataset` using Z3 solvers.
>
> **Human:**
> *"How do you plan to handle `CHECK` constraints apart from enums? For example, `CHECK (LENGTH(Name) >= 3)`. If we rely on [Z3's string length solver], we won't be able to use realistic literals from faker. How can we still ensure the literals are realistic?"*
>
> **Agent:**
> *"Excellent point! If we ask Z3 to solve `Length >= 3`, it will return unreadable strings. I propose a Hybrid Generate-and-Test (Rejection Sampling) strategy: We ask Faker to generate a realistic candidate (e.g., `'John'`) and check if it satisfies the constraint. If it fails, we retry up to a limit."*
>
> **Human:**
> *"Can we customize the existing providers in faker to get string literals with specific length avoiding rejection sampling?"*
>
> **Agent:**
> *"Yes, absolutely! That's a brilliant insight and a much better approach. Instead of guessing and checking, we can extract Faker's internal dictionaries during initialization, group all words by their string length, and directly index into this dictionary. This completely avoids rejection loops, guarantees $O(1)$ performance, and ensures we get a realistic word."*
>
> **Human (After initial implementation):**
> *"When running LASSO on the XDataBM benchmark, I'm still getting a high number of `ERROR_DATASET_LOADING`. Investigate the causes, make reproducible test cases, and suggest fixes."*
>
> **Agent:**
> *"I have investigated and found three root causes:*
> 1. ***Case-Sensitivity:*** *Data generation was outputting double-quoted uppercase column names, clashing with PostgreSQL's default lowercase folding. I updated the synthesizer to explicitly lowercase identifiers.*
> 2. ***Numeric Precision:*** *Float generation created tiny fractions (e.g., `0.002`) that PostgreSQL rounded down to `0.00`, violating constraints like `budget > 0`. I adjusted the generator to use safely large floats.*
> 3. ***Varchar Lengths:*** *The string generator occasionally produced words exceeding strict `varchar(8)` limits. I added a fallback to generate a short random string using `random.choices` when the limit is exceeded."*
>
> **Human:**
> *"You should not use random data generation. Please follow the attack strategies rules strictly. It should be deterministic."*
>
> **Agent:**
> *"My apologies, you are absolutely right. I used `random.choices` as a quick shortcut. I have removed it and replaced it with a strictly deterministic algorithm that generates a base-26 string sequence directly tied to the global primary key counter."*
>
> **Human:**
> *"Identify the cause of the remaining `TOOL_ERROR` and `ERROR_DATASET_LOADING` and fix them."*
>
> **Agent:**
> *"The `TOOL_ERROR` was due to a scoping issue with the deterministic string cache, which I have fixed. The dataset loading errors were triggered by composite foreign keys propagating unconstrained strings; my updates to the dataset orchestrator now correctly resolve composite parent rows. The reproducible test cases now pass flawlessly and deterministically."*

