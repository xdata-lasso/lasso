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
SELECT C.CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME = 'A' OR PRODUCT_NAME = 'B' THEN 1 WHEN PRODUCT_NAME = 'C' THEN -100 ELSE 0 END) AS SCORE FROM ORDERS GROUP BY 1) AS A LEFT JOIN CUSTOMERS AS C ON A.CUSTOMER_ID = C.CUSTOMER_ID WHERE SCORE >= 2;

/*
Prediction Result:
(1040, 'Matthew Foster')
*/