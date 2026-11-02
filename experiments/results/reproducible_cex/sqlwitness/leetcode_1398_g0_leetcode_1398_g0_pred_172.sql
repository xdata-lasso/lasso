-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'A'), (1, NULL), (2, NULL), (3, 'B'), (4, 'default2'), (5, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, NULL, 'default2'), (0, 3, 'B'), (2, 1, NULL), (3, NULL, 'default2'), (4, 1, 'default1'), (5, 3, 'default1'), (6, 0, 'C'), (7, 5, 'default1'), (8, 4, 'A'), (9, 1, 'default2'), (10, 2, 'C'), (11, NULL, NULL), (12, 0, 'C'), (13, 2, NULL), (14, 0, 'A'), (15, 4, 'A'), (16, 4, 'default1'), (17, 2, 'C'), (18, 1, NULL), (19, 5, 'A'), (20, 5, NULL), (21, 4, 'A'), (22, 4, 'B'), (23, 3, NULL), (24, 0, 'default1'), (25, 5, 'C'), (26, 4, 'default2'), (27, 0, NULL), (28, NULL, 'default2'), (29, 3, 'default2'), (30, 5, 'A'), (31, 2, 'default2'), (32, 1, 'B'), (33, 0, 'default1'), (34, 4, 'default1'), (35, 1, 'B'), (36, 0, 'default2'), (37, 0, 'default1'), (38, 3, 'default1'), (39, 5, 'C'), (40, 3, 'default1'), (41, 2, 'B'), (42, 1, 'C'), (43, 0, 'B'), (44, NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(4, 'default2')
*/

-- Prediction Query
SELECT O.CUSTOMER_ID, C.CUSTOMER_NAME FROM ORDERS AS O JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE O.PRODUCT_NAME = 'A' AND O.CUSTOMER_ID IN (SELECT O.CUSTOMER_ID FROM ORDERS AS O WHERE O.PRODUCT_NAME = 'B') AND NOT O.CUSTOMER_ID IN (SELECT O.CUSTOMER_ID FROM ORDERS AS O WHERE O.PRODUCT_NAME = 'C');

/*
Prediction Result:
(4, 'default2')
(4, 'default2')
(4, 'default2')
*/