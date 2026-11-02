-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'B'), (1, 'C'), (2, 'B'), (-1, NULL), (3, 'C'), (4, 'C'), (5, NULL), (6, 'A'), (7, NULL), (8, 'C'), (9, 'default1'), (10, 'C'), (11, 'C'), (12, 'default2'), (13, 'default2'), (14, 'B'), (15, 'B'), (16, NULL), (17, 'default1'), (18, 'default2'), (19, 'C'), (20, 'default2'), (21, 'C'), (22, 'default1'), (23, 'A'), (24, 'default1'), (25, NULL), (26, 'default1'), (27, 'A'), (28, 'C'), (29, 'C'), (30, 'B'), (31, NULL), (32, 'C'), (33, 'C'), (34, 'B'), (35, 'B'), (36, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 4, 'B'), (-1, 25, 'A'), (2, 10, NULL), (0, 10, NULL), (3, 3, 'C'), (4, 32, 'A'), (5, 13, 'B'), (6, 3, 'default1'), (7, 26, 'B'), (8, 24, 'default2'), (9, 1, 'C'), (10, -1, 'B'), (11, 0, 'default1'), (12, 14, NULL), (13, 34, 'B'), (14, 35, 'default1'), (15, 7, NULL), (16, 33, 'C'), (17, 16, 'default2'), (18, 28, 'default2'), (19, 23, 'A'), (20, 0, NULL), (21, 32, 'B'), (22, 31, 'default1'), (23, 34, 'default2'), (24, -1, 'B'), (25, 19, 'default2'), (26, 21, 'default1'), (27, 28, 'B'), (28, 19, 'C'), (29, 6, 'default2'), (30, 0, 'C'), (31, 3, 'B'), (32, NULL, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(32, 'C')
*/

-- Prediction Query
WITH B AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A' GROUP BY CUSTOMER_ID), D AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B' GROUP BY CUSTOMER_ID) SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C JOIN (SELECT B.CUSTOMER_ID FROM B JOIN D ON B.CUSTOMER_ID = D.CUSTOMER_ID) AS E ON C.CUSTOMER_ID = E.CUSTOMER_ID WHERE NOT C.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
*/