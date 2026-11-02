-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default2'), (1, 'A'), (-1, 'B'), (2, 'default1'), (3, 'default2'), (4, 'A'), (5, 'default1'), (6, NULL), (7, NULL), (8, 'default1'), (9, 'default2'), (10, 'B'), (11, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, NULL, NULL), (2, NULL, NULL), (1, 5, 'C'), (-1, 4, NULL), (3, NULL, NULL), (4, 11, 'A'), (5, 3, 'A'), (6, 3, 'default1'), (7, NULL, 'C'), (8, 6, 'B'), (9, 7, 'default1'), (10, -1, 'default1'), (11, 9, 'default1'), (12, 9, 'C'), (13, 2, 'default2'), (14, 1, 'default2'), (15, NULL, 'C'), (16, 0, NULL), (17, 11, 'C'), (18, -1, 'C'), (19, 4, NULL), (20, 5, 'C'), (21, 6, 'A'), (22, 9, 'default2'), (23, -1, 'B'), (24, 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH TEMP AS (SELECT CUSTOMER_ID, MAX(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) AS COL_A, MAX(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) AS COL_B, MAX(CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) AS COL_C FROM ORDERS GROUP BY CUSTOMER_ID) SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C JOIN TEMP AS T ON C.CUSTOMER_ID = T.CUSTOMER_ID WHERE T.COL_A = 1 AND T.COL_B = 1 AND T.COL_C = 0;

/*
Prediction Result:
(6, None)
*/