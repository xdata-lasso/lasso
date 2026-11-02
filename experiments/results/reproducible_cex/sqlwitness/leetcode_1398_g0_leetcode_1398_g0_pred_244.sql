-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'A'), (1, 'B'), (0, NULL), (2, 'A'), (3, NULL), (4, NULL), (5, 'A'), (6, 'default2'), (7, 'B'), (8, 'default2'), (9, 'A'), (10, NULL), (11, 'C'), (12, 'default2'), (13, 'A'), (14, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 9, 'B'), (1, 5, 'default2'), (-1, 6, 'default1'), (2, 5, NULL), (3, 14, 'C'), (4, NULL, 'C'), (5, -1, 'A'), (6, 3, 'default1'), (7, 12, 'A'), (8, 4, 'default1'), (9, -1, NULL), (10, -1, NULL), (11, 5, 'B'), (12, 1, 'C'), (13, 5, 'B'), (14, -1, NULL), (15, -1, 'B'), (16, 12, 'B'), (17, 7, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT CUSTOMERS.CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS LEFT JOIN ORDERS ON CUSTOMERS.CUSTOMER_ID = ORDERS.CUSTOMER_ID GROUP BY CUSTOMERS.CUSTOMER_ID HAVING SUM(PRODUCT_NAME = 'A') > 0 AND SUM(PRODUCT_NAME = 'B') > 0 AND SUM(PRODUCT_NAME = 'C') = 0 ORDER BY CUSTOMERS.CUSTOMER_ID, CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
(-1, 'A')
(12, 'default2')
*/