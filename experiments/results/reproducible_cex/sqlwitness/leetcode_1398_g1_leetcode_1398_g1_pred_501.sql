-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'C'), (-1, 'B'), (2, NULL), (1, 'default2'), (3, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 2, NULL), (2, 1, 'B'), (-1, 1, 'A'), (0, 3, 'B'), (3, 3, 'default1'), (4, -1, 'C'), (5, 2, 'B'), (6, -1, 'B'), (7, 1, 'B'), (8, 2, 'default1'), (9, -1, 'B'), (10, 3, 'C'), (11, 3, NULL), (12, 3, 'B'), (13, 0, 'A'), (14, -1, 'B'), (15, -1, 'default1'), (16, -1, NULL), (17, 1, 'default2'), (18, 2, 'default2'), (19, NULL, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'default2')
*/

-- Prediction Query
WITH CTE AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A'), CTE1 AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B'), CTE2 AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') SELECT DISTINCT CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS AS O JOIN CUSTOMERS AS C USING (CUSTOMER_ID) WHERE CUSTOMER_ID IN (SELECT * FROM CTE) AND CUSTOMER_ID IN (SELECT * FROM CTE1) AND NOT CUSTOMER_ID IN (SELECT * FROM CTE2);

/*
Prediction Result:
*/