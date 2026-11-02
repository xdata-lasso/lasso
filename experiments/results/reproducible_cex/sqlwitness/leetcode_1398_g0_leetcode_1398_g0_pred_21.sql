-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'default2'), (0, 'C'), (2, 'A'), (3, NULL), (4, 'default1'), (5, 'B'), (6, 'B'), (7, 'default1'), (8, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 7, 'A'), (1, 2, 'B'), (2, 7, 'default2'), (3, 1, 'A'), (4, 3, 'B'), (5, 6, 'B'), (6, 0, 'B'), (7, 7, 'default2'), (8, 1, 'B'), (9, 0, 'A'), (10, 7, 'C'), (11, 7, 'B'), (12, 8, 'C'), (13, 1, 'default2'), (14, 3, 'A'), (15, 0, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(0, 'C')
(1, 'default2')
(3, None)
*/

-- Prediction Query
SELECT DISTINCT (CUSTOMER_ID), CUSTOMER_NAME FROM ORDERS JOIN CUSTOMERS USING (CUSTOMER_ID) WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(1, 'default2')
(3, None)
(0, 'C')
*/