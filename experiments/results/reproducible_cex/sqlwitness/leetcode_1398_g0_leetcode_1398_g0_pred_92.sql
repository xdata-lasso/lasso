-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, NULL), (-1, 'default2'), (1, 'default1'), (0, NULL), (3, 'C'), (4, 'default2'), (5, 'default2'), (6, 'B'), (7, 'B'), (8, NULL), (9, 'B'), (10, NULL), (11, 'A'), (12, 'B'), (13, 'default2'), (14, 'default1'), (15, 'B'), (16, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 5, 'default1'), (1, 4, 'default2'), (2, NULL, 'default1'), (0, 14, 'default1'), (3, 3, 'B'), (4, 10, 'A'), (5, 5, 'B'), (6, 5, 'A'), (7, 12, 'C'), (8, 2, 'default2'), (9, 7, 'default2'), (10, 15, 'C'), (11, 12, 'A'), (12, 11, 'A'), (13, 14, 'A'), (14, NULL, 'C'), (15, 12, 'default2'), (16, 10, NULL), (17, 4, 'C'), (18, 15, 'default1'), (19, 5, 'default2'), (20, 2, 'A'), (21, 1, 'B'), (22, 2, 'B'), (23, 10, NULL), (24, 3, 'C'), (25, 9, 'B'), (26, 9, 'default1'), (27, 15, 'B'), (28, 6, NULL), (29, 6, 'default1'), (30, 3, 'default1'), (31, 2, 'B'), (32, 6, 'default2'), (33, 15, 'default2'), (34, 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH TEMP AS (SELECT CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) AS A, SUM(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) AS B, SUM(CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) AS C FROM ORDERS GROUP BY CUSTOMER_ID) SELECT T.CUSTOMER_ID, C.CUSTOMER_NAME FROM TEMP AS T JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = T.CUSTOMER_ID WHERE T.A > 0 AND T.B > 0 AND T.C = 0;

/*
Prediction Result:
(2, None)
(5, 'default2')
*/