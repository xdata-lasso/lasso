-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, NULL), (0, NULL), (1, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 2, 'A'), (0, 1, 'A'), (-1, 0, 'A'), (2, 1, 'C'), (3, 2, 'default2'), (4, 2, NULL), (5, 0, 'A'), (6, 2, 'B'), (7, NULL, 'default2'), (8, 2, 'C'), (9, 1, 'default2'), (10, 2, 'default2'), (11, 2, 'B'), (12, 1, NULL), (13, 1, 'C'), (14, 1, 'B'), (15, 2, 'default1'), (16, 1, 'default2'), (17, 2, 'default2'), (18, NULL, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS AS C WHERE (SELECT COUNT(PRODUCT_NAME) FROM ORDERS WHERE CUSTOMER_ID = C.CUSTOMER_ID AND PRODUCT_NAME IN ('A', 'B')) = 2 AND (SELECT COUNT(PRODUCT_NAME) FROM ORDERS WHERE CUSTOMER_ID = C.CUSTOMER_ID AND PRODUCT_NAME = 'C') = 0;

/*
Prediction Result:
(0, None)
*/