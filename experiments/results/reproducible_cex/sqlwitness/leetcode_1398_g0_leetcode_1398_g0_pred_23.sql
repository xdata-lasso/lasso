-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'default1'), (0, NULL), (2, NULL), (3, 'C'), (4, 'default2'), (5, 'B'), (6, NULL), (7, NULL), (8, 'default2'), (9, 'B'), (10, 'B'), (11, 'B'), (12, 'default2'), (13, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 9, 'B'), (0, 7, 'B'), (2, 1, NULL), (3, 11, NULL), (4, 10, 'A'), (5, 4, NULL), (6, 8, 'C'), (7, 1, 'A'), (8, 0, 'default1'), (9, 3, 'default1'), (10, 12, 'default2'), (11, 5, 'default2'), (12, 13, 'C'), (13, 10, 'B'), (14, 1, 'B'), (15, 9, 'B'), (16, 2, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'default1')
(10, 'B')
*/

-- Prediction Query
SELECT ORDERS.CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS LEFT JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = ORDERS.CUSTOMER_ID WHERE PRODUCT_NAME = 'A' AND ORDERS.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT ORDERS.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(10, 'B')
(1, 'default1')
*/