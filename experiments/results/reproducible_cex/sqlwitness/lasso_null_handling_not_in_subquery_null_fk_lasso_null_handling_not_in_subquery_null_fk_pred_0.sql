-- Schema DDL
CREATE TABLE items (item_id INTEGER PRIMARY KEY, item_name TEXT(100));

CREATE TABLE orders (item_id INTEGER, rep_id INTEGER, cust_id INTEGER, order_date DATE, qty INTEGER, total INTEGER, FOREIGN KEY (item_id) REFERENCES items (item_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO items (item_id, item_name) VALUES (0, '2020-01-01'), (1, NULL), (2, 'default1'), (3, NULL), (4, '2020-01-01'), (5, '2020-01-01'), (6, 'default1'), (7, 'default2'), (8, 'default2');
INSERT INTO orders (item_id, rep_id, cust_id, order_date, qty, total) VALUES (4, NULL, 0, '2020-01-02', NULL, 1), (0, NULL, NULL, '2023-01-02', NULL, NULL), (5, 0, 0, '2020-01-02', 1, 0), (3, NULL, 0, '2020-07-01', 0, 1), (5, 1, 1, '2019-12-31', 1, 0), (8, 1, NULL, NULL, 0, 0), (5, 0, NULL, '2020-01-02', 1, 1), (0, NULL, 1, '2020-07-01', 0, 1), (NULL, NULL, 1, '2020-07-01', 1, 0), (4, 0, 0, '2020-01-02', 1, 1), (NULL, 1, NULL, '2020-07-01', 0, NULL), (1, NULL, 0, '2023-01-01', 1, 1), (0, NULL, 1, '2020-01-02', 0, 0), (4, NULL, 0, NULL, 1, 0), (2, 0, 0, '2020-07-01', 1, NULL), (1, 0, NULL, '2019-12-31', 0, 0), (5, 0, 0, '2020-06-30', NULL, NULL), (6, NULL, 0, '2020-01-02', 1, 0), (7, 1, NULL, '2023-01-01', 0, 1), (1, 0, NULL, '2019-12-31', 1, 0), (7, 0, 0, '2020-06-30', 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT I.ITEM_ID, I.ITEM_NAME FROM items AS I INNER JOIN (SELECT ITEM_ID FROM orders GROUP BY ITEM_ID HAVING MIN(ORDER_DATE) >= '2020-01-01' AND MAX(ORDER_DATE) <= '2020-06-30') AS O ON I.ITEM_ID = O.ITEM_ID;

/*
Gold Result:
(4, '2020-01-01')
(6, 'default1')
*/

-- Prediction Query
SELECT DISTINCT I.ITEM_ID, ITEM_NAME FROM items AS I JOIN orders AS O ON I.ITEM_ID = O.ITEM_ID WHERE ORDER_DATE BETWEEN '2020-01-01' AND '2020-06-30' AND NOT I.ITEM_ID IN (SELECT DISTINCT ITEM_ID FROM orders WHERE ORDER_DATE < '2020-01-01' OR ORDER_DATE > '2020-06-30');

/*
Prediction Result:
*/