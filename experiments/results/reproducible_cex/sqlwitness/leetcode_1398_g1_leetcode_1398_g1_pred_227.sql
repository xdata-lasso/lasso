-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'C'), (-1, NULL), (1, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, NULL, NULL), (0, 1, NULL), (2, 1, 'default1'), (1, 0, 'C'), (3, 1, 'A'), (4, 1, 'A'), (5, 0, 'B'), (6, 1, NULL), (7, 1, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'C')
*/

-- Prediction Query
WITH T1 AS (SELECT DISTINCT (C.CUSTOMER_ID) AS ID FROM CUSTOMERS AS C JOIN ORDERS AS O USING (CUSTOMER_ID) WHERE PRODUCT_NAME = 'C') SELECT O1.CUSTOMER_ID, C.CUSTOMER_NAME FROM ORDERS AS O1 JOIN ORDERS AS O2 USING (CUSTOMER_ID) JOIN CUSTOMERS AS C USING (CUSTOMER_ID) WHERE O1.PRODUCT_NAME = 'A' AND O2.PRODUCT_NAME = 'B' AND NOT CUSTOMER_ID IN (SELECT ID FROM T1);

/*
Prediction Result:
(1, 'C')
(1, 'C')
*/