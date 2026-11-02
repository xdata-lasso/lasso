-- Schema DDL
CREATE TABLE orders (order_id INTEGER PRIMARY KEY, cust_id INTEGER);

CREATE TABLE lineitem (item_id INTEGER PRIMARY KEY, order_id INTEGER, quantity INTEGER, ship_date DATE, FOREIGN KEY (order_id) REFERENCES orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: orders --
INSERT INTO "orders" ("order_id", "cust_id") VALUES (1, -55602865);

INSERT INTO "orders" ("order_id", "cust_id") VALUES (2, 1258409369);

INSERT INTO "orders" ("order_id", "cust_id") VALUES (5, -1981402255);

INSERT INTO "orders" ("order_id", "cust_id") VALUES (4, -55602865);

INSERT INTO "orders" ("order_id", "cust_id") VALUES (3, -59984348);

-- Inserting into table: lineitem --
INSERT INTO "lineitem" ("item_id", "order_id", "quantity", "ship_date") VALUES (-2147483648, 1, -59984348, '2023-11-15');

INSERT INTO "lineitem" ("item_id", "order_id", "quantity", "ship_date") VALUES (-2147483647, 5, -890215420, '2022-04-27');

INSERT INTO "lineitem" ("item_id", "order_id", "quantity", "ship_date") VALUES (-2147483646, 5, -1980249628, '2022-10-19');

INSERT INTO "lineitem" ("item_id", "order_id", "quantity", "ship_date") VALUES (-2147483645, 5, 1871297066, '2023-07-13');

INSERT INTO "lineitem" ("item_id", "order_id", "quantity", "ship_date") VALUES (2, 1, 89267185, '2020-12-20');

INSERT INTO "lineitem" ("item_id", "order_id", "quantity", "ship_date") VALUES (3, 1, 1744686505, '2025-06-04');

INSERT INTO "lineitem" ("item_id", "order_id", "quantity", "ship_date") VALUES (-2147483642, 1, NULL, '2021-05-05');

INSERT INTO "lineitem" ("item_id", "order_id", "quantity", "ship_date") VALUES (-2147483641, 1, NULL, '2023-01-06');

INSERT INTO "lineitem" ("item_id", "order_id", "quantity", "ship_date") VALUES (-2147483640, 1, NULL, '2021-07-04');

INSERT INTO "lineitem" ("item_id", "order_id", "quantity", "ship_date") VALUES (-2147483639, 1, NULL, '2020-01-20');

INSERT INTO "lineitem" ("item_id", "order_id", "quantity", "ship_date") VALUES (5, 4, 3, '2023-11-15');

INSERT INTO "lineitem" ("item_id", "order_id", "quantity", "ship_date") VALUES (4, 5, 2, '2022-12-08');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT o.order_id, SUM(l.quantity) FROM orders AS o JOIN lineitem AS l ON o.order_id = l.order_id GROUP BY o.order_id;

/*
Gold Result:
(1, 1773969342)
(4, 3)
(5, -999167980)
*/

-- Prediction Query
SELECT o.order_id, SUM(l.quantity) FROM orders AS o JOIN lineitem AS l ON o.order_id = l.order_id GROUP BY o.order_id, l.ship_date;

/*
Prediction Result:
(1, None)
(1, 89267185)
(1, None)
(1, None)
(1, None)
(1, -59984348)
(1, 1744686505)
(4, 3)
(5, -890215420)
(5, -1980249628)
(5, 2)
(5, 1871297066)
*/