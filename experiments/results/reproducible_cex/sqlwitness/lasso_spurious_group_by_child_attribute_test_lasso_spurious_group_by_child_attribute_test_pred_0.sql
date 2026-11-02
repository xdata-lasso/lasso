-- Schema DDL
CREATE TABLE orders (order_id INTEGER PRIMARY KEY, cust_id INTEGER);

CREATE TABLE lineitem (item_id INTEGER PRIMARY KEY, order_id INTEGER, quantity INTEGER, ship_date DATE, FOREIGN KEY (order_id) REFERENCES orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO orders (order_id, cust_id) VALUES (0, NULL), (1, 1), (2, NULL), (3, 1), (4, 0);
INSERT INTO lineitem (item_id, order_id, quantity, ship_date) VALUES (0, 2, 1, NULL), (1, 2, 0, NULL), (2, 4, NULL, NULL), (3, NULL, NULL, '2023-01-01'), (4, 3, 0, '2023-01-02'), (5, 2, NULL, NULL), (6, 2, 0, '2023-01-01'), (7, 0, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT o.order_id, SUM(l.quantity) FROM orders AS o JOIN lineitem AS l ON o.order_id = l.order_id GROUP BY o.order_id;

/*
Gold Result:
(0, 1)
(2, 1)
(3, 0)
(4, None)
*/

-- Prediction Query
SELECT o.order_id, SUM(l.quantity) FROM orders AS o JOIN lineitem AS l ON o.order_id = l.order_id GROUP BY o.order_id, l.ship_date;

/*
Prediction Result:
(0, 1)
(2, 1)
(2, 0)
(3, 0)
(4, None)
*/