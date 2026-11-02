INSERT INTO categories (category_id, category_name, department) 
VALUES (1, 'Electronics', 'ELECTRONICS');
INSERT INTO customers (customer_id, customer_name, country, tier, credit_limit) 
VALUES (1, 'Customer 1', 'USA', 'GOLD', 50000.00);
INSERT INTO products (product_id, category_id, product_name, price, stock_quantity)
WITH d(n) AS (
    SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 
    UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
),
d5(n) AS (
    SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
)
SELECT 
    d5.n * 1000 + d3.n * 100 + d2.n * 10 + d1.n + 1,
    1,
    'Product ' || (d5.n * 1000 + d3.n * 100 + d2.n * 10 + d1.n + 1),
    10.00,
    100
FROM d5 
CROSS JOIN d AS d3 
CROSS JOIN d AS d2 
CROSS JOIN d AS d1;
INSERT INTO orders (order_id, customer_id, order_date, order_status, total_amount) 
VALUES (1, 1, '2023-01-01', 'PAID', 50000.00);
INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, discount)
WITH d(n) AS (
    SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 
    UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
),
d5(n) AS (
    SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
)
SELECT 
    d5.n * 1000 + d3.n * 100 + d2.n * 10 + d1.n + 1,
    1,
    d5.n * 1000 + d3.n * 100 + d2.n * 10 + d1.n + 1,
    1,
    10.00,
    0.00
FROM d5 
CROSS JOIN d AS d3 
CROSS JOIN d AS d2 
CROSS JOIN d AS d1;
