-- Schema DDL
CREATE TABLE orders (order_id INTEGER PRIMARY KEY, cust_id INTEGER);

CREATE TABLE lineitem (item_id INTEGER PRIMARY KEY, order_id INTEGER, quantity INTEGER, ship_date DATE, FOREIGN KEY (order_id) REFERENCES orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic join, grouping by order_id vs cust_id, and SUM vs COUNT/AVG/MIN/MAX
INSERT INTO orders (order_id, cust_id) VALUES (1, 100);
INSERT INTO orders (order_id, cust_id) VALUES (2, 100);
INSERT INTO orders (order_id, cust_id) VALUES (3, 200);
INSERT INTO lineitem (item_id, order_id, quantity, ship_date) VALUES (10, 1, 5, '2023-01-01');
INSERT INTO lineitem (item_id, order_id, quantity, ship_date) VALUES (11, 1, 15, '2023-01-02');
INSERT INTO lineitem (item_id, order_id, quantity, ship_date) VALUES (12, 2, 10, '2023-01-03');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT o.order_id, SUM(l.quantity) FROM orders AS o JOIN lineitem AS l ON o.order_id = l.order_id GROUP BY o.order_id;

/*
Gold Result:
(1, 20)
(2, 10)
*/

-- Prediction Query
SELECT o.order_id, SUM(l.quantity) FROM orders AS o JOIN lineitem AS l ON o.order_id = l.order_id GROUP BY o.order_id, l.ship_date;

/*
Prediction Result:
(1, 5)
(1, 15)
(2, 10)
*/