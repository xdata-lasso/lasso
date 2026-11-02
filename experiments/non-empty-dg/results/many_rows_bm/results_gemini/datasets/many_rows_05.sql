INSERT INTO customers (customer_id, customer_name, country, tier, credit_limit) 
VALUES (1, 'John Doe', 'USA', 'GOLD', 5000.00);
INSERT INTO customer_events (event_id, customer_id, event_type, page_url, duration_seconds, event_seq)
WITH RECURSIVE cnt(x) AS (
    SELECT 1
    UNION ALL
    SELECT x + 1 FROM cnt WHERE x < 2000
)
SELECT x, 1, 'VIEW', 'https://example.com/home', 60, x FROM cnt;
