-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'C'), (-1, 'C'), (1, 'D'), (2, 'A'), (3, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 1, 'default2'), (2, NULL, 'B'), (-1, 3, NULL), (0, 0, 'default2'), (3, 0, 'C'), (4, 2, 'default1'), (5, NULL, 'C'), (6, 3, 'A'), (7, NULL, 'C'), (8, 1, 'A'), (9, 0, 'A'), (10, -1, 'default2'), (11, 2, 'C'), (12, 2, 'C'), (13, 3, 'B'), (14, 2, 'A'), (15, 0, 'D'), (16, -1, 'C'), (17, 2, 'C'), (18, 1, 'default2'), (19, NULL, 'B'), (20, 1, 'B'), (21, 3, 'B'), (22, NULL, 'D'), (23, 2, 'B'), (24, 1, 'C'), (25, 2, 'default2'), (26, NULL, 'D'), (27, 0, 'default2'), (28, NULL, 'A'), (29, 2, NULL), (30, NULL, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT T.CUSTOMER_ID, T.CUSTOMER_NAME FROM (SELECT O.CUSTOMER_ID, C.CUSTOMER_NAME, SUM(IIF(O.PRODUCT_NAME = 'A', 1, 0)) AS PROD_A, SUM(IIF(O.PRODUCT_NAME = 'B', 1, 0)) AS PROD_B, SUM(IIF(O.PRODUCT_NAME = 'C', 1, 0)) AS PROD_C, SUM(IIF(O.PRODUCT_NAME = 'D', 1, 0)) AS PROD_D FROM ORDERS AS O LEFT JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID GROUP BY O.CUSTOMER_ID) AS T WHERE T.PROD_A > 0 AND T.PROD_B > 0 AND T.PROD_C = 0;

/*
Prediction Result:
(3, 'default1')
*/