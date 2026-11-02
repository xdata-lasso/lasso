-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (11, 'C26');
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (26, NULL);
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (13, 26, 'B');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (12, 26, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT DISTINCT CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME IN ('A', 'B', 'C') THEN 1 ELSE 0 END) AS CNT, SUM(CASE WHEN PRODUCT_NAME IN ('A', 'B') THEN 1 ELSE 0 END) AS CNT1 FROM ORDERS GROUP BY CUSTOMER_ID HAVING SUM(CASE WHEN PRODUCT_NAME IN ('A', 'B', 'C') THEN 1 ELSE 0 END) <> 3 AND SUM(CASE WHEN PRODUCT_NAME IN ('A', 'B') THEN 1 ELSE 0 END) = 2) SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CTE AS C1 INNER JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = C1.CUSTOMER_ID;

/*
Prediction Result:
(26, None)
*/