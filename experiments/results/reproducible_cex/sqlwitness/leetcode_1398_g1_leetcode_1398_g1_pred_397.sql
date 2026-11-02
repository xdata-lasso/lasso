-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'default1'), (1, 'default1'), (0, 'default2'), (2, 'A'), (3, 'C'), (4, NULL), (5, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 5, 'C'), (0, 1, NULL), (1, NULL, 'B'), (2, NULL, NULL), (3, 0, 'C'), (4, 1, 'A'), (5, 5, 'default2'), (6, 1, 'A'), (7, 1, 'default2'), (8, 5, 'default2'), (9, 0, 'default1'), (10, 3, 'B'), (11, 2, NULL), (12, -1, 'B'), (13, 3, 'A'), (14, 2, 'A'), (15, 0, 'B'), (16, -1, NULL), (17, 5, 'default1'), (18, NULL, 'C'), (19, 3, 'default2'), (20, 1, 'B'), (21, 4, 'C'), (22, 1, 'A'), (23, NULL, 'default1'), (24, -1, 'B'), (25, NULL, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'default1')
(3, 'C')
*/

-- Prediction Query
WITH TEMP1 AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A'), TEMP2 AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B'), TEMP3 AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM TEMP1) AND CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM TEMP2) AND NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM TEMP3) ORDER BY CUSTOMER_ID;

/*
Prediction Result:
*/