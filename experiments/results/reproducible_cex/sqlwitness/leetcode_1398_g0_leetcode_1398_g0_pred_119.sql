-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'A'), (-1, NULL), (1, 'B'), (2, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, -1, 'default1'), (-1, -1, 'default1'), (0, -1, 'A'), (2, 1, 'C'), (3, -1, 'A'), (4, -1, 'A'), (5, 1, 'default1'), (6, 0, NULL), (7, NULL, 'default1'), (8, -1, 'default2'), (9, NULL, 'A'), (10, 2, NULL), (11, 0, 'A'), (12, 1, NULL), (13, NULL, NULL), (14, NULL, 'B'), (15, NULL, 'C'), (16, NULL, NULL), (17, NULL, 'default2'), (18, 0, 'B'), (19, 2, NULL), (20, 1, NULL), (21, 2, 'default1'), (22, 2, 'A'), (23, -1, 'default1'), (24, -1, 'C'), (25, 1, 'A'), (26, 0, 'default2'), (27, 0, 'default1'), (28, NULL, 'default2'), (29, 1, 'A'), (30, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT C.CUSTOMER_ID AS CUSTOMER_ID, C.CUSTOMER_NAME AS CUSTOMER_NAME FROM CUSTOMERS AS C LEFT JOIN ORDERS AS A ON C.CUSTOMER_ID = A.CUSTOMER_ID GROUP BY C.CUSTOMER_ID HAVING SUM(A.PRODUCT_NAME = 'A') > 0 AND SUM(A.PRODUCT_NAME = 'B') > 0 AND SUM(A.PRODUCT_NAME = 'C') = 0;

/*
Prediction Result:
(0, 'A')
*/