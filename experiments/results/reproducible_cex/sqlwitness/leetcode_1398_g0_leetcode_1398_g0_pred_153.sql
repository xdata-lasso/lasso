-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'B'), (0, 'default1'), (2, 'C'), (3, 'default1'), (4, 'A'), (5, 'default2'), (6, 'default2'), (7, 'B'), (8, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, NULL, 'default1'), (0, 2, 'A'), (2, 2, 'A'), (3, 6, 'A'), (4, 2, 'B'), (5, 2, 'default2'), (6, 4, 'default1'), (7, 2, 'default1'), (8, 8, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(2, 'C')
*/

-- Prediction Query
SELECT CUSTOMERS.CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS INNER JOIN ORDERS ON CUSTOMERS.CUSTOMER_ID = ORDERS.CUSTOMER_ID WHERE PRODUCT_NAME = 'A' AND CUSTOMERS.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMERS.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(2, 'C')
(2, 'C')
*/