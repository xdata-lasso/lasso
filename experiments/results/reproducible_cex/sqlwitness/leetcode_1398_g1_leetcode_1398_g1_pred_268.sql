-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'default2'), (-1, 'default1'), (0, NULL), (2, 'default1'), (3, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, NULL, 'default2'), (2, 2, NULL), (-1, 1, 'default1'), (0, 0, 'default2'), (3, 1, 'default2'), (4, -1, 'default2'), (5, -1, 'B'), (6, -1, NULL), (7, 1, 'B'), (8, 3, 'B'), (9, 0, 'default2'), (10, 3, 'default2'), (11, -1, 'B'), (12, 0, 'A'), (13, 2, 'C'), (14, 0, 'C'), (15, NULL, 'C'), (16, 0, 'B'), (17, NULL, 'default1'), (18, 1, 'default1'), (19, 1, 'default2'), (20, 2, 'C'), (21, 3, 'default2'), (22, 1, NULL), (23, NULL, NULL), (24, 1, 'default2'), (25, 1, 'A'), (26, 1, 'B'), (27, -1, 'default1'), (28, 2, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'default2')
*/

-- Prediction Query
WITH A AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A'), B AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B'), C AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C'), TEMP AS (SELECT CUSTOMER_ID FROM A WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM B) AND NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM C)) SELECT DISTINCT T.CUSTOMER_ID, C.CUSTOMER_NAME FROM TEMP AS T JOIN CUSTOMERS AS C ON T.CUSTOMER_ID = C.CUSTOMER_ID;

/*
Prediction Result:
*/