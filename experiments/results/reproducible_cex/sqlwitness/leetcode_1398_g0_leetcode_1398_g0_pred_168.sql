-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default1'), (1, 'C'), (2, 'A'), (3, 'B'), (4, 'A'), (5, 'default1'), (6, 'C'), (7, 'B'), (8, NULL), (9, 'C'), (10, 'B'), (11, 'B'), (12, 'C'), (13, 'default2'), (14, NULL), (15, 'C'), (16, 'A'), (17, NULL), (18, 'default1'), (19, 'A'), (20, 'default2'), (21, 'default1'), (22, 'C'), (23, 'A'), (24, 'default1'), (25, NULL), (26, 'default2'), (27, 'B'), (28, 'A'), (29, 'A'), (30, 'A'), (31, 'B'), (32, NULL), (33, 'A'), (34, 'A'), (35, NULL), (36, 'default2'), (37, 'B'), (38, 'A'), (39, 'C'), (40, 'default1'), (41, 'A'), (42, 'C'), (43, 'B'), (44, 'B'), (45, 'B'), (46, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 33, 'C'), (0, 23, 'A'), (2, 9, 'default2'), (3, 46, 'A'), (4, 36, 'C'), (5, 4, 'C'), (6, 26, 'default2'), (7, 4, 'default1'), (8, 34, 'default1'), (9, 16, 'default2'), (10, 29, 'default1'), (11, 26, 'A'), (12, 0, NULL), (13, 1, 'default2'), (14, 0, 'default2'), (15, 23, NULL), (16, 5, 'A'), (17, 10, NULL), (18, 21, 'default2'), (19, 10, 'B'), (20, 46, 'B'), (21, 40, 'default2'), (22, 33, NULL), (23, 18, NULL), (24, 28, 'B'), (25, 42, 'default1'), (26, 24, 'default2'), (27, NULL, NULL), (28, 11, 'default2'), (29, 6, 'B'), (30, 27, 'C'), (31, 33, NULL), (32, 22, 'default1'), (33, 43, 'A'), (34, 7, 'default1'), (35, 31, NULL), (36, 28, 'C'), (37, 10, 'A'), (38, 7, NULL), (39, 42, 'default1'), (40, 37, NULL), (41, 15, NULL), (42, 17, 'default1'), (43, 5, 'B'), (44, 45, NULL), (45, 10, 'B'), (46, 31, 'C'), (47, NULL, NULL), (48, 11, 'default2'), (49, 44, 'B'), (50, 38, 'B'), (51, 28, 'A'), (52, 35, NULL), (53, 6, 'default1'), (54, 32, 'A'), (55, 43, 'default1'), (56, 40, 'default1'), (57, 15, 'default1'), (58, 41, NULL), (59, 5, 'C'), (60, 15, 'default1'), (61, 23, 'default2'), (62, 27, 'B'), (63, 38, 'B'), (64, 20, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(10, 'B')
(46, 'B')
*/

-- Prediction Query
SELECT DISTINCT T.CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS AS T JOIN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AS A USING (CUSTOMER_ID) WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(46, 'B')
(10, 'B')
*/