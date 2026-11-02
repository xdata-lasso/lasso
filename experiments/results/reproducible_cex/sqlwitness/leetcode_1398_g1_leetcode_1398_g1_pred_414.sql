-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'default1'), (0, 'B'), (-1, 'default2'), (2, 'B'), (3, NULL), (4, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 0, 'default1'), (2, 2, 'default2'), (1, 4, 'B'), (-1, 2, NULL), (3, -1, 'C'), (4, NULL, NULL), (5, 3, 'default2'), (6, 0, 'default1'), (7, 0, 'B'), (8, -1, 'default1'), (9, 1, 'A'), (10, 0, 'default2'), (11, 2, 'A'), (12, 2, 'A'), (13, 2, 'B'), (14, 3, 'C'), (15, 0, 'default1'), (16, 4, 'default2'), (17, 1, 'C'), (18, 0, 'default1'), (19, 3, 'C'), (20, -1, 'default2'), (21, NULL, 'default1'), (22, -1, 'B'), (23, NULL, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(2, 'B')
*/

-- Prediction Query
WITH TABLE_A AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A'), TABLE_B AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B'), TABLE_C AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') SELECT DISTINCT C.CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE C.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM TABLE_A) AND C.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM TABLE_B) AND NOT C.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM TABLE_C) ORDER BY C.CUSTOMER_ID, CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
*/