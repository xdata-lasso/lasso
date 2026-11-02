INSERT INTO customers (customer_id, customer_name, country, tier, credit_limit)
WITH RECURSIVE cnt(n) AS (
    SELECT 1
    UNION ALL
    SELECT n + 1 FROM cnt WHERE n < 35
)
SELECT 
    (c1.n - 1) * 35 + c2.n,
    'Customer_' || ((c1.n - 1) * 35 + c2.n),
    'Canada',
    'GOLD',
    100.00
FROM cnt AS c1
CROSS JOIN cnt AS c2;
