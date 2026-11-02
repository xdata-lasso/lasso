-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, NULL), (0, NULL), (2, 'B'), (3, 'B'), (4, 'default2'), (5, 'default1'), (6, NULL), (7, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 6, 'default1'), (0, 4, 'B'), (2, 5, 'C'), (3, 6, 'default2'), (4, 6, 'default1'), (5, 3, 'default1'), (6, 4, NULL), (7, 5, 'B'), (8, NULL, NULL), (9, 0, 'B'), (10, NULL, 'default2'), (11, 1, 'C'), (12, NULL, 'A'), (13, 5, 'default2'), (14, 3, NULL), (15, 0, 'default1'), (16, 3, 'default2'), (17, 0, 'default1'), (18, 6, 'A'), (19, 4, 'B'), (20, 6, 'default2'), (21, 1, 'C'), (22, 0, 'default1'), (23, 2, 'C'), (24, 4, 'A'), (25, 3, 'default1'), (26, 6, 'default1'), (27, 4, 'A'), (28, NULL, 'B'), (29, 6, 'default2'), (30, 7, 'A'), (31, 7, 'default2'), (32, 7, 'B'), (33, NULL, 'default1'), (34, NULL, 'default2'), (35, 0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(4, 'default2')
(7, 'default1')
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS AS O LEFT JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID WHERE PRODUCT_NAME = 'A' AND C.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT C.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(4, 'default2')
(4, 'default2')
(7, 'default1')
*/