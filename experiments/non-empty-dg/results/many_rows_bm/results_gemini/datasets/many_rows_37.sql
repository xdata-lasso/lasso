INSERT INTO customers (customer_id, customer_name, country, tier, credit_limit)
VALUES (1, 'Customer 1', 'USA', 'GOLD', 10000.00);
INSERT INTO orders (order_id, customer_id, order_date, order_status, total_amount)
WITH RECURSIVE seq(n) AS (
  SELECT 1
  UNION ALL
  SELECT n + 1 FROM seq WHERE n < 1000
)
SELECT n, 1, '2023-01-01', 'DELIVERED', 50.00 FROM seq;
INSERT INTO shipments (shipment_id, order_id, carrier, tracking_status, delivery_days)
WITH RECURSIVE seq(n) AS (
  SELECT 1
  UNION ALL
  SELECT n + 1 FROM seq WHERE n < 1000
)
SELECT n, n, 'FEDEX', 'DELIVERED', 3 FROM seq;
