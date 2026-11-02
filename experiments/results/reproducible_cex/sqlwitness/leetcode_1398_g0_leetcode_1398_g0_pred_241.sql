-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default2'), (-1, 'C'), (1, 'A'), (2, 'A'), (3, 'A'), (4, 'default2'), (5, NULL), (6, 'default1'), (7, 'B'), (8, 'C'), (9, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 2, 'C'), (0, 0, 'C'), (1, 0, 'default1'), (2, NULL, 'C'), (3, 6, 'default2'), (4, 0, 'default1'), (5, 8, 'A'), (6, 7, 'default1'), (7, 5, 'A'), (8, 5, 'B'), (9, 2, 'default2'), (10, 9, 'default1'), (11, 6, 'default1'), (12, 6, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT CUSTOMER_ID FROM ORDERS GROUP BY CUSTOMER_ID HAVING SUM(CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) = 0 AND SUM(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) >= 1 AND SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) >= 1) SELECT CU.CUSTOMER_ID, CUSTOMER_NAME FROM CTE AS C JOIN CUSTOMERS AS CU ON C.CUSTOMER_ID = CU.CUSTOMER_ID;

/*
Prediction Result:
(5, None)
*/