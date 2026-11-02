-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'B'), (-1, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, -1, 'A'), (-1, 1, 'default1'), (1, NULL, NULL), (0, 1, NULL), (3, -1, 'default2'), (4, NULL, NULL), (5, -1, 'B'), (6, 1, 'B'), (7, -1, 'B'), (8, NULL, 'default2'), (9, NULL, 'A'), (10, -1, 'A'), (11, 1, 'A'), (12, NULL, 'A'), (13, -1, 'B'), (14, 1, NULL), (15, -1, 'A'), (16, NULL, 'C'), (17, -1, 'B'), (18, NULL, 'default1'), (19, -1, 'default2'), (20, -1, 'default2'), (21, NULL, 'default2'), (22, 1, 'B'), (23, NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.CUSTOMER_ID, T1.CUSTOMER_NAME FROM CUSTOMERS AS T1 JOIN ORDERS AS T2 ON T1.CUSTOMER_ID = T2.CUSTOMER_ID GROUP BY T1.CUSTOMER_ID HAVING SUM(T2.PRODUCT_NAME = 'A') >= 1 AND SUM(T2.PRODUCT_NAME = 'B') >= 1 AND SUM(T2.PRODUCT_NAME = 'C') = 0;

/*
Prediction Result:
(-1, 'B')
(1, 'B')
*/