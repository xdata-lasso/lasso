-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'default1'), (3, 'A'), (-1, 'C'), (0, 'default1'), (1, NULL), (4, 'B'), (5, 'A'), (6, 'A'), (7, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 0, 'C'), (1, 0, 'A'), (3, 4, 'default1'), (0, 6, 'default2'), (-1, 2, 'A'), (4, 6, 'default2'), (5, 5, 'default1'), (6, 1, 'A'), (7, 2, NULL), (8, 3, 'A'), (9, 2, 'A'), (10, 0, 'default1'), (11, -1, 'default2'), (12, 2, 'default1'), (13, 7, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT ORDER_ID, CUSTOMER_ID, PRODUCT_NAME FROM ORDERS WHERE PRODUCT_NAME = 'A' OR PRODUCT_NAME = 'B'), CTE2 AS (SELECT CUSTOMER_ID, COUNT(PRODUCT_NAME) AS N FROM CTE GROUP BY 1), CTE3 AS (SELECT CUSTOMER_ID FROM CTE2 WHERE N = 2), CTE4 AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') SELECT DISTINCT O.CUSTOMER_ID, C.CUSTOMER_NAME FROM ORDERS AS O JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID WHERE O.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM CTE3) AND NOT O.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM CTE4);

/*
Prediction Result:
(2, 'default1')
*/