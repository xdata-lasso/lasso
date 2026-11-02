-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (3, NULL), (0, 'C'), (2, 'C'), (-1, 'default2'), (1, 'default1'), (4, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 1, 'B'), (0, 1, 'C'), (3, 3, 'default1'), (-1, 2, 'B'), (2, 3, 'default1'), (4, NULL, 'C'), (5, -1, NULL), (6, NULL, 'C'), (7, 1, 'default1'), (8, 0, 'A'), (9, 1, 'default1'), (10, 4, 'default2'), (11, NULL, 'C'), (12, NULL, 'default2'), (13, 3, NULL), (14, -1, NULL), (15, 0, 'C'), (16, 2, 'A'), (17, 0, 'default2'), (18, NULL, 'default1'), (19, 1, 'A'), (20, 4, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH ORDERS_BY_CUSTOMER AS (SELECT A.CUSTOMER_ID, A.CUSTOMER_NAME, SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) AS PURCHASES_A, SUM(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) AS PURCHASES_B, SUM(CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) AS PURCHASES_C FROM CUSTOMERS AS A LEFT JOIN ORDERS AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID GROUP BY 1, 2) SELECT CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS_BY_CUSTOMER WHERE PURCHASES_A > 0 AND PURCHASES_B > 0 AND PURCHASES_C = 0 ORDER BY 1, CUSTOMER_ID NULLS LAST, CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
(2, 'C')
*/