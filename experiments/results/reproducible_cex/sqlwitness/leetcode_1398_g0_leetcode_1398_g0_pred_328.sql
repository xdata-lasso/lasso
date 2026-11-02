-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'A'), (1, NULL), (2, 'A'), (3, NULL), (4, NULL), (5, 'default2'), (6, 'C'), (7, 'C'), (8, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 4, 'C'), (1, 1, NULL), (2, 8, 'B'), (3, 4, 'B'), (4, 5, 'A'), (5, 7, 'C'), (6, 6, 'B'), (7, 1, 'B'), (8, 6, 'C'), (9, 1, 'A'), (10, 3, 'A'), (11, 2, 'default2'), (12, 3, 'default2'), (13, 1, 'B'), (14, 2, 'default1'), (15, 3, 'C'), (16, 8, 'B'), (17, 4, NULL), (18, 3, 'default2'), (19, 2, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, None)
*/

-- Prediction Query
WITH T1 AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE (CUSTOMER_ID, 'A') IN (SELECT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS) AND (CUSTOMER_ID, 'B') IN (SELECT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS) AND NOT (CUSTOMER_ID, 'C') IN (SELECT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS)) SELECT * FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT * FROM T1);

/*
Prediction Result:
*/