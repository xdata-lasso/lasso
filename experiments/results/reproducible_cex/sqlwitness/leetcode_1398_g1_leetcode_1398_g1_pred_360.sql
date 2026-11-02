-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, NULL), (2, 'A'), (-1, 'C'), (0, 'default1'), (3, 'A'), (4, 'A'), (5, 'C'), (6, 'A'), (7, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 7, 'B'), (0, 3, 'default1'), (-1, 3, 'B'), (1, -1, NULL), (3, 7, 'default1'), (4, 1, 'C'), (5, NULL, 'default1'), (6, 3, NULL), (7, 6, NULL), (8, NULL, 'default1'), (9, 0, 'default2'), (10, 7, 'default2'), (11, 2, 'default1'), (12, 2, 'C'), (13, 1, NULL), (14, 6, 'default1'), (15, 4, NULL), (16, -1, 'A'), (17, 5, 'B'), (18, 3, 'A'), (19, NULL, NULL), (20, 1, 'default2'), (21, NULL, 'default2'), (22, 6, 'default2'), (23, -1, 'default2'), (24, 0, 'default1'), (25, NULL, 'C'), (26, 2, 'B'), (27, 5, NULL), (28, -1, NULL), (29, 5, 'C'), (30, 1, 'default2'), (31, 1, 'default1'), (32, 0, 'A'), (33, NULL, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(3, 'A')
*/

-- Prediction Query
WITH CTE AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A' AND CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C')) SELECT A.CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS AS A JOIN CTE AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID;

/*
Prediction Result:
*/