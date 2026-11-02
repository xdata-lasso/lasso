-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, NULL), (1, 'B'), (2, 'C'), (-1, 'default1'), (3, 'B'), (4, 'C'), (5, 'A'), (6, 'C'), (7, NULL), (8, 'default1'), (9, 'B'), (10, 'default1'), (11, 'default2'), (12, 'A'), (13, 'default2'), (14, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 6, 'default1'), (1, 10, 'B'), (-1, 7, NULL), (0, 2, 'C'), (3, 4, 'A'), (4, -1, 'C'), (5, -1, 'C'), (6, 0, NULL), (7, 13, NULL), (8, 5, NULL), (9, 10, 'A'), (10, 13, 'A'), (11, 1, 'default2'), (12, 3, 'default1'), (13, NULL, 'C'), (14, 5, 'C'), (15, 3, 'B'), (16, 0, NULL), (17, 8, 'C'), (18, 13, 'C'), (19, 5, 'default2'), (20, 9, 'C'), (21, 14, NULL), (22, 5, 'default1'), (23, 13, 'default1'), (24, 9, 'C'), (25, 12, 'A'), (26, 14, 'B'), (27, 10, 'B'), (28, -1, 'C'), (29, 1, 'default1'), (30, 4, 'C'), (31, 0, 'default2'), (32, 3, NULL), (33, 9, 'B'), (34, 6, 'default1'), (35, 5, 'C'), (36, 0, 'A'), (37, 8, 'C'), (38, 2, 'C'), (39, 1, 'B'), (40, NULL, 'default1'), (41, 5, 'default2'), (42, 1, 'B'), (43, 8, 'C'), (44, 7, 'default1'), (45, 7, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH AGG AS (SELECT T1.CUSTOMER_ID, T2.CUSTOMER_NAME, SUM(CASE WHEN T1.PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) AS NUM_A, SUM(CASE WHEN T1.PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) AS NUM_B, SUM(CASE WHEN T1.PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) AS NUM_C FROM ORDERS AS T1 INNER JOIN CUSTOMERS AS T2 ON T1.CUSTOMER_ID = T2.CUSTOMER_ID GROUP BY T1.CUSTOMER_ID) SELECT CUSTOMER_ID, CUSTOMER_NAME FROM AGG WHERE NUM_A > 0 AND NUM_B > 0 AND NUM_C = 0;

/*
Prediction Result:
(10, 'default1')
*/