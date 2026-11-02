# MM-BM: Multi-Mutant Relational Benchmark Suite

## Overview

`MM-BM` (Multi-Mutant Benchmark) is a relational test data generation benchmark suite designed to evaluate test data generation and mutant refutation engines (such as LASSO, ParSEval, and Gemini-TDG) on complex queries with high mutant density.

The suite comprises 3 rich queries and 75 genuine, non-equivalent semantic mutants.

---

## File Structure

- `schema.sql`: Complete relational schema definition (departments, employees, projects, assignments, tasks, customers, orders, categories, products, order_items, reviews).
- `queries.txt`: Format: `q_id|query_name|gold_sql`
- `mutants.txt`: Format: `q_id|mutant_tag|mutant_sql`
