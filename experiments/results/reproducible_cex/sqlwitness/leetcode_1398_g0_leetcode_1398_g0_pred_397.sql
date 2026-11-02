-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default1'), (1, NULL), (2, 'C'), (3, 'default1'), (4, 'C'), (5, NULL), (6, 'C'), (7, 'default1'), (8, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 6, 'B'), (0, NULL, 'A'), (2, NULL, 'default2'), (3, 3, 'A'), (4, 3, 'default1'), (5, 3, NULL), (6, 0, 'C'), (7, 6, 'A'), (8, 3, 'A'), (9, 7, 'default1'), (10, 6, NULL), (11, 0, 'A'), (12, 4, NULL), (13, 2, 'default1'), (14, 3, 'default1'), (15, 1, 'A'), (16, 4, 'A'), (17, 7, 'default2'), (18, 0, NULL), (19, 8, 'default2'), (20, 0, 'C'), (21, 2, 'B'), (22, 3, 'default1'), (23, 7, 'default2'), (24, 0, 'B'), (25, 5, 'default2'), (26, 8, 'default1'), (27, NULL, 'C'), (28, 8, 'default1'), (29, 3, 'default1'), (30, NULL, NULL), (31, 5, 'A'), (32, 0, NULL), (33, 3, 'C'), (34, 7, 'B'), (35, 1, 'C'), (36, 7, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH T1 AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B' AND CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A')), T2 AS (SELECT DISTINCT T1.CUSTOMER_ID, PRODUCT_NAME FROM T1 JOIN ORDERS ON ORDERS.CUSTOMER_ID = T1.CUSTOMER_ID AND PRODUCT_NAME = 'C') SELECT T1.CUSTOMER_ID, CUSTOMER_NAME FROM T1 JOIN CUSTOMERS ON T1.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID WHERE NOT T1.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM T2) ORDER BY T1.CUSTOMER_ID, CUSTOMERS.customer_id NULLS LAST;

/*
Prediction Result:
(6, 'C')
*/