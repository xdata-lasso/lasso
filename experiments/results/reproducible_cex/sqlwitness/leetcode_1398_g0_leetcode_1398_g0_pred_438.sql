-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'default1'), (0, 'A'), (2, 'default1'), (3, 'B'), (4, 'B'), (5, NULL), (6, NULL), (7, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 5, 'default1'), (1, 1, 'default1'), (2, 4, NULL), (3, 1, 'C'), (4, 6, 'B'), (5, 6, 'default2'), (6, 3, 'default2'), (7, 0, 'C'), (8, 7, NULL), (9, 3, 'default2'), (10, NULL, 'C'), (11, 6, NULL), (12, 3, NULL), (13, 4, 'C'), (14, 1, 'A'), (15, 3, 'A'), (16, 2, NULL), (17, 6, 'B'), (18, 3, 'B'), (19, 1, 'B'), (20, NULL, NULL), (21, 6, 'A'), (22, 5, 'C'), (23, NULL, NULL), (24, 1, NULL), (25, 0, 'B'), (26, 5, 'C'), (27, 7, NULL), (28, NULL, 'C'), (29, 0, 'B'), (30, 4, 'default2'), (31, 4, 'B'), (32, NULL, 'default1'), (33, 3, 'default1'), (34, 1, 'B'), (35, 4, 'A'), (36, 6, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C WHERE EXISTS(SELECT * FROM ORDERS AS O WHERE C.CUSTOMER_ID = O.CUSTOMER_ID AND PRODUCT_NAME = 'A') AND EXISTS(SELECT * FROM ORDERS AS O WHERE C.CUSTOMER_ID = O.CUSTOMER_ID AND PRODUCT_NAME = 'B') AND NOT EXISTS(SELECT * FROM ORDERS AS O WHERE C.CUSTOMER_ID = O.CUSTOMER_ID AND PRODUCT_NAME = 'C');

/*
Prediction Result:
(3, 'B')
*/