INSERT INTO customers (customer_id, customer_name, country, tier, credit_limit) 
VALUES (1, 'HighVolume Buyer', 'USA', 'GOLD', 1000000.00);
INSERT INTO orders (order_id, customer_id, order_date, order_status, total_amount)
WITH digits AS (
    SELECT 0 AS d UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
    UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
),
numbers AS (
    SELECT (d3.d * 1000 + d2.d * 100 + d1.d * 10 + d0.d) + 1 AS id
    FROM digits d0
    CROSS JOIN digits d1
    CROSS JOIN digits d2
    CROSS JOIN (SELECT 0 AS d UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5) d3
)
SELECT id, 1, '2023-01-01', 'PAID', 100.00
FROM numbers
WHERE id <= 5001;
