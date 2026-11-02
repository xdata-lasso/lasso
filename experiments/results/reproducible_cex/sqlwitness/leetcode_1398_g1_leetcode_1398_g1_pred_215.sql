-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, NULL), (1, 'C'), (2, NULL), (0, 'default2'), (3, 'A'), (4, 'A'), (5, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, NULL, 'B'), (1, 4, NULL), (-1, 3, NULL), (0, 0, 'default2'), (3, 2, 'default2'), (4, -1, 'default1'), (5, NULL, 'default1'), (6, 0, NULL), (7, -1, NULL), (8, 0, 'A'), (9, 2, 'default1'), (10, 4, 'A'), (11, 0, 'B'), (12, 0, 'B'), (13, 5, 'A'), (14, 1, 'A'), (15, 3, 'default1'), (16, 3, NULL), (17, 4, 'A'), (18, 0, 'default1'), (19, NULL, 'default1'), (20, 0, 'A'), (21, 0, 'default1'), (22, -1, 'default1'), (23, 2, NULL), (24, 2, 'B'), (25, -1, NULL), (26, 2, 'C'), (27, 0, NULL), (28, NULL, NULL), (29, 4, 'B'), (30, 1, 'A'), (31, NULL, 'C'), (32, 2, 'B'), (33, 1, 'default2'), (34, NULL, 'default1'), (35, 5, 'A'), (36, 5, 'default1'), (37, 2, NULL), (38, NULL, 'A'), (39, 5, 'default2'), (40, 0, 'A'), (41, 2, 'B'), (42, -1, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(0, 'default2')
(4, 'A')
*/

-- Prediction Query
WITH CUSTOMERS_WHO_ORDERED_A AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A'), CUSTOMERS_WHO_ORDERED_B AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B'), CUSTOMERS_WHO_ORDERED_C AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C'), CUSTOMERS_ORDERED_AB_NOT_C AS (SELECT A.CUSTOMER_ID FROM CUSTOMERS_WHO_ORDERED_A AS A CROSS JOIN CUSTOMERS_WHO_ORDERED_B AS B WHERE A.CUSTOMER_ID = B.CUSTOMER_ID AND NOT A.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM CUSTOMERS_WHO_ORDERED_C)) SELECT CU.CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS_ORDERED_AB_NOT_C AS C JOIN CUSTOMERS AS CU ON CU.CUSTOMER_ID = C.CUSTOMER_ID;

/*
Prediction Result:
*/