-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'default1'), (1, 'default1'), (0, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 0, 'B'), (1, 0, NULL), (0, NULL, NULL), (2, NULL, 'default2'), (3, 0, 'default1'), (4, -1, 'C'), (5, NULL, 'C'), (6, NULL, 'default1'), (7, 0, NULL), (8, NULL, 'default2'), (9, NULL, 'default1'), (10, NULL, 'default1'), (11, 0, 'B'), (12, 1, 'C'), (13, 0, 'A'), (14, 0, 'default1'), (15, 1, 'default1'), (16, -1, 'B'), (17, 0, 'B'), (18, 1, 'default2'), (19, -1, 'C'), (20, 0, 'B'), (21, -1, 'B'), (22, 0, 'default1'), (23, NULL, 'C'), (24, 1, 'A'), (25, -1, 'C'), (26, 0, 'default2'), (27, 1, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS AS C CROSS JOIN ORDERS AS B WHERE C.CUSTOMER_ID = B.CUSTOMER_ID GROUP BY C.CUSTOMER_ID HAVING SUM(B.PRODUCT_NAME = 'A') > 0 AND SUM(B.PRODUCT_NAME = 'B') > 0 AND SUM(B.PRODUCT_NAME = 'C') = 0;

/*
Prediction Result:
(0, 'default1')
*/