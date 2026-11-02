-- Schema DDL
CREATE TABLE orders (order_id INTEGER PRIMARY KEY, customer_id INTEGER, total_amount REAL);

CREATE TABLE customer_summary (customer_id INTEGER PRIMARY KEY, status TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customer_summary (customer_id, status) VALUES (1, NULL), (0, 'default2');
INSERT INTO orders (order_id, customer_id, total_amount) VALUES (0, 1, 100.0), (1, 1, 100.0), (2, 1, 100.0), (3, NULL, 99.0), (4, 1, 101.0), (5, NULL, 1.0), (6, 0, 99.0), (7, 1, 0.0), (8, 0, 101.0), (9, 0, 100.0), (10, 1, 101.0), (11, 1, 101.0), (12, 1, 100.0), (13, 0, 1.0), (14, 0, 100.0), (15, 0, 99.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.status FROM orders AS o JOIN customer_summary AS s ON o.customer_id = s.customer_id WHERE o.total_amount > 100.0;

/*
Gold Result:
(None,)
('default2',)
(None,)
(None,)
*/

-- Prediction Query
SELECT s.status FROM customer_summary AS s JOIN (SELECT DISTINCT customer_id FROM orders WHERE total_amount > 100.0) AS sub ON s.customer_id = sub.customer_id;

/*
Prediction Result:
(None,)
('default2',)
*/