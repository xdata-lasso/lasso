INSERT INTO customers (customer_id, customer_name, country, tier, credit_limit) 
VALUES (1, 'Acme Corp', 'USA', 'PLATINUM', 1000000.00);
INSERT INTO orders (order_id, customer_id, order_date, order_status, total_amount)
WITH RECURSIVE cnt(x) AS (
    SELECT 1
    UNION ALL
    SELECT x + 1 FROM cnt WHERE x < 1500
)
SELECT x, 1, '2023-01-01', 'DELIVERED', 100.00 FROM cnt;
