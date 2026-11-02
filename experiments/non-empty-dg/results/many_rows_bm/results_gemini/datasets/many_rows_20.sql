INSERT INTO customers (customer_id, customer_name, country, tier, credit_limit)
WITH tens(n) AS (
    VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9)
),
nums(n) AS (
    SELECT t1.n + 10 * t2.n + 100 * t3.n + 1000 * t4.n + 10000 * t5.n + 1
    FROM tens t1, tens t2, tens t3, tens t4, tens t5
    WHERE t1.n + 10 * t2.n + 100 * t3.n + 1000 * t4.n + 10000 * t5.n + 1 <= 20000
)
SELECT n, 'Customer_' || n, 'USA', 'GOLD', 1500.00
FROM nums;
