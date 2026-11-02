-- Schema DDL
CREATE TABLE orders (order_id INTEGER PRIMARY KEY, customer_id INTEGER, total_amount REAL);

CREATE TABLE customer_summary (customer_id INTEGER PRIMARY KEY, status TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: orders --
INSERT INTO "orders" ("order_id", "customer_id", "total_amount") VALUES (-2147483648, 1, 100.01);

INSERT INTO "orders" ("order_id", "customer_id", "total_amount") VALUES (-2147483647, 2, 100.01);

INSERT INTO "orders" ("order_id", "customer_id", "total_amount") VALUES (-2147483646, 3, 100.01);

INSERT INTO "orders" ("order_id", "customer_id", "total_amount") VALUES (-2147483645, 2, 100.01);

INSERT INTO "orders" ("order_id", "customer_id", "total_amount") VALUES (-2147483644, 2, 100.01);

INSERT INTO "orders" ("order_id", "customer_id", "total_amount") VALUES (-2147483643, 2, 100.01);

INSERT INTO "orders" ("order_id", "customer_id", "total_amount") VALUES (2, 1, 100.01);

INSERT INTO "orders" ("order_id", "customer_id", "total_amount") VALUES (3, 1, 100.01);

INSERT INTO "orders" ("order_id", "customer_id", "total_amount") VALUES (-2147483640, 1, 100.0);

INSERT INTO "orders" ("order_id", "customer_id", "total_amount") VALUES (-2147483639, 1, 100.01);

-- Inserting into table: customer_summary --
INSERT INTO "customer_summary" ("customer_id", "status") VALUES (1, 's_s_2d6991');

INSERT INTO "customer_summary" ("customer_id", "status") VALUES (2, 's_s_2d6991');

INSERT INTO "customer_summary" ("customer_id", "status") VALUES (-2147483647, 's_s_2d6991');

INSERT INTO "customer_summary" ("customer_id", "status") VALUES (3, 's_s_2d6991');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.status FROM orders AS o JOIN customer_summary AS s ON o.customer_id = s.customer_id WHERE o.total_amount > 100.0;

/*
Gold Result:
('s_s_2d6991',)
('s_s_2d6991',)
('s_s_2d6991',)
('s_s_2d6991',)
('s_s_2d6991',)
('s_s_2d6991',)
('s_s_2d6991',)
('s_s_2d6991',)
('s_s_2d6991',)
*/

-- Prediction Query
SELECT s.status FROM customer_summary AS s JOIN (SELECT DISTINCT customer_id FROM orders WHERE total_amount > 100.0) AS sub ON s.customer_id = sub.customer_id;

/*
Prediction Result:
('s_s_2d6991',)
('s_s_2d6991',)
('s_s_2d6991',)
*/