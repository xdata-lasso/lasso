-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (13, 'A12');
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (12, 'B22');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (15, 12, 'B');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (14, 12, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT CUSTOMER_NAME, O.CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME IN ('A', 'B') THEN 1 WHEN PRODUCT_NAME = 'C' THEN -1 END) AS SUMS FROM ORDERS AS O INNER JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID GROUP BY CUSTOMER_NAME, O.CUSTOMER_ID) SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CTE WHERE SUMS = 2;

/*
Prediction Result:
(12, 'B22')
*/