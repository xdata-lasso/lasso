-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, NULL), (1, 'C'), (2, 'default2'), (3, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 1, 'default1'), (1, 1, 'A'), (2, NULL, 'default1'), (3, 3, 'default2'), (4, NULL, 'default2'), (5, 3, 'B'), (6, 1, 'A'), (7, 3, 'B'), (8, NULL, 'A'), (9, 2, 'A'), (10, 2, 'default2'), (11, 1, 'B'), (12, NULL, 'default2'), (13, 1, 'B'), (14, NULL, 'B'), (15, NULL, 'default2'), (16, 2, 'A'), (17, NULL, 'default2'), (18, NULL, 'A'), (19, 2, NULL), (20, 0, 'B'), (21, 0, 'A'), (22, 1, 'C'), (23, NULL, 'default2'), (24, 2, 'default2'), (25, 1, 'B'), (26, 3, 'C'), (27, 0, NULL), (28, 3, 'default1'), (29, 2, 'A'), (30, 3, 'default2'), (31, 3, 'A'), (32, 3, 'B'), (33, 2, 'B'), (34, 0, 'C'), (35, 2, 'default1'), (36, 1, 'C'), (37, 1, 'default1'), (38, 0, 'B'), (39, NULL, NULL), (40, 1, 'A'), (41, NULL, 'default2'), (42, 0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(2, 'default2')
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE O.PRODUCT_NAME = 'A' AND C.CUSTOMER_ID IN (SELECT B.CUSTOMER_ID FROM ORDERS AS B WHERE B.PRODUCT_NAME = 'B') AND NOT C.CUSTOMER_ID IN (SELECT C1.CUSTOMER_ID FROM ORDERS AS C1 WHERE C1.PRODUCT_NAME = 'C');

/*
Prediction Result:
(2, 'default2')
(2, 'default2')
(2, 'default2')
*/