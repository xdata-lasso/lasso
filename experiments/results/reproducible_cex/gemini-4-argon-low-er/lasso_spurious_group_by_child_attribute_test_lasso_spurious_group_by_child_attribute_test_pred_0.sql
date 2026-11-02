-- Schema DDL
CREATE TABLE orders (order_id INTEGER PRIMARY KEY, cust_id INTEGER);

CREATE TABLE lineitem (item_id INTEGER PRIMARY KEY, order_id INTEGER, quantity INTEGER, ship_date DATE, FOREIGN KEY (order_id) REFERENCES orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO orders (order_id, cust_id) VALUES (1, 100);
INSERT INTO lineitem (item_id, order_id, quantity, ship_date) VALUES (1, 1, 10, '2023-01-01');
INSERT INTO lineitem (item_id, order_id, quantity, ship_date) VALUES (2, 1, 20, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT o.order_id, SUM(l.quantity) FROM orders AS o JOIN lineitem AS l ON o.order_id = l.order_id GROUP BY o.order_id;

/*
Gold Result:
(1, 30)
*/

-- Prediction Query
SELECT o.order_id, SUM(l.quantity) FROM orders AS o JOIN lineitem AS l ON o.order_id = l.order_id GROUP BY o.order_id, l.ship_date;

/*
Prediction Result:
(1, 10)
(1, 20)
*/