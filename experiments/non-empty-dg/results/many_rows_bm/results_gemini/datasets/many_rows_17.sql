INSERT INTO categories (category_id, category_name, department) VALUES (1, 'Electronics', 'ELECTRONICS');
INSERT INTO customers (customer_id, customer_name, country, tier, credit_limit) VALUES (1, 'John Doe', 'USA', 'GOLD', 1000.00);
INSERT INTO products (product_id, category_id, product_name, price, stock_quantity) VALUES (1, 1, 'Gadget', 10.00, 100000);
INSERT INTO orders (order_id, customer_id, order_date, order_status, total_amount)
WITH RECURSIVE digits(d) AS (
    SELECT 0 UNION ALL SELECT d + 1 FROM digits WHERE d < 9
),
nums(n) AS (
    SELECT d1.d + d2.d * 10 + d3.d * 100 + d4.d * 1000 + d5.d * 10000 + 1
    FROM digits d1
    CROSS JOIN digits d2
    CROSS JOIN digits d3
    CROSS JOIN digits d4
    CROSS JOIN digits d5
    WHERE d1.d + d2.d * 10 + d3.d * 100 + d4.d * 1000 + d5.d * 10000 + 1 <= 12005
)
SELECT n, 1, '2023-01-01', 'PAID', 10.00 FROM nums;
INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, discount)
WITH RECURSIVE digits(d) AS (
    SELECT 0 UNION ALL SELECT d + 1 FROM digits WHERE d < 9
),
nums(n) AS (
    SELECT d1.d + d2.d * 10 + d3.d * 100 + d4.d * 1000 + d5.d * 10000 + 1
    FROM digits d1
    CROSS JOIN digits d2
    CROSS JOIN digits d3
    CROSS JOIN digits d4
    CROSS JOIN digits d5
    WHERE d1.d + d2.d * 10 + d3.d * 100 + d4.d * 1000 + d5.d * 10000 + 1 <= 12005
)
SELECT n, n, 1, 1, 10.00, 0.10 FROM nums;
