-- Schema DDL
CREATE TABLE items (item_id INTEGER PRIMARY KEY, item_name TEXT(100));

CREATE TABLE orders (item_id INTEGER, rep_id INTEGER, cust_id INTEGER, order_date DATE, qty INTEGER, total INTEGER, FOREIGN KEY (item_id) REFERENCES items (item_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "items" ("item_id", "item_name") VALUES (1217, 'James Ferrell');
INSERT INTO "items" ("item_id", "item_name") VALUES (1223, 'James Ferrell');
INSERT INTO "items" ("item_id", "item_name") VALUES (1228, 'Tricia Valencia');
INSERT INTO "orders" ("item_id", "rep_id", "cust_id", "order_date", "qty", "total") VALUES (1217, 1218, 1219, '2020-03-31', 1220, 1221);
INSERT INTO "orders" ("item_id", "rep_id", "cust_id", "order_date", "qty", "total") VALUES (NULL, 1224, 1225, '2020-07-01', 1226, 1227);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT I.ITEM_ID, I.ITEM_NAME FROM items AS I INNER JOIN (SELECT ITEM_ID FROM orders GROUP BY ITEM_ID HAVING MIN(ORDER_DATE) >= '2020-01-01' AND MAX(ORDER_DATE) <= '2020-06-30') AS O ON I.ITEM_ID = O.ITEM_ID;

/*
Gold Result:
(1217, 'James Ferrell')
*/

-- Prediction Query
SELECT DISTINCT I.ITEM_ID, ITEM_NAME FROM items AS I JOIN orders AS O ON I.ITEM_ID = O.ITEM_ID WHERE ORDER_DATE BETWEEN '2020-01-01' AND '2020-06-30' AND NOT I.ITEM_ID IN (SELECT DISTINCT ITEM_ID FROM orders WHERE ORDER_DATE < '2020-01-01' OR ORDER_DATE > '2020-06-30');

/*
Prediction Result:
*/