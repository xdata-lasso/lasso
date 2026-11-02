INSERT INTO categories (category_id, category_name, department) 
VALUES (1, 'Electronics', 'ELECTRONICS');
INSERT INTO customers (customer_id, customer_name, country, tier, credit_limit) 
VALUES (1, 'Alice', 'USA', 'GOLD', 500000.00);
INSERT INTO orders (order_id, customer_id, order_date, order_status, total_amount) 
VALUES (1, 1, '2023-01-01', 'PAID', 1000000.00);
INSERT INTO products (product_id, category_id, product_name, price, stock_quantity)
WITH digits AS (
    SELECT 0 AS d UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
    UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
),
nums AS (
    SELECT (d1.d + d2.d * 10 + d3.d * 100 + d4.d * 1000 + d5.d * 10000 + 1) AS n
    FROM digits d1
    CROSS JOIN digits d2
    CROSS JOIN digits d3
    CROSS JOIN digits d4
    CROSS JOIN (SELECT 0 AS d UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4) d5
)
SELECT n, 1, 'Product ' || n, 10.0, 100
FROM nums;
INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, discount)
WITH digits AS (
    SELECT 0 AS d UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
    UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
),
nums AS (
    SELECT (d1.d + d2.d * 10 + d3.d * 100 + d4.d * 1000 + d5.d * 10000 + 1) AS n
    FROM digits d1
    CROSS JOIN digits d2
    CROSS JOIN digits d3
    CROSS JOIN digits d4
    CROSS JOIN (SELECT 0 AS d UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4) d5
)
SELECT n, 1, n, 2, 10.0, 0.0
FROM nums;
