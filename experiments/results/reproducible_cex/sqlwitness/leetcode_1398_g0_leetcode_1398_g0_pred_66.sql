-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'B'), (1, 'C'), (2, 'default2'), (3, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 2, 'default2'), (0, 0, NULL), (2, 3, 'C'), (3, 1, NULL), (4, NULL, 'A'), (5, 0, 'C'), (6, 1, NULL), (7, 0, 'B'), (8, 2, 'default1'), (9, 1, 'default1'), (10, NULL, NULL), (11, NULL, 'C'), (12, NULL, 'C'), (13, 0, 'A'), (14, 3, 'default2'), (15, 3, 'A'), (16, 2, 'C'), (17, 1, 'A'), (18, 3, 'default2'), (19, NULL, 'B'), (20, 3, 'default1'), (21, 1, 'A'), (22, 0, 'default1'), (23, 3, 'C'), (24, 2, 'B'), (25, 0, 'C'), (26, 3, 'C'), (27, 1, 'B'), (28, 3, NULL), (29, 2, NULL), (30, 2, 'C'), (31, 3, 'default1'), (32, NULL, 'default1'), (33, 0, 'default2'), (34, 1, 'default1'), (35, 0, 'default1'), (36, 2, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH A AS (SELECT DISTINCT (CUSTOMER_ID) AS CUSTS_A FROM ORDERS WHERE PRODUCT_NAME = 'A'), B AS (SELECT DISTINCT (CUSTOMER_ID) AS CUSTS_B FROM ORDERS WHERE PRODUCT_NAME = 'B'), C AS (SELECT DISTINCT (CUSTOMER_ID) AS CUSTS_C FROM ORDERS WHERE PRODUCT_NAME = 'C') SELECT CUSTOMERS.CUSTOMER_ID, CUSTOMERS.CUSTOMER_NAME FROM (SELECT A.CUSTS_A FROM A JOIN B ON A.CUSTS_A = B.CUSTS_B LEFT JOIN C ON A.CUSTS_A = C.CUSTS_C WHERE C.CUSTS_C IS NULL) AS T JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = T.CUSTS_A;

/*
Prediction Result:
(1, 'C')
*/