-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'C'), (1, 'D'), (2, 'C'), (0, NULL), (3, 'D'), (4, 'C'), (5, 'default1'), (6, 'default1'), (7, 'C'), (8, 'C'), (9, 'D'), (10, 'C'), (11, NULL), (12, 'C'), (13, 'A'), (14, 'B'), (15, 'default1'), (16, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 9, 'D'), (1, 11, 'D'), (2, 11, 'B'), (0, 15, 'B'), (3, 0, 'A'), (4, 0, 'A'), (5, 0, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(0, None)
*/

-- Prediction Query
WITH CTE AS (SELECT O.CUSTOMER_ID, C.CUSTOMER_NAME, SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) AS A, SUM(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) AS B, SUM(CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) AS C, SUM(CASE WHEN PRODUCT_NAME = 'D' THEN 1 ELSE 0 END) AS D FROM ORDERS AS O INNER JOIN CUSTOMERS AS C USING (CUSTOMER_ID) GROUP BY O.CUSTOMER_ID) SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CTE WHERE A = 1 AND B = 1 AND C = 0;

/*
Prediction Result:
*/