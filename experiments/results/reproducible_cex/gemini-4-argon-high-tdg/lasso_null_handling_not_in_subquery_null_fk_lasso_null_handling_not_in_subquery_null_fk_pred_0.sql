-- Schema DDL
CREATE TABLE items (item_id INTEGER PRIMARY KEY, item_name TEXT(100));

CREATE TABLE orders (item_id INTEGER, rep_id INTEGER, cust_id INTEGER, order_date DATE, qty INTEGER, total INTEGER, FOREIGN KEY (item_id) REFERENCES items (item_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 6
INSERT INTO items (item_id, item_name) VALUES (1, 'Null Date Only');
INSERT INTO items (item_id, item_name) VALUES (2, 'Valid And Null Date');
INSERT INTO items (item_id, item_name) VALUES (3, 'Invalid And Null Date');
INSERT INTO orders (item_id, rep_id, cust_id, order_date, qty, total) VALUES (1, 10, 20, NULL, 1, 50);
INSERT INTO orders (item_id, rep_id, cust_id, order_date, qty, total) VALUES (2, 11, 21, '2020-04-10', 2, 100);
INSERT INTO orders (item_id, rep_id, cust_id, order_date, qty, total) VALUES (2, 12, 22, NULL, 1, 50);
INSERT INTO orders (item_id, rep_id, cust_id, order_date, qty, total) VALUES (3, 13, 23, '2019-05-01', 3, 150);
INSERT INTO orders (item_id, rep_id, cust_id, order_date, qty, total) VALUES (3, 14, 24, NULL, 2, 100);
INSERT INTO orders (item_id, rep_id, cust_id, order_date, qty, total) VALUES (NULL, 15, 25, '2018-01-01', 1, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT I.ITEM_ID, I.ITEM_NAME FROM items AS I INNER JOIN (SELECT ITEM_ID FROM orders GROUP BY ITEM_ID HAVING MIN(ORDER_DATE) >= '2020-01-01' AND MAX(ORDER_DATE) <= '2020-06-30') AS O ON I.ITEM_ID = O.ITEM_ID;

/*
Gold Result:
(2, 'Valid And Null Date')
*/

-- Prediction Query
SELECT DISTINCT I.ITEM_ID, ITEM_NAME FROM items AS I JOIN orders AS O ON I.ITEM_ID = O.ITEM_ID WHERE ORDER_DATE BETWEEN '2020-01-01' AND '2020-06-30' AND NOT I.ITEM_ID IN (SELECT DISTINCT ITEM_ID FROM orders WHERE ORDER_DATE < '2020-01-01' OR ORDER_DATE > '2020-06-30');

/*
Prediction Result:
*/