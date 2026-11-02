-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default2'), (-1, 'default2'), (1, 'default1'), (2, 'C'), (3, 'B'), (4, 'default1'), (5, 'B'), (6, 'B'), (7, 'A'), (8, 'A'), (9, 'default2'), (10, 'A'), (11, 'default1'), (12, 'default1'), (13, 'default1'), (14, 'B'), (15, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 5, 'A'), (1, 15, NULL), (0, 2, 'A'), (2, 4, NULL), (3, 11, 'A'), (4, 15, 'C'), (5, 0, 'B'), (6, 9, 'B'), (7, 9, 'A'), (8, 5, 'A'), (9, 6, 'B'), (10, 9, 'B'), (11, 1, 'A'), (12, -1, 'B'), (13, 13, 'default2'), (14, NULL, 'C'), (15, 14, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM ORDERS AS O JOIN CUSTOMERS AS C USING (CUSTOMER_ID) GROUP BY C.CUSTOMER_ID HAVING SUM(O.PRODUCT_NAME = 'A') > 0 AND SUM(O.PRODUCT_NAME = 'B') > 0 AND SUM(O.PRODUCT_NAME = 'C') = 0;

/*
Prediction Result:
(9, 'default2')
*/