-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'B'), (0, 'B'), (2, 'A'), (3, 'B'), (4, 'A'), (5, 'default2'), (6, 'A'), (7, 'default2'), (8, 'B'), (9, NULL), (10, 'C'), (11, 'A'), (12, 'A'), (13, 'A'), (14, 'default2'), (15, NULL), (16, 'default2'), (17, 'B'), (18, 'B'), (19, 'C'), (20, 'default1'), (21, 'C'), (22, NULL), (23, 'B'), (24, 'default1'), (25, 'B'), (26, 'C'), (27, 'C'), (28, 'B'), (29, 'C'), (30, 'default2'), (31, 'A'), (32, 'A'), (33, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 11, NULL), (0, 21, 'A'), (2, 6, 'default1'), (3, 0, 'default2'), (4, 31, 'C'), (5, 15, 'default2'), (6, 14, 'B'), (7, 14, 'A'), (8, 28, 'C'), (9, 15, 'B'), (10, 4, 'default1'), (11, 31, 'B'), (12, 23, NULL), (13, 22, 'default2'), (14, 0, 'B'), (15, 14, 'default1'), (16, 33, NULL), (17, 8, 'default1'), (18, NULL, NULL), (19, 13, 'default1'), (20, 17, 'default2'), (21, 1, 'default2'), (22, 11, NULL), (23, 19, 'A'), (24, 6, 'default1'), (25, 19, 'default1'), (26, 17, NULL), (27, 9, 'B'), (28, 26, 'B'), (29, 10, 'default2'), (30, 0, 'A'), (31, 15, NULL), (32, 10, 'A'), (33, 21, 'default2'), (34, 0, 'default2'), (35, 15, 'default1'), (36, 3, 'C'), (37, 27, 'A'), (38, 8, 'default2'), (39, 25, 'default1'), (40, 9, 'B'), (41, 10, 'B'), (42, 24, 'C'), (43, 12, 'default2'), (44, 21, 'B'), (45, 10, 'B'), (46, 16, 'B'), (47, 25, 'A'), (48, 26, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(0, 'B')
(10, 'C')
(14, 'default2')
(21, 'C')
*/

-- Prediction Query
WITH TEMP AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A' AND CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B')) SELECT DISTINCT TEMP.CUSTOMER_ID, C.CUSTOMER_NAME FROM TEMP JOIN CUSTOMERS AS C ON TEMP.CUSTOMER_ID = C.CUSTOMER_ID WHERE NOT TEMP.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(21, 'C')
(14, 'default2')
(0, 'B')
(10, 'C')
*/