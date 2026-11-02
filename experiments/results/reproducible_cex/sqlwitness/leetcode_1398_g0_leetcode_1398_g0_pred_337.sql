-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, NULL), (0, 'A'), (2, 'default2'), (3, 'default2'), (4, 'default1'), (5, 'default2'), (6, 'default2'), (7, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 5, 'B'), (0, 4, 'default2'), (2, 4, NULL), (3, 1, 'default1'), (4, 5, NULL), (5, 6, 'B'), (6, 6, 'A'), (7, 5, 'C'), (8, 5, 'C'), (9, 7, 'C'), (10, 5, 'C'), (11, 3, 'B'), (12, 2, 'default1'), (13, 5, 'B'), (14, 3, 'C'), (15, 0, 'default2'), (16, 4, NULL), (17, 1, NULL), (18, NULL, 'default2'), (19, 1, 'B'), (20, 1, 'default1'), (21, 3, 'B'), (22, 0, 'A'), (23, 6, 'C'), (24, 4, 'B'), (25, 5, 'B'), (26, 3, 'A'), (27, 7, 'B'), (28, 1, 'A'), (29, 5, 'A'), (30, NULL, 'default1'), (31, 5, 'default2'), (32, NULL, 'C'), (33, 3, 'default1'), (34, 0, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C WHERE EXISTS(SELECT * FROM ORDERS AS O WHERE O.CUSTOMER_ID = C.CUSTOMER_ID AND O.PRODUCT_NAME = 'A') AND EXISTS(SELECT * FROM ORDERS AS O WHERE O.CUSTOMER_ID = C.CUSTOMER_ID AND O.PRODUCT_NAME = 'B') AND NOT EXISTS(SELECT * FROM ORDERS AS O WHERE O.CUSTOMER_ID = C.CUSTOMER_ID AND O.PRODUCT_NAME = 'C') ORDER BY C.CUSTOMER_ID;

/*
Prediction Result:
(0, 'A')
(1, None)
*/