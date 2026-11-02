INSERT INTO customers (customer_id, customer_name, country, tier, credit_limit) 
VALUES (1, 'Alice', 'USA', 'GOLD', 100000.0);
INSERT INTO orders (order_id, customer_id, order_date, order_status, total_amount)
WITH RECURSIVE cte(n) AS (
    SELECT 1
    UNION ALL
    SELECT n + 1 FROM cte WHERE n < 1001
)
SELECT n, 1, '2023-01-01', 'SHIPPED', 50.0 FROM cte;
