-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1229, 'Elizabeth Fowler');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1234, 'Elizabeth Fowler');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (0, 'Fred Smith');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1255, 'Fred Smith');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1251, NULL);
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1253, NULL);
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1230, 1229, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1231, 1229, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1232, NULL, 'C');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1235, NULL, 'C');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1249, 0, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1250, 1251, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1252, 1253, 'C');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1256, NULL, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1229, 'Elizabeth Fowler')
*/

-- Prediction Query
WITH DATA1 AS (SELECT C.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O USING (CUSTOMER_ID) WHERE PRODUCT_NAME IN ('A')), DATA2 AS (SELECT C.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O USING (CUSTOMER_ID) WHERE PRODUCT_NAME IN ('B')) SELECT DISTINCT DATA1.CUSTOMER_ID, DATA1.CUSTOMER_NAME FROM DATA1 JOIN DATA2 USING (CUSTOMER_ID) WHERE NOT DATA1.CUSTOMER_NAME IN (SELECT CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O USING (CUSTOMER_ID) WHERE PRODUCT_NAME IN ('C')) ORDER BY DATA1.CUSTOMER_ID ASC, DATA1.CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
*/