INSERT INTO customers (customer_id, customer_name, country, tier, credit_limit)
VALUES (1, 'Alice', 'USA', 'GOLD', 1000.00);
INSERT INTO categories (category_id, category_name, department)
VALUES (1, 'Electronics', 'ELECTRONICS');
INSERT INTO products (product_id, category_id, product_name, price, stock_quantity)
VALUES (1, 1, 'Laptop', 100.00, 50);
INSERT INTO orders (order_id, customer_id, order_date, order_status, total_amount)
WITH
  d(n) AS (
    SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
    UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
  ),
  nums(i) AS (
    SELECT 1 + a.n + b.n * 10 + c.n * 100 + d.n * 1000 + e.n * 10000 + f.n * 100000
    FROM d a, d b, d c, d d, d e, (SELECT 0 UNION ALL SELECT 1) f
    WHERE 1 + a.n + b.n * 10 + c.n * 100 + d.n * 1000 + e.n * 10000 + f.n * 100000 <= 100005
  )
SELECT i, 1, '2023-01-01', 'PAID', 100.00 FROM nums;
INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, discount)
WITH
  d(n) AS (
    SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
    UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
  ),
  nums(i) AS (
    SELECT 1 + a.n + b.n * 10 + c.n * 100 + d.n * 1000 + e.n * 10000 + f.n * 100000
    FROM d a, d b, d c, d d, d e, (SELECT 0 UNION ALL SELECT 1) f
    WHERE 1 + a.n + b.n * 10 + c.n * 100 + d.n * 1000 + e.n * 10000 + f.n * 100000 <= 100005
  )
SELECT i, i, 1, 1, 100.00, 0.0 FROM nums;
