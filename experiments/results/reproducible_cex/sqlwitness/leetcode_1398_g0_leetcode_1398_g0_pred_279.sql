-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'B'), (1, 'B'), (2, NULL), (3, NULL), (4, 'A'), (5, 'B'), (6, 'default2'), (7, NULL), (8, 'A'), (9, 'C'), (10, 'B'), (11, 'C'), (12, 'C'), (13, 'default2'), (14, 'A'), (15, 'A'), (16, 'B'), (17, 'default2'), (18, 'B'), (19, 'default1'), (20, 'B'), (21, NULL), (22, 'default2'), (23, NULL), (24, 'C'), (25, 'C'), (26, 'default2'), (27, NULL), (28, 'A'), (29, 'default2'), (30, 'default2'), (31, 'B'), (32, 'A'), (33, 'A'), (34, 'default1'), (35, NULL), (36, 'C'), (37, 'C'), (38, 'B'), (39, 'default2'), (40, NULL), (41, 'C'), (42, NULL), (43, 'A'), (44, 'C'), (45, NULL), (46, 'A'), (47, 'C'), (48, 'default1'), (49, 'default2'), (50, 'default1'), (51, 'default1'), (52, 'C'), (53, 'A'), (54, 'default2'), (55, 'A'), (56, 'default2'), (57, 'default2'), (58, 'default1'), (59, 'A'), (60, 'B'), (61, 'default1'), (62, 'B'), (63, 'default2'), (64, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 12, 'A'), (0, 7, 'C'), (2, 5, NULL), (3, 3, 'A'), (4, 43, 'default2'), (5, 12, 'A'), (6, 45, NULL), (7, 43, 'default2'), (8, 33, 'default2'), (9, 63, 'A'), (10, 12, 'default2'), (11, 8, NULL), (12, 24, 'B'), (13, 53, 'default1'), (14, 32, 'default1'), (15, NULL, NULL), (16, 17, 'B'), (17, 25, 'B'), (18, 35, 'default2'), (19, 42, 'default1'), (20, 38, 'A'), (21, 28, 'default2'), (22, 8, 'default1'), (23, 52, 'C'), (24, 48, 'default1'), (25, 63, 'A'), (26, 29, NULL), (27, 17, 'default2'), (28, 45, 'B'), (29, 21, 'default2'), (30, 43, 'default2'), (31, 8, 'default2'), (32, 31, 'B'), (33, 40, NULL), (34, 50, 'A'), (35, 3, 'B'), (36, 8, NULL), (37, 36, 'default2'), (38, 19, 'C'), (39, 4, 'default2'), (40, 47, 'A'), (41, 19, NULL), (42, 53, 'B'), (43, 15, 'A'), (44, 12, 'B'), (45, 15, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(3, None)
(12, 'C')
*/

-- Prediction Query
SELECT Y.CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS AS C JOIN (SELECT CUSTOMER_ID FROM (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A' AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B')) AS X WHERE NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C')) AS Y ON C.CUSTOMER_ID = Y.CUSTOMER_ID;

/*
Prediction Result:
(12, 'C')
(3, None)
*/