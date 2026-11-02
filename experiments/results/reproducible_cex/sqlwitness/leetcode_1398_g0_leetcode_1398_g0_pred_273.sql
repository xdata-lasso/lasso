-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'A'), (0, 'default2'), (2, 'default1'), (3, 'C'), (4, NULL), (5, NULL), (6, 'A'), (7, 'B'), (8, 'C'), (9, 'default1'), (10, 'A'), (11, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 6, NULL), (0, 4, NULL), (2, 0, 'A'), (3, 11, 'default1'), (4, 11, 'default2'), (5, 9, 'A'), (6, 3, 'default2'), (7, 10, 'B'), (8, 1, NULL), (9, 6, NULL), (10, 6, 'C'), (11, 7, 'default1'), (12, 7, 'A'), (13, 6, 'B'), (14, 11, NULL), (15, 5, NULL), (16, 3, NULL), (17, 10, 'default2'), (18, 11, 'default1'), (19, 6, 'default1'), (20, 10, 'B'), (21, 10, 'default1'), (22, NULL, 'A'), (23, 3, 'default2'), (24, 8, 'B'), (25, 3, 'C'), (26, 7, 'default2'), (27, 11, 'A'), (28, 11, 'B'), (29, NULL, 'default1'), (30, NULL, 'A'), (31, 6, NULL), (32, 6, 'default2'), (33, 5, 'A'), (34, 2, 'default1'), (35, 3, 'B'), (36, 3, 'C'), (37, 6, 'C'), (38, 9, 'default2'), (39, 2, 'B'), (40, 8, NULL), (41, 7, 'A'), (42, 5, 'A'), (43, NULL, 'default1'), (44, 4, NULL), (45, 1, 'B'), (46, 9, 'B'), (47, NULL, 'default2'), (48, 4, 'default1'), (49, NULL, 'A'), (50, 7, 'default1'), (51, 4, 'C'), (52, 8, 'C'), (53, 11, 'A'), (54, 5, 'B'), (55, 5, 'default2'), (56, NULL, 'B'), (57, 9, 'default2'), (58, 8, 'A'), (59, 8, 'C'), (60, 2, 'B'), (61, 5, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(5, None)
(9, 'default1')
(11, None)
*/

-- Prediction Query
SELECT DISTINCT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O1 ON C.CUSTOMER_ID = O1.CUSTOMER_ID AND O1.PRODUCT_NAME = 'A' JOIN ORDERS AS O2 ON C.CUSTOMER_ID = O2.CUSTOMER_ID AND O2.PRODUCT_NAME = 'B' WHERE NOT C.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(9, 'default1')
(11, None)
(5, None)
*/