INSERT INTO customers (customer_id, customer_name, country, tier, credit_limit)
VALUES (1, 'Customer 1', 'USA', 'GOLD', 1000.0);
INSERT INTO orders (order_id, customer_id, order_date, order_status, total_amount)
WITH digits(d) AS (
    SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
    UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
),
seq(n) AS (
    SELECT d0.d + d1.d * 10 + d2.d * 100 + d3.d * 1000 + d4.d * 10000 + 1
    FROM digits d0, digits d1, digits d2, digits d3, digits d4
    WHERE d0.d + d1.d * 10 + d2.d * 100 + d3.d * 1000 + d4.d * 10000 + 1 <= 75001
)
SELECT n, 1, '2023-01-01', 'DELIVERED', 10.0
FROM seq;
INSERT INTO shipments (shipment_id, order_id, carrier, tracking_status, delivery_days)
WITH digits(d) AS (
    SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
    UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
),
seq(n) AS (
    SELECT d0.d + d1.d * 10 + d2.d * 100 + d3.d * 1000 + d4.d * 10000 + 1
    FROM digits d0, digits d1, digits d2, digits d3, digits d4
    WHERE d0.d + d1.d * 10 + d2.d * 100 + d3.d * 1000 + d4.d * 10000 + 1 <= 75001
)
SELECT n, n, 'UPS', 'DELIVERED', 3
FROM seq;
