-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'A'), (-1, NULL), (2, 'A'), (0, NULL), (3, 'A'), (4, 'default2'), (5, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 4, 'A'), (0, 4, 'C'), (1, 0, 'C'), (-1, 5, 'C'), (3, 2, 'default1'), (4, -1, 'C'), (5, 1, 'C'), (6, 4, 'C'), (7, 4, 'C'), (8, 5, 'default2'), (9, NULL, 'default1'), (10, 5, 'C'), (11, 5, 'A'), (12, 1, 'C'), (13, NULL, 'default1'), (14, 1, 'A'), (15, 2, 'default1'), (16, 2, 'default2'), (17, 2, NULL), (18, 4, 'B'), (19, 2, 'default2'), (20, 2, 'B'), (21, 4, 'default2'), (22, 4, NULL), (23, 1, 'B'), (24, 4, NULL), (25, -1, 'B'), (26, 3, NULL), (27, -1, NULL), (28, -1, 'B'), (29, 2, NULL), (30, NULL, 'B'), (31, -1, 'A'), (32, 1, 'B'), (33, -1, NULL), (34, -1, 'default2'), (35, NULL, 'default1'), (36, NULL, 'C'), (37, 2, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) AS CNTA, SUM(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) AS CNTB, SUM(CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) AS CNTC FROM ORDERS GROUP BY CUSTOMER_ID) SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C INNER JOIN CTE ON C.CUSTOMER_ID = CTE.CUSTOMER_ID WHERE CTE.CNTA > 0 AND CTE.CNTB > 0 AND CTE.CNTC = 0;

/*
Prediction Result:
(2, 'A')
*/