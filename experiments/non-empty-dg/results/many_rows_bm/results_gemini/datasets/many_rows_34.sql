INSERT INTO categories (category_id, category_name, department) 
VALUES (1, 'Electronics Cat', 'ELECTRONICS');
INSERT INTO customers (customer_id, customer_name, country, tier, credit_limit) 
VALUES (1, 'Customer 1', 'USA', 'GOLD', 100000.0);
INSERT INTO orders (order_id, customer_id, order_date, order_status, total_amount) 
VALUES (1, 1, '2023-01-01', 'PAID', 10000.0);
INSERT INTO products (product_id, category_id, product_name, price, stock_quantity)
WITH RECURSIVE seq(n) AS (
    SELECT 1
    UNION ALL
    SELECT n + 1 FROM seq WHERE n < 1000
)
SELECT n, 1, 'Product ' || n, 10.00, 50 FROM seq;
INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, discount)
WITH RECURSIVE seq(n) AS (
    SELECT 1
    UNION ALL
    SELECT n + 1 FROM seq WHERE n < 1000
)
SELECT n, 1, n, 1, 10.00, 1.00 FROM seq;
