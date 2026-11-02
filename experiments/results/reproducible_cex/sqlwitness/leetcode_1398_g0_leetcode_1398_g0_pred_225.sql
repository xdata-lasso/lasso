-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'B'), (1, 'A'), (0, 'A'), (2, 'B'), (3, 'B'), (4, 'default1'), (5, 'B'), (6, 'default1'), (7, 'default2'), (8, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 1, 'default2'), (1, 1, NULL), (0, 5, 'A'), (2, NULL, 'C'), (3, -1, 'default2'), (4, NULL, 'default1'), (5, 7, 'C'), (6, -1, 'B'), (7, -1, NULL), (8, 7, NULL), (9, 2, NULL), (10, 1, 'default1'), (11, 7, 'C'), (12, -1, 'A'), (13, 3, NULL), (14, 5, 'B'), (15, 8, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH T1 AS (SELECT CUSTOMER_ID, PRODUCT_NAME, COUNT(1) AS CN FROM ORDERS GROUP BY CUSTOMER_ID, PRODUCT_NAME), GET_TRANS AS (SELECT CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME = 'A' THEN CN END) AS A, SUM(CASE WHEN PRODUCT_NAME = 'B' THEN CN END) AS B, SUM(CASE WHEN PRODUCT_NAME = 'C' THEN CN END) AS C FROM T1 GROUP BY 1) SELECT G.CUSTOMER_ID, C.CUSTOMER_NAME FROM GET_TRANS AS G JOIN CUSTOMERS AS C ON G.CUSTOMER_ID = C.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C IS NULL ORDER BY 1, C.customer_id NULLS LAST;

/*
Prediction Result:
(-1, 'B')
(5, 'B')
*/