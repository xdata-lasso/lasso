-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'B'), (1, NULL), (0, 'C'), (-1, 'default1'), (3, 'default1'), (4, 'default2'), (5, 'default2'), (6, 'B'), (7, 'default2'), (8, 'default2'), (9, 'C'), (10, 'B'), (11, 'B'), (12, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, -1, 'C'), (1, 8, 'A'), (0, NULL, 'C'), (2, 10, 'default2'), (3, 5, 'default1'), (4, 7, 'default2'), (5, 9, 'A'), (6, 0, 'C'), (7, 2, 'A'), (8, 3, 'B'), (9, 7, 'C'), (10, 12, 'default2'), (11, 9, 'B'), (12, 3, 'B'), (13, 6, 'C'), (14, 11, 'default1'), (15, 4, 'default2'), (16, 11, 'C'), (17, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) AS A, SUM(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) AS B, SUM(CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) AS C FROM ORDERS GROUP BY 1) SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM CTE WHERE A > 0 AND B > 0 AND C = 0) ORDER BY 1, CUSTOMERS.customer_id NULLS LAST;

/*
Prediction Result:
(9, 'C')
*/