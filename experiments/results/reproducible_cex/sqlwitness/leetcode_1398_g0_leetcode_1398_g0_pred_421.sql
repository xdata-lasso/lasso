-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'C'), (1, 'default2'), (2, 'C'), (3, NULL), (4, NULL), (5, 'C'), (6, 'B'), (7, 'default1'), (8, 'default2'), (9, NULL), (10, 'C'), (11, 'default2'), (12, 'default2'), (13, 'A'), (14, NULL), (15, NULL), (16, 'C'), (17, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 1, 'default1'), (0, 9, 'A'), (2, 7, 'default2'), (3, 4, 'A'), (4, NULL, 'C'), (5, 1, 'B'), (6, 8, 'default1'), (7, 6, 'default2'), (8, 1, 'default2'), (9, 17, 'default1'), (10, 16, 'B'), (11, 3, 'A'), (12, 9, 'B'), (13, 6, 'B'), (14, 4, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH T1 AS (SELECT C.CUSTOMER_ID FROM CUSTOMERS AS C JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE PRODUCT_NAME = 'C'), T2 AS (SELECT C.CUSTOMER_ID FROM CUSTOMERS AS C JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE PRODUCT_NAME = 'A'), T3 AS (SELECT C.CUSTOMER_ID FROM CUSTOMERS AS C JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE PRODUCT_NAME = 'B') SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE NOT CUSTOMER_ID IN (SELECT T1.CUSTOMER_ID FROM T1) AND CUSTOMER_ID IN (SELECT DISTINCT T2.CUSTOMER_ID FROM T2) AND CUSTOMER_ID IN (SELECT DISTINCT T3.CUSTOMER_ID FROM T3);

/*
Prediction Result:
(9, None)
*/