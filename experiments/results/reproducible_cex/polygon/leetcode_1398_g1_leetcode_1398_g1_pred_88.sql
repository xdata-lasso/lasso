-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (24, 'B25');
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (11, 'A24');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (13, 24, 'A');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (12, 24, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH ORDER_CNT AS (SELECT CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME IN ('A', 'B') THEN 1 WHEN PRODUCT_NAME = 'C' THEN -1 ELSE 0 END) AS CNT FROM ORDERS GROUP BY CUSTOMER_ID) SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM ORDER_CNT JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = ORDER_CNT.CUSTOMER_ID WHERE ORDER_CNT.CNT = 2;

/*
Prediction Result:
(24, 'B25')
*/