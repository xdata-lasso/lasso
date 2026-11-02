-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'A'), (0, 'B'), (2, NULL), (1, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, NULL, NULL), (0, NULL, NULL), (2, 0, 'default2'), (1, 0, 'A'), (3, 2, 'C'), (4, NULL, 'default1'), (5, -1, 'default2'), (6, 0, 'C'), (7, 1, 'A'), (8, 0, 'default1'), (9, 1, 'default2'), (10, 0, 'default1'), (11, 2, 'C'), (12, 1, NULL), (13, 1, 'default2'), (14, NULL, 'B'), (15, 1, 'B'), (16, 2, NULL), (17, 1, NULL), (18, NULL, NULL), (19, -1, 'C'), (20, 0, 'default1'), (21, 1, 'B'), (22, 2, 'default1'), (23, 2, 'A'), (24, -1, 'C'), (25, 0, 'A'), (26, 2, 'C'), (27, -1, 'default2'), (28, NULL, 'C'), (29, -1, 'B'), (30, NULL, 'default1'), (31, 2, 'C'), (32, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, None)
*/

-- Prediction Query
WITH CTEC AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C'), CTEB AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') SELECT T.CUSTOMER_ID, C.CUSTOMER_NAME FROM (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE (PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT * FROM CTEB) AND NOT CUSTOMER_ID IN (SELECT * FROM CTEC)) AS T LEFT JOIN CUSTOMERS AS C ON T.CUSTOMER_ID = C.CUSTOMER_ID;

/*
Prediction Result:
*/