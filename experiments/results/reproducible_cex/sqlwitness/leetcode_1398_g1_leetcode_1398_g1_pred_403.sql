-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'B'), (-1, 'A'), (3, 'A'), (2, 'B'), (1, NULL), (4, 'C'), (5, 'default2'), (6, 'B'), (7, 'C'), (8, 'B'), (9, 'default1'), (10, 'default1'), (11, NULL), (12, 'default2'), (13, 'default2'), (14, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 10, NULL), (1, 10, 'A'), (3, -1, 'A'), (2, 12, 'A'), (-1, NULL, 'C'), (4, 6, 'C'), (5, 0, NULL), (6, 8, 'default2'), (7, 4, 'A'), (8, 11, 'default2'), (9, 3, 'A'), (10, 11, 'B'), (11, 6, 'A'), (12, 4, 'C'), (13, -1, 'B'), (14, 8, 'A'), (15, 6, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(-1, 'A')
*/

-- Prediction Query
WITH CTE AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C'), CTE2 AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME IN ('A', 'B') AND NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM CTE) GROUP BY 1 HAVING COUNT(DISTINCT PRODUCT_NAME) = 2) SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM CTE2) ORDER BY 1, CUSTOMERS.customer_id NULLS LAST;

/*
Prediction Result:
*/