-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1115, 'James Ferrell');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1120, 'James Ferrell');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1116, NULL, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1117, NULL, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1121, NULL, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT A.CUSTOMER_ID, C.CUSTOMER_NAME FROM (SELECT DISTINCT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS WHERE PRODUCT_NAME IN ('A', 'B', 'C')) AS A LEFT JOIN CUSTOMERS AS C ON A.CUSTOMER_ID = C.CUSTOMER_ID GROUP BY A.CUSTOMER_ID HAVING (SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END)) = 1 AND (SUM(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END)) = 1 AND (SUM(CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END)) = 0;

/*
Prediction Result:
(None, None)
*/