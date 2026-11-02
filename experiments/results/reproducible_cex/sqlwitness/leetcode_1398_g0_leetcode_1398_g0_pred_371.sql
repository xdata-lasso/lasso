-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default1'), (1, 'C'), (2, 'C'), (3, NULL), (4, NULL), (5, 'default1'), (6, 'C'), (7, 'default1'), (8, NULL), (9, 'A'), (10, NULL), (11, 'B'), (12, NULL), (13, NULL), (14, 'C'), (15, 'default1'), (16, 'B'), (17, NULL), (18, 'A'), (19, NULL), (20, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 5, 'C'), (1, 11, 'default2'), (2, 1, NULL), (3, 6, 'default1'), (4, 6, 'default1'), (5, 13, 'default1'), (6, 11, 'B'), (7, 18, 'default2'), (8, 16, 'B'), (9, 8, 'default2'), (10, 3, NULL), (11, 9, 'default2'), (12, 14, 'default2'), (13, 14, NULL), (14, 19, 'default1'), (15, 1, 'A'), (16, 15, 'B'), (17, 0, 'A'), (18, 8, 'default2'), (19, 15, 'C'), (20, 20, NULL), (21, 14, 'A'), (22, 10, 'default1'), (23, 12, NULL), (24, 16, 'A'), (25, 2, 'C'), (26, 18, 'default1'), (27, 0, NULL), (28, 1, 'default1'), (29, 7, 'default1'), (30, 2, NULL), (31, 9, 'default2'), (32, 7, 'B'), (33, 9, 'A'), (34, 14, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(14, 'C')
(16, 'B')
*/

-- Prediction Query
WITH CUSTOMER_TO_MATCH AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C')) SELECT M.CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS AS C JOIN CUSTOMER_TO_MATCH AS M ON C.CUSTOMER_ID = M.CUSTOMER_ID;

/*
Prediction Result:
(16, 'B')
(14, 'C')
*/