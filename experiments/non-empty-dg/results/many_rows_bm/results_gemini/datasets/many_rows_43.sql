INSERT INTO customers (customer_id, customer_name, country, tier, credit_limit) 
VALUES (1, 'Alice Smith', 'USA', 'GOLD', 100000.00);
INSERT INTO orders (order_id, customer_id, order_date, order_status, total_amount)
WITH RECURSIVE cnt(x) AS (
  SELECT 0
  UNION ALL
  SELECT x + 1 FROM cnt WHERE x < 99
)
SELECT a.x * 100 + b.x + 1, 1, '2023-01-01', 'PAID', 10.0
FROM cnt a CROSS JOIN cnt b;
INSERT INTO orders (order_id, customer_id, order_date, order_status, total_amount) 
VALUES (10001, 1, '2023-01-02', 'PAID', 50000.00);
