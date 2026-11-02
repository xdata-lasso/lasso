-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'C'), (1, NULL), (2, 'default2'), (3, 'A'), (4, 'default2'), (5, 'C'), (6, 'B'), (7, 'C'), (8, 'default1'), (9, 'default2'), (10, NULL), (11, NULL), (12, 'default1'), (13, 'default2'), (14, NULL), (15, 'default1'), (16, 'default2'), (17, 'B'), (18, 'A'), (19, 'default1'), (20, NULL), (21, 'A'), (22, 'default2'), (23, 'B'), (24, 'B'), (25, 'C'), (26, NULL), (27, 'C'), (28, 'A'), (29, 'default1'), (30, 'default1'), (31, NULL), (32, 'default1'), (33, 'default2'), (34, NULL), (35, 'A'), (36, 'default2'), (37, 'default2'), (38, 'B'), (39, NULL), (40, 'A'), (41, 'B'), (42, 'B'), (43, 'C'), (44, 'default2'), (45, 'B'), (46, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 11, 'default1'), (0, 29, 'C'), (2, 29, 'default2'), (3, 28, 'C'), (4, 17, 'default2'), (5, 6, 'B'), (6, 1, 'A'), (7, 11, NULL), (8, 1, 'B'), (9, 23, 'A'), (10, 24, 'C'), (11, 27, 'B'), (12, 38, 'default2'), (13, 12, 'A'), (14, 42, NULL), (15, 13, 'C'), (16, 0, 'A'), (17, 41, 'default2'), (18, 6, 'A'), (19, 38, 'C'), (20, 5, NULL), (21, 41, 'default1'), (22, 30, 'default1'), (23, 16, 'A'), (24, 5, 'default1'), (25, 36, 'default2'), (26, 39, 'A'), (27, 16, 'B'), (28, 24, 'default2'), (29, 5, 'default2'), (30, 41, 'default2'), (31, 21, 'default1'), (32, 30, 'A'), (33, 36, 'default1'), (34, 13, 'C'), (35, 8, NULL), (36, 36, 'A'), (37, 40, 'default2'), (38, 27, 'C'), (39, 3, 'A'), (40, 22, 'C'), (41, 33, 'B'), (42, 4, 'A'), (43, 19, 'A'), (44, 15, 'B'), (45, 35, 'default1'), (46, 31, 'default2'), (47, 33, 'C'), (48, 21, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, None)
(6, 'B')
(16, 'default2')
*/

-- Prediction Query
SELECT DISTINCT O.CUSTOMER_ID AS CUSTOMER_ID, C.CUSTOMER_NAME AS CUSTOMER_NAME FROM ORDERS AS O LEFT JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID WHERE O.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND O.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT O.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(6, 'B')
(1, None)
(16, 'default2')
*/