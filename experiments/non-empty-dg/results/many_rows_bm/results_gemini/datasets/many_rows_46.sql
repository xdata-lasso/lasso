INSERT INTO customers (customer_id, customer_name, country, tier, credit_limit) 
VALUES (1, 'Alice Smith', 'USA', 'GOLD', 100000.00);
INSERT INTO categories (category_id, category_name, department) 
VALUES (1, 'Electronics', 'ELECTRONICS');
INSERT INTO orders (order_id, customer_id, order_date, order_status, total_amount) 
VALUES (1, 1, '2023-01-01', 'PAID', 100000.00);
INSERT INTO products (product_id, category_id, product_name, price, stock_quantity)
WITH digits(d) AS (
  SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
  UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
),
numbers(n) AS (
  SELECT d1.d + d2.d*10 + d3.d*100 + d4.d*1000 + 1
  FROM digits d1, digits d2, digits d3, digits d4
)
SELECT n, 1, 'Product ' || n, 10.00, 100 FROM numbers;
INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, discount)
WITH digits(d) AS (
  SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
  UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
),
numbers(n) AS (
  SELECT d1.d + d2.d*10 + d3.d*100 + d4.d*1000 + 1
  FROM digits d1, digits d2, digits d3, digits d4
)
SELECT n, 1, n, 1, 10.00, 0.75 FROM numbers;
