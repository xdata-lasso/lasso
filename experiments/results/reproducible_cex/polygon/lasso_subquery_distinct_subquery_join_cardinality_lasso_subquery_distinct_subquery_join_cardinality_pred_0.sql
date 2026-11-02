-- Schema DDL
CREATE TABLE orders (order_id INTEGER PRIMARY KEY, customer_id INTEGER, total_amount REAL);

CREATE TABLE customer_summary (customer_id INTEGER PRIMARY KEY, status TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "orders" ("order_id", "customer_id", "total_amount") VALUES (14, 20, 101);
INSERT INTO "orders" ("order_id", "customer_id", "total_amount") VALUES (13, 20, 101);
INSERT INTO "customer_summary" ("customer_id", "status") VALUES (20, '21');
INSERT INTO "customer_summary" ("customer_id", "status") VALUES (15, '20');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.status FROM orders AS o JOIN customer_summary AS s ON o.customer_id = s.customer_id WHERE o.total_amount > 100.0;

/*
Gold Result:
('21',)
('21',)
*/

-- Prediction Query
SELECT s.status FROM customer_summary AS s JOIN (SELECT DISTINCT customer_id FROM orders WHERE total_amount > 100.0) AS sub ON s.customer_id = sub.customer_id;

/*
Prediction Result:
('21',)
*/