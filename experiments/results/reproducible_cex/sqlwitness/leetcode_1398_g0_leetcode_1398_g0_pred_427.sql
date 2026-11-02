-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'default2'), (0, 'A'), (2, 'A'), (3, 'A'), (4, 'A'), (5, NULL), (6, 'C'), (7, 'A'), (8, 'A'), (9, 'B'), (10, 'C'), (11, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 11, 'default1'), (1, 8, 'default1'), (2, 11, NULL), (3, 10, 'C'), (4, NULL, 'default2'), (5, NULL, 'C'), (6, 7, 'default1'), (7, 0, 'B'), (8, NULL, 'default1'), (9, 0, 'A'), (10, 0, 'default2'), (11, 1, 'default2'), (12, 6, 'B'), (13, 1, NULL), (14, 7, 'C'), (15, 6, 'C'), (16, 6, 'default2'), (17, 5, 'A'), (18, 9, 'A'), (19, 9, 'B'), (20, 4, 'A'), (21, NULL, NULL), (22, 7, 'B'), (23, 7, 'A'), (24, 2, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS AS C WHERE EXISTS(SELECT * FROM ORDERS AS S WHERE S.CUSTOMER_ID = C.CUSTOMER_ID AND PRODUCT_NAME = 'A') AND EXISTS(SELECT * FROM ORDERS AS S WHERE S.CUSTOMER_ID = C.CUSTOMER_ID AND PRODUCT_NAME = 'B') AND NOT EXISTS(SELECT * FROM ORDERS AS S WHERE S.CUSTOMER_ID = C.CUSTOMER_ID AND PRODUCT_NAME = 'C') ORDER BY C.CUSTOMER_ID;

/*
Prediction Result:
(0, 'A')
(9, 'B')
*/