-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default2'), (1, 'C'), (2, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 1, 'B'), (1, 1, 'default1'), (2, 0, 'A'), (3, NULL, 'A'), (4, 2, NULL), (5, 1, 'default2'), (6, 1, 'B'), (7, 1, NULL), (8, NULL, 'A'), (9, 2, NULL), (10, 0, 'default2'), (11, 2, 'default1'), (12, 1, 'A'), (13, 1, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'C')
*/

-- Prediction Query
SELECT DISTINCT O.CUSTOMER_ID, C.CUSTOMER_NAME FROM ORDERS AS O LEFT JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID WHERE (O.CUSTOMER_ID, 'A') IN (SELECT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS) AND (O.CUSTOMER_ID, 'B') IN (SELECT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS) AND NOT (O.CUSTOMER_ID, 'C') IN (SELECT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS);

/*
Prediction Result:
*/