-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default2'), (1, 'default2'), (2, 'default2'), (3, 'C'), (4, 'default1'), (5, 'default2'), (6, 'B'), (7, 'default2'), (8, 'A'), (9, 'C'), (10, 'A'), (11, 'B'), (12, 'default1'), (13, 'default2'), (14, 'default1'), (15, 'default2'), (16, 'A'), (17, NULL), (18, 'B'), (19, 'default1'), (20, 'C'), (21, NULL), (22, 'A'), (23, 'default1'), (24, 'B'), (25, 'B'), (26, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 10, NULL), (0, 19, 'default1'), (2, 26, 'A'), (3, 16, 'C'), (4, 26, NULL), (5, 8, NULL), (6, 5, 'B'), (7, 15, NULL), (8, 17, NULL), (9, 25, 'A'), (10, 5, 'A'), (11, 15, 'A'), (12, 15, 'default2'), (13, 9, NULL), (14, 24, NULL), (15, 11, 'default1'), (16, 19, 'B'), (17, 16, NULL), (18, 20, 'default2'), (19, 15, 'default1'), (20, 24, 'A'), (21, 8, 'A'), (22, 24, 'B'), (23, 1, 'C'), (24, 22, 'A'), (25, 11, 'C'), (26, 12, 'B'), (27, 16, 'C'), (28, 15, NULL), (29, 22, 'B'), (30, 17, 'C'), (31, 21, 'default1'), (32, 1, NULL), (33, 14, 'B'), (34, 1, NULL), (35, 6, NULL), (36, 11, 'B'), (37, 15, 'default1'), (38, 11, 'A'), (39, NULL, 'default1'), (40, 15, 'B'), (41, 2, 'B'), (42, 11, 'default2'), (43, 13, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(5, 'default2')
(15, 'default2')
(22, 'A')
(24, 'B')
*/

-- Prediction Query
WITH CUSTOMERS_WHO_ORDERED_A AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A'), CUSTOMERS_WHO_ORDERED_B AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B'), CUSTOMERS_WHO_ORDERED_C AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C'), CUSTOMERS_ORDERED_AB_NOT_C AS (SELECT A.CUSTOMER_ID FROM CUSTOMERS_WHO_ORDERED_A AS A CROSS JOIN CUSTOMERS_WHO_ORDERED_B AS B WHERE A.CUSTOMER_ID = B.CUSTOMER_ID AND NOT A.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM CUSTOMERS_WHO_ORDERED_C)) SELECT CU.CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS_ORDERED_AB_NOT_C AS C JOIN CUSTOMERS AS CU ON CU.CUSTOMER_ID = C.CUSTOMER_ID;

/*
Prediction Result:
(5, 'default2')
(15, 'default2')
(24, 'B')
(22, 'A')
*/