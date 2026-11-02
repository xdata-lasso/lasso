-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'B'), (0, NULL), (2, 'B'), (3, 'default2'), (4, 'A'), (5, 'default1'), (6, 'A'), (7, 'default2'), (8, 'B'), (9, 'default2'), (10, 'B'), (11, NULL), (12, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 4, NULL), (1, 3, 'B'), (2, 8, 'B'), (3, 10, NULL), (4, 1, 'A'), (5, 4, 'A'), (6, 1, 'A'), (7, 2, NULL), (8, 7, 'default1'), (9, 2, 'default2'), (10, 4, NULL), (11, 7, NULL), (12, 3, 'default2'), (13, NULL, 'A'), (14, NULL, 'C'), (15, 6, 'B'), (16, 0, 'C'), (17, 0, 'A'), (18, 4, 'B'), (19, 1, NULL), (20, 11, 'C'), (21, 8, 'default1'), (22, 5, NULL), (23, 6, 'B'), (24, 12, 'default2'), (25, NULL, 'B'), (26, 7, 'default1'), (27, 0, NULL), (28, 6, 'default1'), (29, 8, NULL), (30, 11, 'B'), (31, 1, NULL), (32, 11, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT T1.CUSTOMER_ID, T1.CUSTOMER_NAME FROM CUSTOMERS AS T1 JOIN ORDERS AS T2 ON T1.CUSTOMER_ID = T2.CUSTOMER_ID WHERE T2.PRODUCT_NAME = 'A' AND T1.CUSTOMER_ID IN (SELECT T1.CUSTOMER_ID FROM CUSTOMERS AS T1 JOIN ORDERS AS T2 ON T1.CUSTOMER_ID = T2.CUSTOMER_ID WHERE T2.PRODUCT_NAME = 'B') AND NOT T1.CUSTOMER_ID IN (SELECT T1.CUSTOMER_ID FROM CUSTOMERS AS T1 JOIN ORDERS AS T2 ON T1.CUSTOMER_ID = T2.CUSTOMER_ID WHERE T2.PRODUCT_NAME = 'C');

/*
Prediction Result:
(4, 'A')
*/