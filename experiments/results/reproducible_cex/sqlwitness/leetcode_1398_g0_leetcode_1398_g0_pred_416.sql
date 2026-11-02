-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'A'), (0, NULL), (2, NULL), (3, 'default1'), (4, 'A'), (5, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 0, 'B'), (0, 0, 'B'), (2, 4, 'A'), (3, 4, 'B'), (4, 5, NULL), (5, 5, NULL), (6, 1, NULL), (7, 2, 'A'), (8, 1, 'A'), (9, 3, 'default2'), (10, 5, NULL), (11, NULL, NULL), (12, 4, 'default1'), (13, 4, 'default2'), (14, 3, 'B'), (15, 1, 'default1'), (16, 3, 'A'), (17, NULL, 'B'), (18, 0, 'default2'), (19, 5, 'default2'), (20, 4, NULL), (21, 3, NULL), (22, 4, 'default2'), (23, 2, 'C'), (24, 1, 'A'), (25, 3, 'default1'), (26, 2, NULL), (27, 5, 'A'), (28, 0, NULL), (29, 2, 'default1'), (30, 4, 'B'), (31, 4, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(3, 'default1')
(4, 'A')
*/

-- Prediction Query
SELECT DISTINCT O.CUSTOMER_ID, C.CUSTOMER_NAME FROM ORDERS AS O JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID WHERE PRODUCT_NAME = 'A' AND O.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT O.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(4, 'A')
(3, 'default1')
*/