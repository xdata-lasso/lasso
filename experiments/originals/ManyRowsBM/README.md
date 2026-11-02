# ManyRowsBM: Multi-Tier High-Cardinality Relational Benchmark Suite

## Overview

`ManyRowsBM` is a relational test data generation benchmark suite designed to evaluate test data generation engines (such as LASSO, ParSEval, XData, and LLM-based generators like Gemini) on queries that **implicitly or explicitly require a large number of rows** (from $10^3$ to $10^5$ rows) to produce a non-empty result set.

Rather than relying solely on explicit `COUNT(*) >= N` or `OFFSET N` predicates, `ManyRowsBM` tests diverse algebraic, aggregate, window, and relational schema constraint interactions that mathematically force high dataset cardinality:
- **Bounded Sum and Max (`SUM(x) > S AND MAX(x) <= M`)**: Forces at least $\lfloor S/M \rfloor + 1$ rows per group.
- **Row-Level / Schema `CHECK` Upper Bounds with High `SUM`**: E.g., `CHECK (discount <= 1.0)` or `WHERE duration_seconds <= 10` paired with `HAVING SUM(...) >= S`.
- **Scale-Free Multiplicative Ratios (`SUM(x) >= K * MAX(x)`)**: For $x > 0$, $\sum_{i=1}^n x_i \le n \cdot \max_i x_i$, forcing $n \ge K$ rows regardless of numeric scale.
- **Sum-Minus-Max Gap (`SUM(x) - MAX(x) >= S AND MAX(x) <= M`)**: Forces $n \ge \lceil S/M \rceil + 1$ rows.
- **Average Skew Levers (`MIN(x)`, `MAX(x)`, `AVG(x)`)**: Combines an extreme outlier with a tight average bound near the opposite bound, requiring thousands of rows to balance the lever.
- **Unique & Foreign Key Cascades**: Combines high-cardinality child groups with `UNIQUE(customer_name)`, `UNIQUE(product_name)`, `shipments.order_id UNIQUE`, `UNIQUE(order_id, product_id)`, `UNIQUE(customer_id, event_seq)`, `UNIQUE(device_id, metric_name, reading_seq)`, and `UNIQUE(product_id, log_seq)` to force cascading multi-table row generation.
- **Window Cumulative Sums, Deep `LAG` Offsets, and `DENSE_RANK`**: Requires deep partitions via `SUM(x) OVER (...)` with bounded step $x$, `LAG(col, N) OVER (...) IS NOT NULL`, and `DENSE_RANK() OVER (...) >= N`.
- **Two-Stage Hierarchical CTE Multiplication & Correlated Subquery Barriers**: Multiplies per-group row requirements across multiple aggregation stages.

---

## Semantic Complexity Tiers

The suite comprises 54 relational queries (`many_rows_01` – `many_rows_30` original queries plus `many_rows_31` – `many_rows_54` newly added algebraic/constraint-driven queries) structured across three semantic difficulty tiers:

1. **Simple Tier (17 queries: `many_rows_01` – `many_rows_10`, `many_rows_31` – `many_rows_37`, ~1,000 – 2,000 rows)**:
   - Single-table and two-table queries using `COUNT(*)`, `COUNT(DISTINCT)`, `OFFSET`, `SUM > S AND MAX <= M`, row-level upper bounds with `SUM`, schema `CHECK (discount <= 1.0)` with `SUM` and `UNIQUE(order_id, product_id)`, scale-free `SUM >= K * MAX`, `MIN`/`MAX`/`AVG` skew levers, and 1-to-1 `UNIQUE` FK fan-out.

2. **Medium Tier (19 queries: `many_rows_11` – `many_rows_20`, `many_rows_38` – `many_rows_46`, ~5,000 – 20,000 rows)**:
   - Multi-table joins across 2–3 relational tables combining `COUNT(*)`, `OFFSET`, `SUM`/`MAX` bounds, arithmetic product sums (`SUM(quantity * unit_price)`), `SUM - MAX` gaps, outlier-to-average levers, and composite `UNIQUE` foreign-key cascades.

3. **Complex Tier (18 queries: `many_rows_21` – `many_rows_30`, `many_rows_47` – `many_rows_54`, ~25,000 – 150,000 rows)**:
   - Analytic window functions (`ROW_NUMBER()`, `DENSE_RANK()`, `SUM(...) OVER` with bounded step, `LAG(..., 25000) IS NOT NULL`), two-stage hierarchical CTE group multiplication, correlated `COUNT`/`SUM`/`MAX` subqueries, extreme average skew levers, and deep multi-table pagination.

---

## Schema Architecture (`schema.sql`)

The schema models an enterprise e-commerce, logistics, and IoT telemetry platform with 9 normalized relational tables:
1. **`customers`**: Customer master table with `UNIQUE(customer_name)`, country, tier, and credit limit.
2. **`categories`**: Product categories with `UNIQUE(category_name)` categorized by department.
3. **`products`**: Product catalog linked to categories with `UNIQUE(product_name)`, pricing (`CHECK (price > 0)`), and inventory.
4. **`orders`**: Customer orders with status and total amount.
5. **`order_items`**: Order line items linking orders and products with quantities, unit prices, discounts (`CHECK (discount >= 0 AND discount <= 1.0)`), and `UNIQUE(order_id, product_id)`.
6. **`shipments`**: Order shipments with `UNIQUE(order_id)` tracking carrier and delivery duration.
7. **`customer_events`**: Online user session activity and event streams with `UNIQUE(customer_id, event_seq)`.
8. **`sensor_telemetry`**: Multi-device sensor telemetry measurements with `UNIQUE(device_id, metric_name, reading_seq)`.
9. **`inventory_logs`**: Inventory adjustment and restock logs with `UNIQUE(product_id, log_seq)`.

All tables, foreign keys, and domain constraints are fully compatible with SQLite, PostgreSQL, and MySQL.
