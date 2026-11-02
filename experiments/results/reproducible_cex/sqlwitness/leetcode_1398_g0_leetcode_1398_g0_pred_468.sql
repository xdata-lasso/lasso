-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'B'), (0, 'C'), (2, 'A'), (3, 'default1'), (4, 'A'), (5, 'C'), (6, 'default2'), (7, NULL), (8, 'C'), (9, NULL), (10, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 3, 'A'), (0, 10, 'default2'), (2, 5, NULL), (3, 5, 'default2'), (4, 5, 'C'), (5, 7, 'default1'), (6, 5, 'B'), (7, 7, 'default2'), (8, 1, 'default2'), (9, 3, 'B'), (10, NULL, 'B'), (11, 4, NULL), (12, 6, 'A'), (13, 7, 'A'), (14, 2, NULL), (15, 6, NULL), (16, 4, 'default2'), (17, 0, 'A'), (18, 4, 'default2'), (19, 4, 'default2'), (20, 4, 'A'), (21, 1, 'A'), (22, 1, 'B'), (23, 1, NULL), (24, 10, 'default1'), (25, 8, 'B'), (26, 8, 'B'), (27, 7, 'default1'), (28, 10, 'default1'), (29, 8, 'default2'), (30, 9, 'C'), (31, 4, 'C'), (32, 10, NULL), (33, 4, 'C'), (34, 7, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'B')
(3, 'default1')
*/

-- Prediction Query
WITH CTEC AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C'), CTEB AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') SELECT T.CUSTOMER_ID, C.CUSTOMER_NAME FROM (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE (PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT * FROM CTEB) AND NOT CUSTOMER_ID IN (SELECT * FROM CTEC)) AS T LEFT JOIN CUSTOMERS AS C ON T.CUSTOMER_ID = C.CUSTOMER_ID;

/*
Prediction Result:
(3, 'default1')
(1, 'B')
*/