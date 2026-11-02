-- Schema DDL
CREATE TABLE orders (order_id INTEGER PRIMARY KEY, cust_id INTEGER);

CREATE TABLE lineitem (item_id INTEGER PRIMARY KEY, order_id INTEGER, quantity INTEGER, ship_date DATE, FOREIGN KEY (order_id) REFERENCES orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "orders" ("order_id", "cust_id") VALUES (10, 13);
INSERT INTO "orders" ("order_id", "cust_id") VALUES (13, 21);
INSERT INTO "lineitem" ("item_id", "order_id", "quantity", "ship_date") VALUES (12, 13, NULL, '1000-01-20');
INSERT INTO "lineitem" ("item_id", "order_id", "quantity", "ship_date") VALUES (11, 13, -777, '1000-01-21');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT o.order_id, SUM(l.quantity) FROM orders AS o JOIN lineitem AS l ON o.order_id = l.order_id GROUP BY o.order_id;

/*
Gold Result:
(13, -777)
*/

-- Prediction Query
SELECT o.order_id, SUM(l.quantity) FROM orders AS o JOIN lineitem AS l ON o.order_id = l.order_id GROUP BY o.order_id, l.ship_date;

/*
Prediction Result:
(13, None)
(13, -777)
*/