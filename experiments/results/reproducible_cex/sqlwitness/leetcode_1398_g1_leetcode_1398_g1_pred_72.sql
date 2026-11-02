-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'C'), (1, 'C'), (0, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, -1, 'A'), (-1, NULL, 'A'), (0, 0, NULL), (2, 1, 'B'), (3, 1, 'default2'), (4, 0, 'C'), (5, -1, 'default2'), (6, 1, 'A'), (7, 0, 'B'), (8, 1, 'B'), (9, 1, 'default2'), (10, 1, 'A'), (11, -1, NULL), (12, NULL, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'C')
*/

-- Prediction Query
WITH CTE AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A' AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B')) SELECT CTE.CUSTOMER_ID, CUSTOMERS.CUSTOMER_NAME FROM CTE LEFT JOIN CUSTOMERS ON CTE.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID WHERE NOT CTE.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(1, 'C')
(1, 'C')
*/