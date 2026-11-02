-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'B'), (0, 'C'), (2, 'default1'), (3, 'A'), (4, 'A'), (5, 'default2'), (6, 'B'), (7, 'A'), (8, 'C'), (9, 'default1'), (10, 'B'), (11, 'B'), (12, 'default1'), (13, 'default2'), (14, 'default2'), (15, 'C'), (16, 'default2'), (17, 'B'), (18, 'B'), (19, 'default1'), (20, 'A'), (21, NULL), (22, 'C'), (23, 'B'), (24, 'default2'), (25, 'B'), (26, NULL), (27, 'A'), (28, 'C'), (29, 'A'), (30, NULL), (31, 'A'), (32, NULL), (33, 'A'), (34, 'C'), (35, 'A'), (36, 'default2'), (37, NULL), (38, 'default2'), (39, 'default2'), (40, 'default1'), (41, 'A'), (42, 'A'), (43, 'default1'), (44, 'default2'), (45, 'A'), (46, 'C'), (47, 'B'), (48, 'default2'), (49, 'C'), (50, 'default1'), (51, 'C'), (52, NULL), (53, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 53, 'default1'), (1, 26, NULL), (2, 47, 'B'), (3, 45, NULL), (4, 0, 'default2'), (5, 47, 'A'), (6, 48, 'default2'), (7, 29, 'C'), (8, 45, NULL), (9, 8, 'B'), (10, 7, 'B'), (11, 16, 'default1'), (12, 6, 'default1'), (13, 52, 'C'), (14, 24, NULL), (15, 42, 'default1'), (16, 25, 'B'), (17, 31, 'default1'), (18, 29, 'B'), (19, 42, 'default2'), (20, 15, 'default1'), (21, 20, 'default1'), (22, 16, 'C'), (23, 40, 'C'), (24, 43, NULL), (25, 41, 'default1'), (26, 28, 'default2'), (27, 49, 'default2'), (28, 35, NULL), (29, 42, 'default1'), (30, 48, 'default1'), (31, 10, 'A'), (32, 39, 'B'), (33, 17, 'B'), (34, 35, 'default1'), (35, 22, 'A'), (36, 41, 'A'), (37, 20, NULL), (38, 45, 'default1'), (39, 39, NULL), (40, 15, 'B'), (41, 3, 'default2'), (42, 45, 'default1'), (43, 4, 'C'), (44, 28, 'B'), (45, 10, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(10, 'B')
(47, 'B')
*/

-- Prediction Query
SELECT DISTINCT C1.CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS AS C1 CROSS JOIN ORDERS AS C2 JOIN CUSTOMERS AS C ON C1.CUSTOMER_ID = C2.CUSTOMER_ID AND C.CUSTOMER_ID = C1.CUSTOMER_ID AND (C1.PRODUCT_NAME = 'A' AND C2.PRODUCT_NAME = 'B') WHERE NOT C1.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS AS O WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(47, 'B')
(10, 'B')
*/