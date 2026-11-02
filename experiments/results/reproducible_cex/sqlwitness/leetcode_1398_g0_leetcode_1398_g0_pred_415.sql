-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'A'), (1, NULL), (2, 'default1'), (3, 'default1'), (4, NULL), (5, 'C'), (6, 'B'), (7, 'default1'), (8, 'B'), (9, 'default2'), (10, 'B'), (11, 'default1'), (12, 'default1'), (13, 'default1'), (14, 'C'), (15, 'A'), (16, 'default2'), (17, 'C'), (18, 'default1'), (19, 'default1'), (20, 'default2'), (21, 'C'), (22, 'A'), (23, 'C'), (24, NULL), (25, 'default2'), (26, 'A'), (27, 'C'), (28, 'default2'), (29, 'C'), (30, 'B'), (31, 'default1'), (32, 'default2'), (33, 'B'), (34, 'C'), (35, 'B'), (36, 'default1'), (37, 'default1'), (38, 'default2'), (39, 'A'), (40, 'A'), (41, 'A'), (42, 'default1'), (43, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 7, NULL), (1, 15, 'default2'), (2, 23, NULL), (3, 33, 'C'), (4, 0, 'default1'), (5, 9, 'default1'), (6, 15, 'C'), (7, 38, 'default2'), (8, 35, 'A'), (9, 1, 'B'), (10, 24, 'A'), (11, 3, 'default2'), (12, 19, NULL), (13, 6, 'default1'), (14, 31, 'C'), (15, 2, 'B'), (16, 9, 'C'), (17, 3, 'A'), (18, 35, 'A'), (19, 10, 'A'), (20, 26, NULL), (21, 9, 'default2'), (22, 43, 'default2'), (23, 4, 'A'), (24, 15, 'A'), (25, 2, 'default2'), (26, 37, 'C'), (27, 30, 'A'), (28, 2, 'A'), (29, 20, 'default1'), (30, 12, 'A'), (31, 25, 'C'), (32, 17, 'A'), (33, 32, 'default2'), (34, 23, 'default1'), (35, 18, 'B'), (36, 35, 'default2'), (37, 35, 'default2'), (38, 28, NULL), (39, 7, 'B'), (40, 42, 'default2'), (41, 27, 'default1'), (42, 21, 'B'), (43, 43, 'default1'), (44, 3, 'default2'), (45, 23, 'default2'), (46, 25, 'default2'), (47, 3, 'B'), (48, 22, 'default2'), (49, 30, 'C'), (50, 16, 'default1'), (51, 4, NULL), (52, 29, NULL), (53, 10, 'B'), (54, 22, 'default2'), (55, 11, 'C'), (56, 5, 'default1'), (57, 26, 'A'), (58, 18, 'B'), (59, 37, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(2, 'default1')
(3, 'default1')
(10, 'B')
*/

-- Prediction Query
SELECT DISTINCT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM ORDERS AS O1 JOIN ORDERS AS O2 ON O1.CUSTOMER_ID = O2.CUSTOMER_ID JOIN CUSTOMERS AS C ON O1.CUSTOMER_ID = C.CUSTOMER_ID WHERE O1.PRODUCT_NAME = 'A' AND O2.PRODUCT_NAME = 'B' AND NOT O1.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(3, 'default1')
(10, 'B')
(2, 'default1')
*/