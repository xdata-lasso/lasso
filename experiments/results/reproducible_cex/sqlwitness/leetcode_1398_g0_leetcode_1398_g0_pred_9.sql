-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'A'), (0, 'A'), (2, 'default2'), (3, 'A'), (4, NULL), (5, 'C'), (6, 'B'), (7, 'default1'), (8, 'A'), (9, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 5, 'B'), (1, 9, 'A'), (2, 1, 'default2'), (3, 5, 'default1'), (4, 6, 'C'), (5, 1, 'default1'), (6, 9, 'A'), (7, 2, 'B'), (8, 9, NULL), (9, 3, 'C'), (10, 6, 'B'), (11, NULL, 'B'), (12, 6, 'default1'), (13, 6, 'A'), (14, 2, 'A'), (15, 9, 'B'), (16, NULL, 'B'), (17, 8, 'default1'), (18, 1, 'default1'), (19, 7, 'default2'), (20, 5, 'C'), (21, 4, 'default2'), (22, 4, 'default2'), (23, 1, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(2, 'default2')
(9, 'C')
*/

-- Prediction Query
SELECT DISTINCT CUSTOMERS.CUSTOMER_ID, CUSTOMERS.CUSTOMER_NAME FROM ORDERS LEFT JOIN CUSTOMERS ON ORDERS.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID WHERE CUSTOMERS.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMERS.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMERS.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(9, 'C')
(2, 'default2')
*/