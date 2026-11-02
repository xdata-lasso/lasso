-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'A'), (0, 'default1'), (2, 'A'), (3, 'A'), (4, 'A'), (5, 'C'), (6, NULL), (7, NULL), (8, 'A'), (9, 'default2'), (10, 'default1'), (11, 'default2'), (12, 'A'), (13, 'default2'), (14, 'A'), (15, 'B'), (16, 'default2'), (17, 'B'), (18, 'B'), (19, 'C'), (20, 'default2'), (21, 'default1'), (22, 'C'), (23, 'default2'), (24, 'B'), (25, 'C'), (26, 'default2'), (27, NULL), (28, 'B'), (29, 'A'), (30, 'A'), (31, 'C'), (32, 'default2'), (33, 'C'), (34, NULL), (35, 'default1'), (36, 'default2'), (37, 'B'), (38, 'default2'), (39, 'default2'), (40, 'default2'), (41, 'C'), (42, 'default2'), (43, 'B'), (44, 'default1'), (45, 'C'), (46, 'B'), (47, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 33, 'A'), (1, 29, 'A'), (2, 18, NULL), (3, 25, NULL), (4, 15, 'A'), (5, 15, NULL), (6, 7, 'default2'), (7, 13, 'C'), (8, 34, 'default2'), (9, 11, 'default2'), (10, 44, 'C'), (11, 14, 'B'), (12, 34, 'default1'), (13, 10, 'default2'), (14, 4, 'B'), (15, 9, 'C'), (16, 25, 'A'), (17, 14, NULL), (18, NULL, 'default2'), (19, 45, NULL), (20, 7, 'default1'), (21, 34, 'A'), (22, 2, 'default1'), (23, 8, 'A'), (24, 42, 'B'), (25, 8, 'B'), (26, 45, 'C'), (27, 8, 'A'), (28, 31, 'C'), (29, 44, 'default1'), (30, 32, 'A'), (31, 47, 'default2'), (32, 3, 'C'), (33, 34, 'B'), (34, 13, 'default2'), (35, 40, 'default2'), (36, 44, 'B'), (37, 4, 'default2'), (38, 26, NULL), (39, 7, 'A'), (40, 39, NULL), (41, 24, 'C'), (42, 19, 'B'), (43, 44, NULL), (44, 31, 'A'), (45, 9, 'B'), (46, 5, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(8, 'A')
(34, None)
*/

-- Prediction Query
SELECT DISTINCT (O.CUSTOMER_ID), C.CUSTOMER_NAME FROM CUSTOMERS AS C INNER JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE O.CUSTOMER_ID IN (SELECT DISTINCT (O1.CUSTOMER_ID) FROM ORDERS AS O1 INNER JOIN ORDERS AS O2 ON O1.CUSTOMER_ID = O2.CUSTOMER_ID WHERE O1.PRODUCT_NAME = 'A' AND O2.PRODUCT_NAME = 'B') AND NOT O.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(34, None)
(8, 'A')
*/