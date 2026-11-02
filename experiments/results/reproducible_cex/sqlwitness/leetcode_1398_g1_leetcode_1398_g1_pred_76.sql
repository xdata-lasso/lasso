-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'default1'), (-1, 'default2'), (0, 'A'), (1, NULL), (3, 'A'), (4, 'default2'), (5, 'C'), (6, 'A'), (7, 'A'), (8, 'A'), (9, 'A'), (10, 'A'), (11, 'B'), (12, 'default1'), (13, 'default2'), (14, NULL), (15, 'B'), (16, 'default1'), (17, 'default1'), (18, 'A'), (19, 'A'), (20, 'default2'), (21, 'default1'), (22, 'B'), (23, 'C'), (24, 'B'), (25, 'default1'), (26, 'C'), (27, NULL), (28, 'B'), (29, 'C'), (30, 'default1'), (31, 'default2'), (32, 'default1'), (33, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 28, NULL), (1, -1, 'A'), (-1, 7, NULL), (2, 2, NULL), (3, 19, 'B'), (4, 3, 'B'), (5, 19, NULL), (6, 15, 'default2'), (7, 12, NULL), (8, 26, 'C'), (9, NULL, 'C'), (10, 6, 'default1'), (11, 2, 'B'), (12, 27, 'default1'), (13, 10, 'B'), (14, 11, 'B'), (15, 19, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(19, 'A')
*/

-- Prediction Query
WITH CUST_CTE AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C')) SELECT C1.CUSTOMER_ID, CUSTOMER_NAME FROM CUST_CTE AS C1 INNER JOIN CUSTOMERS AS C2 ON C1.CUSTOMER_ID = C2.CUSTOMER_ID;

/*
Prediction Result:
*/