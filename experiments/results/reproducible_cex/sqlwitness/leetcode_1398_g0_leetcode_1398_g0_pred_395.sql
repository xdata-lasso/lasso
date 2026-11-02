-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, NULL), (0, 'A'), (2, 'C'), (3, 'A'), (4, 'A'), (5, 'A'), (6, 'A'), (7, NULL), (8, 'B'), (9, 'default2'), (10, 'default2'), (11, 'B'), (12, 'B'), (13, 'default1'), (14, 'default1'), (15, 'B'), (16, 'default2'), (17, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 13, 'default1'), (1, 11, 'A'), (2, 6, 'C'), (3, 0, 'default2'), (4, 4, 'A'), (5, 5, 'B'), (6, 2, 'default1'), (7, 15, 'A'), (8, 11, 'C'), (9, 16, 'default2'), (10, 14, 'C'), (11, 12, 'default1'), (12, 5, 'B'), (13, 1, 'default1'), (14, 11, 'default2'), (15, 16, 'A'), (16, 9, 'default1'), (17, 13, 'A'), (18, 17, NULL), (19, 4, NULL), (20, 9, 'C'), (21, 4, 'B'), (22, 15, 'C'), (23, 14, 'default1'), (24, 2, NULL), (25, 7, NULL), (26, 13, 'B'), (27, 16, 'B'), (28, 7, 'default2'), (29, 7, 'B'), (30, 12, 'B'), (31, 9, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(4, 'A')
(13, 'default1')
(16, 'default2')
*/

-- Prediction Query
SELECT DISTINCT U.CUSTOMER_ID, U.CUSTOMER_NAME FROM (SELECT C.CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS AS O JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID WHERE PRODUCT_NAME = 'A') AS U JOIN (SELECT C.CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS AS O JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID WHERE PRODUCT_NAME = 'B') AS T ON T.CUSTOMER_ID = U.CUSTOMER_ID WHERE NOT U.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(4, 'A')
(16, 'default2')
(13, 'default1')
*/