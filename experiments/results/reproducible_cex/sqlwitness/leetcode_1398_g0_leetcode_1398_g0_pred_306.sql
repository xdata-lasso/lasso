-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'default2'), (0, 'default1'), (2, 'default1'), (-1, 'default2'), (3, 'default1'), (4, 'default1'), (5, NULL), (6, 'default2'), (7, 'default2'), (8, 'B'), (9, 'default2'), (10, 'C'), (11, 'C'), (12, 'A'), (13, 'C'), (14, 'C'), (15, NULL), (16, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, -1, 'A'), (0, NULL, 'C'), (-1, 6, 'C'), (2, 6, 'default2'), (3, 3, 'B'), (4, 9, 'B'), (5, 12, 'B'), (6, 14, 'B'), (7, 9, 'A'), (8, 8, 'A'), (9, 15, 'C'), (10, 2, 'default2'), (11, NULL, NULL), (12, 5, 'B'), (13, 5, 'A'), (14, 16, 'C'), (15, 16, NULL), (16, 2, 'B'), (17, 11, 'C'), (18, 8, 'A'), (19, 8, 'B'), (20, 15, 'A'), (21, NULL, NULL), (22, 9, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH PRE_PIVOT AS (SELECT CUSTOMER_ID, IIF(PRODUCT_NAME = 'A', 1, 0) AS PROD_A, IIF(PRODUCT_NAME = 'B', 1, 0) AS PROD_B, IIF(PRODUCT_NAME = 'C', 1, 0) AS PROD_C FROM ORDERS), PIVOT AS (SELECT CUSTOMER_ID, MAX(PROD_A) AS PROD_A, MAX(PROD_B) AS PROD_B, MAX(PROD_C) AS PROD_C FROM PRE_PIVOT GROUP BY CUSTOMER_ID) SELECT P.CUSTOMER_ID, C.CUSTOMER_NAME FROM PIVOT AS P INNER JOIN CUSTOMERS AS C ON P.CUSTOMER_ID = C.CUSTOMER_ID WHERE P.PROD_A = 1 AND P.PROD_B = 1 AND P.PROD_C = 0 ORDER BY P.CUSTOMER_ID, C.customer_id NULLS LAST;

/*
Prediction Result:
(5, None)
(8, 'B')
(9, 'default2')
*/