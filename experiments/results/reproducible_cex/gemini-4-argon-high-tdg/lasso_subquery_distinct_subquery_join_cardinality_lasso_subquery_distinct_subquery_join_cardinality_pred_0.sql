-- Schema DDL
CREATE TABLE orders (order_id INTEGER PRIMARY KEY, customer_id INTEGER, total_amount REAL);

CREATE TABLE customer_summary (customer_id INTEGER PRIMARY KEY, status TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO customer_summary (customer_id, status) VALUES (10, 'REPEAT_CUSTOMER');
INSERT INTO customer_summary (customer_id, status) VALUES (20, 'SINGLE_CUSTOMER');
INSERT INTO orders (order_id, customer_id, total_amount) VALUES (1, 10, 150.0);
INSERT INTO orders (order_id, customer_id, total_amount) VALUES (2, 10, 220.5);
INSERT INTO orders (order_id, customer_id, total_amount) VALUES (3, 10, 80.0);
INSERT INTO orders (order_id, customer_id, total_amount) VALUES (4, 20, 110.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.status FROM orders AS o JOIN customer_summary AS s ON o.customer_id = s.customer_id WHERE o.total_amount > 100.0;

/*
Gold Result:
('REPEAT_CUSTOMER',)
('REPEAT_CUSTOMER',)
('SINGLE_CUSTOMER',)
*/

-- Prediction Query
SELECT s.status FROM customer_summary AS s JOIN (SELECT DISTINCT customer_id FROM orders WHERE total_amount > 100.0) AS sub ON s.customer_id = sub.customer_id;

/*
Prediction Result:
('REPEAT_CUSTOMER',)
('SINGLE_CUSTOMER',)
*/