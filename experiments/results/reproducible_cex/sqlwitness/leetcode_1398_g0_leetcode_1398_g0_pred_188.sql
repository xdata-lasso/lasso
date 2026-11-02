-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, NULL), (1, NULL), (2, 'default1'), (3, 'B'), (4, 'A'), (5, 'A'), (6, 'A'), (7, 'C'), (8, 'default2'), (9, 'default2'), (10, NULL), (11, NULL), (12, 'default1'), (13, 'C'), (14, 'default2'), (15, 'C'), (16, 'A'), (17, 'C'), (18, 'A'), (19, 'A'), (20, 'B'), (21, 'C'), (22, 'default2'), (23, 'A'), (24, 'B'), (25, NULL), (26, 'A'), (27, 'default2'), (28, 'default2'), (29, 'default2'), (30, 'B'), (31, NULL), (32, 'C'), (33, 'C'), (34, 'default2'), (35, 'default2'), (36, 'A'), (37, 'default1'), (38, 'B'), (39, 'C'), (40, 'default1'), (41, 'B'), (42, 'default1'), (43, 'C'), (44, 'C'), (45, 'C'), (46, 'C'), (47, 'A'), (48, 'default2'), (49, 'B'), (50, NULL), (51, 'C'), (52, 'default1'), (53, NULL), (54, 'default1'), (55, 'default1'), (56, 'A'), (57, 'default1'), (58, 'C'), (59, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 2, 'B'), (1, 0, 'default2'), (2, 28, NULL), (3, 29, 'default2'), (4, 33, 'A'), (5, 30, NULL), (6, 18, 'B'), (7, 46, 'default2'), (8, 19, 'default2'), (9, 24, 'A'), (10, 52, NULL), (11, 15, 'default2'), (12, 54, 'default1'), (13, 24, 'B'), (14, 31, 'C'), (15, 44, 'default2'), (16, 2, 'A'), (17, 51, 'A'), (18, 2, 'B'), (19, 29, 'default1'), (20, 48, 'B'), (21, 32, 'B'), (22, 1, 'C'), (23, 20, 'default2'), (24, 11, 'A'), (25, 47, 'C'), (26, 23, 'C'), (27, 46, 'A'), (28, 49, 'default1'), (29, 28, 'B'), (30, 9, 'C'), (31, 6, 'B'), (32, 37, NULL), (33, 1, 'C'), (34, 12, 'default2'), (35, 31, 'A'), (36, 13, 'default1'), (37, 4, 'C'), (38, NULL, 'default2'), (39, 27, 'default1'), (40, 48, 'A'), (41, 16, 'default1'), (42, 57, 'default1'), (43, 45, NULL), (44, 2, 'default1'), (45, 33, 'C'), (46, 16, 'default1'), (47, 13, 'default2'), (48, 56, 'A'), (49, 24, 'A'), (50, 1, 'B'), (51, 8, 'B'), (52, 0, 'A'), (53, 58, 'default1'), (54, 35, 'A'), (55, 11, 'A'), (56, 18, 'A'), (57, 43, 'C'), (58, 54, 'default1'), (59, 46, 'A'), (60, 0, 'default2'), (61, 49, 'C'), (62, 29, 'default2'), (63, 7, 'A'), (64, 47, 'default1'), (65, 21, 'B'), (66, 1, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(2, 'default1')
(18, 'A')
(24, 'B')
(48, 'default2')
*/

-- Prediction Query
WITH CTE1 AS (SELECT CUSTOMER_ID FROM ORDERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND PRODUCT_NAME = 'A' AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C')) SELECT CTE1.CUSTOMER_ID, CUSTOMER_NAME FROM CTE1 JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = CTE1.CUSTOMER_ID ORDER BY CTE1.CUSTOMER_ID, C.customer_id NULLS LAST;

/*
Prediction Result:
(2, 'default1')
(18, 'A')
(24, 'B')
(24, 'B')
(48, 'default2')
*/