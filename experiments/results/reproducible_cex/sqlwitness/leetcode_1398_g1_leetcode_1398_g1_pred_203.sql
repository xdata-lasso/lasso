-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default2'), (2, 'C'), (-1, 'default2'), (3, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (3, 2, 'B'), (0, -1, 'C'), (-1, 2, 'A'), (1, 2, NULL), (2, -1, 'A'), (4, 0, 'B'), (5, 2, 'default2'), (6, -1, 'A'), (7, NULL, NULL), (8, 0, 'C'), (9, 2, 'default1'), (10, 3, 'A'), (11, 0, 'C'), (12, -1, NULL), (13, 3, 'B'), (14, NULL, 'A'), (15, 3, 'C'), (16, 3, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(2, 'C')
*/

-- Prediction Query
WITH CTE AS (SELECT CUSTOMER_NAME, O.CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME IN ('A', 'B') THEN 1 WHEN PRODUCT_NAME = 'C' THEN -1 END) AS SUMS FROM ORDERS AS O INNER JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID GROUP BY CUSTOMER_NAME, O.CUSTOMER_ID) SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CTE WHERE SUMS = 2;

/*
Prediction Result:
(3, None)
(2, 'C')
*/