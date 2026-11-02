-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, NULL), (1, 'default1'), (2, 'B'), (3, 'C'), (4, 'default1'), (5, 'default2'), (6, 'default2'), (7, 'A'), (8, NULL), (9, 'B'), (10, 'default2'), (11, NULL), (12, 'default1'), (13, 'A'), (14, 'A'), (15, 'B'), (16, 'default2'), (17, 'default1'), (18, 'default2'), (19, 'C'), (20, 'default1'), (21, 'A'), (22, 'default2'), (23, 'C'), (24, 'A'), (25, 'A'), (26, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, NULL, 'A'), (0, NULL, 'default2'), (2, 6, 'C'), (3, 23, 'B'), (4, 14, 'B'), (5, 11, 'default1'), (6, 1, 'default2'), (7, 7, 'default1'), (8, 24, 'default2'), (9, 9, 'C'), (10, 23, 'A'), (11, 10, 'C'), (12, 14, 'C'), (13, 10, 'default2'), (14, 10, 'default1'), (15, 6, 'default2'), (16, 18, 'A'), (17, 11, 'B'), (18, 14, 'A'), (19, 24, 'default1'), (20, 26, NULL), (21, 3, 'B'), (22, 9, 'C'), (23, 18, NULL), (24, 26, 'default2'), (25, 2, 'default1'), (26, 23, 'default1'), (27, 14, 'C'), (28, 6, 'C'), (29, 6, 'default2'), (30, 15, 'A'), (31, 12, 'A'), (32, 10, 'A'), (33, 13, 'B'), (34, 8, 'B'), (35, 12, 'B'), (36, NULL, NULL), (37, 23, NULL), (38, 14, 'B'), (39, 17, 'default1'), (40, 5, 'default2'), (41, 25, NULL), (42, 0, 'A'), (43, 10, 'A'), (44, 1, 'B'), (45, 18, 'A'), (46, 13, 'default2'), (47, 9, 'A'), (48, 8, NULL), (49, 16, 'B'), (50, NULL, 'A'), (51, 3, 'default2'), (52, 18, NULL), (53, 4, NULL), (54, 6, 'default2'), (55, 0, NULL), (56, 13, 'B'), (57, 3, 'A'), (58, 19, 'C'), (59, 10, 'default2'), (60, 3, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(3, 'C')
(12, 'default1')
(23, 'C')
*/

-- Prediction Query
SELECT DISTINCT O1.CUSTOMER_ID, C.CUSTOMER_NAME FROM ORDERS AS O1 JOIN ORDERS AS O2 ON O1.CUSTOMER_ID = O2.CUSTOMER_ID LEFT JOIN CUSTOMERS AS C ON O1.CUSTOMER_ID = C.CUSTOMER_ID WHERE O1.PRODUCT_NAME = 'A' AND O2.PRODUCT_NAME = 'B' AND NOT O1.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(23, 'C')
(12, 'default1')
(3, 'C')
*/