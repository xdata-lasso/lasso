-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'default1'), (0, 'default2'), (2, 'default1'), (3, NULL), (4, 'default2'), (5, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 4, 'A'), (0, 3, NULL), (2, 3, NULL), (3, NULL, 'A'), (4, NULL, 'B'), (5, 1, 'B'), (6, 0, 'C'), (7, NULL, 'default1'), (8, 2, 'A'), (9, 2, 'default1'), (10, 4, 'default1'), (11, 1, 'default1'), (12, 1, 'B'), (13, NULL, 'C'), (14, 3, 'default1'), (15, 1, 'default1'), (16, 4, 'default1'), (17, 0, 'A'), (18, 4, 'B'), (19, 3, 'A'), (20, 4, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C WHERE EXISTS(SELECT * FROM ORDERS WHERE CUSTOMER_ID = C.CUSTOMER_ID AND PRODUCT_NAME = 'A') AND EXISTS(SELECT * FROM ORDERS WHERE CUSTOMER_ID = C.CUSTOMER_ID AND PRODUCT_NAME = 'B') AND NOT EXISTS(SELECT * FROM ORDERS WHERE CUSTOMER_ID = C.CUSTOMER_ID AND PRODUCT_NAME = 'C') ORDER BY C.CUSTOMER_ID;

/*
Prediction Result:
(4, 'default2')
*/