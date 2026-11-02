INSERT INTO customers (customer_id, customer_name, country, tier, credit_limit)
WITH digits AS (
    SELECT 0 AS d UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
    UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
),
numbers AS (
    SELECT (d3.d * 1000 + d2.d * 100 + d1.d * 10 + d0.d) + 1 AS n
    FROM digits d0
    CROSS JOIN digits d1
    CROSS JOIN digits d2
    CROSS JOIN digits d3
)
SELECT n, 'Customer_' || n, 'US', 'SILVER', 1000.00
FROM numbers
WHERE n <= 1200;
