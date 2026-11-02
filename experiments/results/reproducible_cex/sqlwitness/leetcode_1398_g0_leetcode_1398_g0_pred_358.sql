-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, NULL), (2, 'B'), (1, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, NULL, 'A'), (1, 1, 'B'), (2, 0, 'C'), (3, 0, 'C'), (4, NULL, 'B'), (5, NULL, 'default1'), (6, 1, 'A'), (7, NULL, 'C'), (8, 2, 'default2'), (9, 2, 'default1'), (10, 0, 'A'), (11, 2, 'default2'), (12, 0, 'default1'), (13, 2, 'C'), (14, 0, NULL), (15, 1, 'default2'), (16, 1, 'B'), (17, 0, 'C'), (18, 1, 'B'), (19, 0, 'B'), (20, 2, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS AS C WHERE NOT EXISTS(SELECT 1 FROM ORDERS WHERE CUSTOMER_ID = C.CUSTOMER_ID AND PRODUCT_NAME = 'C') AND EXISTS(SELECT 1 FROM ORDERS WHERE CUSTOMER_ID = C.CUSTOMER_ID AND PRODUCT_NAME = 'A') AND EXISTS(SELECT 1 FROM ORDERS WHERE CUSTOMER_ID = C.CUSTOMER_ID AND PRODUCT_NAME = 'B');

/*
Prediction Result:
(1, 'A')
*/