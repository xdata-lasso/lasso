-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, NULL), (1, 'default1'), (0, NULL), (2, 'B'), (3, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 3, 'A'), (1, 1, 'default2'), (-1, 3, 'B'), (2, 2, 'default1'), (3, 2, 'default2'), (4, 0, 'C'), (5, NULL, 'C'), (6, NULL, 'default1'), (7, 3, 'default1'), (8, -1, 'default1'), (9, -1, 'B'), (10, 0, 'C'), (11, NULL, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT ORDERS.CUSTOMER_ID, CUSTOMERS.CUSTOMER_NAME FROM CUSTOMERS JOIN ORDERS ON CUSTOMERS.CUSTOMER_ID = ORDERS.CUSTOMER_ID GROUP BY ORDERS.CUSTOMER_ID HAVING SUM(ORDERS.PRODUCT_NAME = 'A') > 0 AND SUM(ORDERS.PRODUCT_NAME = 'B') > 0 AND SUM(ORDERS.PRODUCT_NAME = 'C') = 0 ORDER BY ORDERS.CUSTOMER_ID, CUSTOMERS.CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
(3, 'default1')
*/