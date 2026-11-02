-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1040, 'Matthew Foster');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1041, 'Judy Baker');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1042, 'Justin Baker');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1043, 1040, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1044, 1040, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1045, 1040, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT C.CUSTOMER_ID, CUSTOMER_NAME, SUM(CNT) AS TC FROM (SELECT CUSTOMER_ID, CASE WHEN PRODUCT_NAME = 'A' THEN 1 WHEN PRODUCT_NAME = 'B' THEN 1 WHEN PRODUCT_NAME = 'C' THEN -1 ELSE 0 END AS CNT FROM ORDERS) AS T JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = T.CUSTOMER_ID GROUP BY C.CUSTOMER_ID) AS T1 WHERE TC >= 2;

/*
Prediction Result:
(1040, 'Matthew Foster')
*/