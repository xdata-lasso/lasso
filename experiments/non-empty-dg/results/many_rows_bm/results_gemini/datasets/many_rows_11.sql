INSERT INTO customers (customer_id, customer_name, country, tier, credit_limit) 
VALUES (1, 'Customer_1', 'USA', 'GOLD', 100000.00);
INSERT INTO orders (order_id, customer_id, order_date, order_status, total_amount)
WITH RECURSIVE
  tens(t) AS (
    SELECT 0 UNION ALL SELECT t + 1 FROM tens WHERE t < 99
  ),
  fifties(f) AS (
    SELECT 0 UNION ALL SELECT f + 1 FROM fifties WHERE f < 49
  )
SELECT (f.f * 100 + tens.t + 1), 1, '2023-01-01', 'PAID', 20.00
FROM fifties f CROSS JOIN tens;
