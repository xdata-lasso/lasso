-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'A'), (1, NULL), (2, 'default2'), (3, 'A'), (4, 'default2'), (5, 'default2'), (6, 'default1'), (7, 'A'), (8, 'default1'), (9, 'default1'), (10, 'B'), (11, 'A'), (12, 'A'), (13, 'default2'), (14, 'default1'), (15, 'default1'), (16, 'default2'), (17, 'C'), (18, NULL), (19, 'C'), (20, 'A'), (21, NULL), (22, 'C'), (23, NULL), (24, 'C'), (25, 'default1'), (26, 'default2'), (27, 'default1'), (28, NULL), (29, 'C'), (30, 'C'), (31, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 22, 'B'), (0, 4, NULL), (2, 3, NULL), (3, 5, 'A'), (4, 1, 'C'), (5, 9, 'A'), (6, 9, 'B'), (7, 4, 'default1'), (8, 20, 'default2'), (9, 12, NULL), (10, 12, 'A'), (11, 23, 'C'), (12, 6, NULL), (13, 29, 'default2'), (14, 2, 'default2'), (15, 0, 'A'), (16, 21, 'C'), (17, 26, 'default2'), (18, 8, 'B'), (19, 19, 'C'), (20, 21, 'A'), (21, 31, 'B'), (22, 18, 'default1'), (23, 10, 'default1'), (24, 8, 'A'), (25, 23, 'default2'), (26, 3, 'C'), (27, 23, 'C'), (28, 15, 'default1'), (29, 2, 'C'), (30, 25, NULL), (31, 22, 'default1'), (32, 11, 'B'), (33, 5, 'A'), (34, 24, 'A'), (35, 29, 'C'), (36, 14, 'C'), (37, 24, 'A'), (38, 3, 'default2'), (39, 14, 'A'), (40, 18, 'default2'), (41, 19, 'C'), (42, 20, 'default2'), (43, 12, 'B'), (44, 31, 'default1'), (45, 28, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(8, 'default1')
(9, 'default1')
(12, 'A')
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, CU.CUSTOMER_NAME FROM (SELECT O1.CUSTOMER_ID, O3.PRODUCT_NAME FROM ORDERS AS O1 LEFT JOIN ORDERS AS O2 ON O1.CUSTOMER_ID = O2.CUSTOMER_ID LEFT JOIN (SELECT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS WHERE PRODUCT_NAME = 'C') AS O3 ON O3.CUSTOMER_ID = O1.CUSTOMER_ID WHERE O1.PRODUCT_NAME = 'A' AND O2.PRODUCT_NAME = 'B') AS C LEFT JOIN CUSTOMERS AS CU ON CU.CUSTOMER_ID = C.CUSTOMER_ID WHERE C.PRODUCT_NAME IS NULL;

/*
Prediction Result:
(9, 'default1')
(12, 'A')
(8, 'default1')
*/