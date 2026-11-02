-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'default2'), (0, 'B'), (2, 'default1'), (3, 'A'), (4, 'B'), (5, 'default1'), (6, 'default2'), (7, 'default2'), (8, 'default1'), (9, 'A'), (10, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 9, 'C'), (0, 1, 'A'), (2, 7, 'default2'), (3, 1, NULL), (4, 8, 'C'), (5, 9, 'default2'), (6, 6, 'C'), (7, 3, 'B'), (8, 10, 'A'), (9, 6, 'default2'), (10, 3, 'C'), (11, 2, 'B'), (12, 4, 'default2'), (13, 0, NULL), (14, 10, NULL), (15, 1, 'B'), (16, 1, 'A'), (17, 2, 'B'), (18, 10, 'C'), (19, 3, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'default2')
*/

-- Prediction Query
SELECT X.CUSTOMER_ID, X.CUSTOMER_NAME FROM (SELECT ORDERS.CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS LEFT JOIN CUSTOMERS ON ORDERS.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID WHERE PRODUCT_NAME = 'A' AND ORDERS.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B')) AS X LEFT JOIN (SELECT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS WHERE PRODUCT_NAME = 'C') AS Y ON X.CUSTOMER_ID = Y.CUSTOMER_ID WHERE Y.PRODUCT_NAME IS NULL;

/*
Prediction Result:
(1, 'default2')
(1, 'default2')
*/