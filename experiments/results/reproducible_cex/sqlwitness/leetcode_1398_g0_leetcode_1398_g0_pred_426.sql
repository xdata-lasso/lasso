-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'default2'), (1, NULL), (0, 'default2'), (-1, 'C'), (3, NULL), (4, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 3, 'B'), (1, 0, NULL), (-1, 2, 'default1'), (2, 2, 'B'), (3, NULL, 'A'), (4, 1, 'default2'), (5, NULL, 'C'), (6, 2, NULL), (7, 4, 'A'), (8, 3, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH TEMP AS (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS COUNT_A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS COUNT_B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS COUNT_C FROM ORDERS GROUP BY 1) SELECT C.CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS AS C JOIN TEMP AS T ON C.CUSTOMER_ID = T.CUSTOMER_ID WHERE COUNT_A > 0 AND COUNT_B > 0 AND COUNT_C = 0 ORDER BY 1, C.customer_id NULLS LAST;

/*
Prediction Result:
(3, None)
*/