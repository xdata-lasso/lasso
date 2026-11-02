INSERT INTO customers (customer_id, customer_name, country, tier, credit_limit) 
VALUES (1, 'Acme Corp', 'USA', 'PLATINUM', 50000.00);
INSERT INTO orders (order_id, customer_id, order_date, order_status, total_amount)
WITH d10(d) AS (VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9)),
seq(n) AS (
  SELECT a.d + b.d*10 + c.d*100 + d.d*1000 + e.d*10000 + 1
  FROM d10 a, d10 b, d10 c, d10 d, d10 e
  LIMIT 50000
)
SELECT n, 1, '2023-01-01', 'DELIVERED', 100.00 FROM seq;
INSERT INTO shipments (shipment_id, order_id, carrier, tracking_status, delivery_days)
WITH d10(d) AS (VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9)),
seq(n) AS (
  SELECT a.d + b.d*10 + c.d*100 + d.d*1000 + e.d*10000 + 1
  FROM d10 a, d10 b, d10 c, d10 d, d10 e
  LIMIT 50000
)
SELECT n, n, 'UPS', 'DELIVERED', 1 FROM seq;
