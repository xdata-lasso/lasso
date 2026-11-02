-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default1'), (1, 'A'), (-1, NULL), (2, 'default2'), (3, 'A'), (4, 'C'), (5, 'B'), (6, 'A'), (7, 'B'), (8, 'default2'), (9, 'A'), (10, 'default1'), (11, 'A'), (12, 'B'), (13, 'A'), (14, 'C'), (15, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 12, 'A'), (0, 2, NULL), (1, -1, 'C'), (2, 15, 'B'), (3, 3, NULL), (4, 11, 'C'), (5, 14, 'B'), (6, 14, 'C'), (7, 11, 'default1'), (8, 3, 'A'), (9, 1, NULL), (10, 8, 'C'), (11, 15, 'B'), (12, 2, 'default1'), (13, 1, 'A'), (14, 15, 'A'), (15, 13, 'default2'), (16, 7, 'B'), (17, 11, 'A'), (18, 6, 'default1'), (19, 14, 'C'), (20, 6, 'default1'), (21, NULL, 'C'), (22, -1, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM ORDERS AS O JOIN CUSTOMERS AS C USING (CUSTOMER_ID) GROUP BY O.CUSTOMER_ID HAVING SUM(PRODUCT_NAME = 'A') > 0 AND SUM(PRODUCT_NAME = 'B') > 0 AND SUM(PRODUCT_NAME = 'C') = 0;

/*
Prediction Result:
(15, 'B')
*/