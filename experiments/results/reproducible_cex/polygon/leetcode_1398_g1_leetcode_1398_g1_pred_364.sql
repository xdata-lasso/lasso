-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (13, 'A12');
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (12, 'B22');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (15, 12, 'A');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (14, 12, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT ORD.CUSTOMER_ID, CUS.CUSTOMER_NAME, SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 WHEN PRODUCT_NAME = 'B' THEN 1 WHEN PRODUCT_NAME = 'C' THEN -1 ELSE 0 END) AS SCORE FROM ORDERS AS ORD JOIN CUSTOMERS AS CUS ON ORD.CUSTOMER_ID = CUS.CUSTOMER_ID GROUP BY 1) AS A WHERE SCORE >= 2;

/*
Prediction Result:
(12, 'B22')
*/