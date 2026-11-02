INSERT INTO customers (customer_id, customer_name, country, tier, credit_limit)
VALUES (1, 'Alice', 'USA', 'GOLD', 1000.00);
INSERT INTO customer_events (customer_id, event_type, page_url, duration_seconds, event_seq)
WITH
  c10(x) AS (VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9)),
  nums(n) AS (
    SELECT a.x + b.x*10 + c.x*100 + d.x*1000 + e.x*10000 + 1
    FROM c10 a, c10 b, c10 c, c10 d, c10 e
    WHERE a.x + b.x*10 + c.x*100 + d.x*1000 + e.x*10000 + 1 <= 25001
  )
SELECT 1, 'VIEW', 'http://example.com', 10, n FROM nums;
