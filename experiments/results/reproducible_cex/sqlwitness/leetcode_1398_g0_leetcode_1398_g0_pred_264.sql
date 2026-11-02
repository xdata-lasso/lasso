-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'B'), (2, 'B'), (1, 'A'), (-1, 'default1'), (3, 'default1'), (4, 'C'), (5, NULL), (6, NULL), (7, 'A'), (8, NULL), (9, NULL), (10, 'default2'), (11, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, -1, 'B'), (-1, 9, NULL), (0, 10, 'B'), (2, 4, 'C'), (3, 7, 'A'), (4, 1, 'A'), (5, 1, 'default2'), (6, NULL, 'C'), (7, -1, 'C'), (8, 1, 'A'), (9, NULL, NULL), (10, 1, 'B'), (11, 10, 'default2'), (12, 1, NULL), (13, 9, 'B'), (14, 3, NULL), (15, 0, 'B'), (16, 9, 'B'), (17, 4, 'default2'), (18, 7, NULL), (19, 11, 'default2'), (20, 2, 'default1'), (21, NULL, 'A'), (22, 9, NULL), (23, 5, NULL), (24, 8, 'C'), (25, 11, 'default2'), (26, 6, NULL), (27, 7, 'default2'), (28, 10, 'B'), (29, 6, 'A'), (30, 0, 'B'), (31, 6, 'A'), (32, 4, 'C'), (33, 0, 'A'), (34, 7, 'A'), (35, 11, 'default2'), (36, 5, 'default1'), (37, -1, NULL), (38, -1, 'default2'), (39, 1, 'default2'), (40, NULL, 'A'), (41, 5, 'B'), (42, 11, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) AS A_BUY, SUM(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) AS B_BUY, SUM(CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) AS C_BUY FROM ORDERS GROUP BY CUSTOMER_ID) SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C LEFT JOIN CTE ON C.CUSTOMER_ID = CTE.CUSTOMER_ID WHERE CTE.A_BUY >= 1 AND CTE.B_BUY >= 1 AND CTE.C_BUY = 0;

/*
Prediction Result:
(0, 'B')
(1, 'A')
*/