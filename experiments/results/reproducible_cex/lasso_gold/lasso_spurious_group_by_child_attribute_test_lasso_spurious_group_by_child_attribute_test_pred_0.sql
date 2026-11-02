-- Schema DDL
CREATE TABLE orders (order_id INTEGER PRIMARY KEY, cust_id INTEGER);

CREATE TABLE lineitem (item_id INTEGER PRIMARY KEY, order_id INTEGER, quantity INTEGER, ship_date DATE, FOREIGN KEY (order_id) REFERENCES orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "orders" ("order_id", "cust_id") VALUES (1015, 1016);
INSERT INTO "orders" ("order_id", "cust_id") VALUES (1019, 1020);
INSERT INTO "orders" ("order_id", "cust_id") VALUES (1027, 1023);
INSERT INTO "lineitem" ("item_id", "order_id", "quantity", "ship_date") VALUES (1017, 1015, 1018, '1973-04-04');
INSERT INTO "lineitem" ("item_id", "order_id", "quantity", "ship_date") VALUES (1021, 1019, NULL, '1974-05-05');
INSERT INTO "lineitem" ("item_id", "order_id", "quantity", "ship_date") VALUES (1024, 1019, 1025, '1975-06-06');
INSERT INTO "lineitem" ("item_id", "order_id", "quantity", "ship_date") VALUES (1026, 1015, NULL, '1973-04-04');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT o.order_id, SUM(l.quantity) FROM orders AS o JOIN lineitem AS l ON o.order_id = l.order_id GROUP BY o.order_id;

/*
Gold Result:
(1015, 1018)
(1019, 1025)
*/

-- Prediction Query
SELECT o.order_id, SUM(l.quantity) FROM orders AS o JOIN lineitem AS l ON o.order_id = l.order_id GROUP BY o.order_id, l.ship_date;

/*
Prediction Result:
(1015, 1018)
(1019, None)
(1019, 1025)
*/