-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'C'), (1, 'default2'), (-1, 'A'), (0, 'default1'), (3, 'default2'), (4, 'C'), (5, 'default2'), (6, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 4, 'default2'), (2, 4, 'B'), (0, 1, 'default1'), (1, 5, 'B'), (3, 3, 'C'), (4, 3, 'default2'), (5, NULL, 'B'), (6, 0, 'A'), (7, 6, 'A'), (8, 6, 'B'), (9, 2, NULL), (10, 2, NULL), (11, -1, NULL), (12, 0, 'C'), (13, -1, NULL), (14, 2, 'A'), (15, 3, 'C'), (16, 4, 'C'), (17, 6, NULL), (18, 2, 'default1'), (19, 4, 'C'), (20, NULL, 'A'), (21, 4, NULL), (22, 2, 'A'), (23, 6, 'B'), (24, 1, 'default1'), (25, 4, 'default1'), (26, -1, 'default1'), (27, NULL, 'A'), (28, 5, NULL), (29, 0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(6, 'default2')
*/

-- Prediction Query
WITH PRODA AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A'), PRODB AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B'), PRODC AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') SELECT U.* FROM CUSTOMERS AS U JOIN PRODA ON U.CUSTOMER_ID = PRODA.CUSTOMER_ID JOIN PRODB ON U.CUSTOMER_ID = PRODB.CUSTOMER_ID LEFT JOIN PRODC ON U.CUSTOMER_ID = PRODC.CUSTOMER_ID WHERE PRODC.CUSTOMER_ID IS NULL;

/*
Prediction Result:
(6, 'default2')
(6, 'default2')
*/