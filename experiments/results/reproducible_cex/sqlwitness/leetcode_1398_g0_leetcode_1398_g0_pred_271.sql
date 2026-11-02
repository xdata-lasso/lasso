-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'A'), (1, 'C'), (2, 'C'), (3, 'B'), (4, 'C'), (5, 'default2'), (6, 'default1'), (7, 'default2'), (8, 'A'), (9, 'default1'), (10, 'default1'), (11, 'default2'), (12, 'default1'), (13, 'A'), (14, 'B'), (15, 'A'), (16, 'C'), (17, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, NULL, 'A'), (1, 15, 'C'), (2, 1, NULL), (3, 16, 'C'), (4, 2, 'default2'), (5, 1, 'A'), (6, 6, NULL), (7, 3, NULL), (8, 14, 'default2'), (9, 1, 'default2'), (10, 10, 'default2'), (11, 10, 'C'), (12, 2, NULL), (13, 2, 'A'), (14, 0, 'default1'), (15, 16, 'C'), (16, 11, 'A'), (17, 10, 'default1'), (18, 11, 'B'), (19, 1, 'B'), (20, 15, 'A'), (21, 6, 'default2'), (22, 5, NULL), (23, 14, 'B'), (24, 13, 'default2'), (25, 4, 'default1'), (26, 14, 'default2'), (27, 2, 'C'), (28, 5, 'B'), (29, 6, 'C'), (30, 5, 'B'), (31, 0, NULL), (32, 15, 'default1'), (33, 17, 'B'), (34, NULL, 'default1'), (35, 15, 'default2'), (36, 13, 'default1'), (37, 1, NULL), (38, 6, 'B'), (39, 12, 'default2'), (40, NULL, NULL), (41, 3, 'A'), (42, 12, 'C'), (43, 5, 'B'), (44, 0, 'B'), (45, 11, 'B'), (46, 5, 'A'), (47, 15, 'A'), (48, 4, 'A'), (49, 14, 'default1'), (50, 11, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'C')
(5, 'default2')
(11, 'default2')
*/

-- Prediction Query
WITH T AS (SELECT CUSTOMER_ID FROM ORDERS AS O WHERE PRODUCT_NAME = 'B' AND CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C')) SELECT T.CUSTOMER_ID, C.CUSTOMER_NAME FROM T JOIN CUSTOMERS AS C ON T.CUSTOMER_ID = C.CUSTOMER_ID;

/*
Prediction Result:
(11, 'default2')
(1, 'C')
(5, 'default2')
(5, 'default2')
(5, 'default2')
(11, 'default2')
*/