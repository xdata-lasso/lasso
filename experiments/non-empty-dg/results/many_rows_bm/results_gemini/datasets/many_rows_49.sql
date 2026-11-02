INSERT INTO customers (customer_id, customer_name, country, tier, credit_limit)
WITH digits(d) AS (VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9)),
     nums(n) AS (SELECT d1.d + d2.d*10 + d3.d*100 FROM digits d1, digits d2, digits d3)
SELECT n + 1, 'Customer_' || (n + 1), 'USA', 'GOLD', 1000.0
FROM nums
WHERE n < 250;
INSERT INTO orders (order_id, customer_id, order_date, order_status, total_amount)
WITH digits(d) AS (VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9)),
     nums(n) AS (
         SELECT d1.d + d2.d*10 + d3.d*100 + d4.d*1000 + d5.d*10000
         FROM digits d1, digits d2, digits d3, digits d4, digits d5
     )
SELECT 
    n + 1, 
    (n / 100) + 1, 
    '2023-01-01', 
    'DELIVERED', 
    20.0
FROM nums
WHERE n < 25000;
