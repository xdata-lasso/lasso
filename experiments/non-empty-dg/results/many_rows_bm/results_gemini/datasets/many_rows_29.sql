INSERT INTO customers (customer_id, customer_name, country, tier, credit_limit) 
VALUES (1, 'Alice Corp', 'USA', 'PLATINUM', 2000000.00);
INSERT INTO orders (order_id, customer_id, order_date, order_status, total_amount)
WITH digits AS (
    SELECT 0 AS d UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
    UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
)
SELECT 
    d1.d * 10000 + d2.d * 1000 + d3.d * 100 + d4.d * 10 + d5.d + 1 AS order_id,
    1 AS customer_id,
    '2023-01-01' AS order_date,
    'PAID' AS order_status,
    10.00 AS total_amount
FROM digits d1
CROSS JOIN digits d2
CROSS JOIN digits d3
CROSS JOIN digits d4
CROSS JOIN digits d5;
