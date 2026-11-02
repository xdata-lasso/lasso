-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'default1'), (0, 'default1'), (-1, 'default2'), (1, 'A'), (3, 'default1'), (4, 'default1'), (5, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 0, NULL), (2, 5, 'A'), (0, 5, 'B'), (-1, 1, NULL), (3, 3, 'default2'), (4, 0, 'default1'), (5, -1, 'B'), (6, 2, NULL), (7, 5, 'default2'), (8, NULL, 'C'), (9, -1, 'B'), (10, 3, 'A'), (11, 2, 'A'), (12, 2, 'A'), (13, -1, 'C'), (14, 5, 'default2'), (15, NULL, 'B'), (16, -1, 'C'), (17, 3, 'C'), (18, 4, 'A'), (19, -1, NULL), (20, 1, 'C'), (21, 4, 'A'), (22, 4, 'C'), (23, 1, 'default1'), (24, NULL, 'default1'), (25, 2, NULL), (26, 5, 'default1'), (27, 2, 'B'), (28, 0, 'default1'), (29, NULL, NULL), (30, -1, 'A'), (31, -1, 'default1'), (32, 5, 'C'), (33, -1, NULL), (34, 3, 'default2'), (35, -1, 'B'), (36, 5, 'C'), (37, 5, 'default1'), (38, 0, 'default2'), (39, 3, 'A'), (40, 3, 'A'), (41, -1, 'default2'), (42, NULL, 'C'), (43, 2, 'default1'), (44, 5, 'default2'), (45, NULL, 'default2'), (46, 0, 'C'), (47, -1, 'B'), (48, 4, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C INNER JOIN (SELECT CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) AS A, SUM(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) AS B, SUM(CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS M ON C.CUSTOMER_ID = M.CUSTOMER_ID WHERE M.A > 0 AND M.B > 0 AND M.C = 0;

/*
Prediction Result:
(2, 'default1')
*/