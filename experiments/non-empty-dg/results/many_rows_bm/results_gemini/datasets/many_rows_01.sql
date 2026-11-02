INSERT INTO customers (customer_id, customer_name, country, tier, credit_limit)
WITH digits(d) AS (
  SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
  UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
),
nums(n) AS (
  SELECT d1.d * 100 + d2.d * 10 + d3.d + 1
  FROM digits d1, digits d2, digits d3
)
SELECT n, 'Customer ' || n, 'USA', 'GOLD', 1000.00
FROM nums;
