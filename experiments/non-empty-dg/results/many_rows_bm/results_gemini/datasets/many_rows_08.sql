INSERT INTO customers (customer_id, customer_name, country, tier, credit_limit) 
VALUES (1, 'Alice Smith', 'USA', 'GOLD', 50000.00);
INSERT INTO categories (category_id, category_name, department) 
VALUES (1, 'Electronics', 'ELECTRONICS');
INSERT INTO orders (order_id, customer_id, order_date, order_status, total_amount) 
VALUES (1, 1, '2023-10-01', 'PAID', 20000.00);
INSERT INTO products (product_id, category_id, product_name, price, stock_quantity)
WITH RECURSIVE tens(t) AS (
    SELECT 0 UNION ALL SELECT t + 1 FROM tens WHERE t < 9
),
numbers(n) AS (
    SELECT a.t * 100 + b.t * 10 + c.t + 1
    FROM tens a CROSS JOIN tens b CROSS JOIN tens c
)
SELECT n, 1, 'Product ' || n, 10.00, 100 FROM numbers;
INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, discount)
WITH RECURSIVE tens(t) AS (
    SELECT 0 UNION ALL SELECT t + 1 FROM tens WHERE t < 9
),
numbers(n) AS (
    SELECT a.t * 100 + b.t * 10 + c.t + 1
    FROM tens a CROSS JOIN tens b CROSS JOIN tens c
)
SELECT n, 1, n, 2, 10.00, 0.10 FROM numbers;
