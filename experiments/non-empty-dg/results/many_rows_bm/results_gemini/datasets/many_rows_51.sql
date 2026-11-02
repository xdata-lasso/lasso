INSERT INTO customers (customer_id, customer_name, country, tier, credit_limit)
VALUES (1, 'High Volume Customer', 'USA', 'PLATINUM', 500000.0);
INSERT INTO orders (order_id, customer_id, order_date, order_status, total_amount)
WITH d AS (
    SELECT 0 AS n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
    UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
)
SELECT 
    d1.n + d2.n * 10 + d3.n * 100 + d4.n * 1000 + d5.n * 10000 + 1 AS order_id,
    1 AS customer_id,
    '2023-01-01' AS order_date,
    'PAID' AS order_status,
    10.00 AS total_amount
FROM d d1, d d2, d d3, d d4, d d5
WHERE d1.n + d2.n * 10 + d3.n * 100 + d4.n * 1000 + d5.n * 10000 < 45000;
