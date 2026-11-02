-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'A'), (1, 'B'), (-1, 'default1'), (2, NULL), (3, 'B'), (4, 'C'), (5, 'B'), (6, NULL), (7, 'default1'), (8, 'C'), (9, 'C'), (10, 'C'), (11, 'C'), (12, 'default2'), (13, 'default1'), (14, 'default1'), (15, 'C'), (16, 'A'), (17, 'default2'), (18, 'A'), (19, 'C'), (20, NULL), (21, 'C'), (22, 'C'), (23, 'default1'), (24, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 23, 'C'), (0, 8, 'A'), (2, 3, 'default2'), (1, -1, 'default1'), (3, 8, 'default1'), (4, 19, 'B'), (5, 1, 'B'), (6, NULL, 'C'), (7, 0, 'B'), (8, 13, 'B'), (9, 6, 'C'), (10, 19, 'B'), (11, 0, NULL), (12, 7, 'B'), (13, 7, NULL), (14, 17, 'C'), (15, 21, 'C'), (16, 5, 'default1'), (17, 14, NULL), (18, 3, 'C'), (19, 10, 'B'), (20, 3, NULL), (21, 6, 'A'), (22, 22, NULL), (23, 24, 'B'), (24, 24, 'A'), (25, 23, 'A'), (26, 13, 'B'), (27, -1, 'A'), (28, 9, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(24, None)
*/

-- Prediction Query
WITH CTE AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') SELECT C.CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID FROM ORDERS AS O WHERE PRODUCT_NAME = 'B' AND CUSTOMER_ID IN (SELECT * FROM CTE) AND NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C')) AS K LEFT JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = K.CUSTOMER_ID;

/*
Prediction Result:
*/