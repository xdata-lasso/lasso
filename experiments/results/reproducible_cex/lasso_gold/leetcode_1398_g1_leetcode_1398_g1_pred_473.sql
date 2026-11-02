-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1168, 'Matthew Mcmillan');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1169, 'Matthew Mcmillan');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1170, 'Matthew Mcmillan');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1174, 'Matthew Mcmillan');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1175, 'Matthew Mcmillan');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1176, 'Matthew Mcmillan');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1171, 1168, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1172, 1168, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1173, 1168, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1177, 1174, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1178, 1174, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1179, 1174, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1168, 'Matthew Mcmillan')
(1174, 'Matthew Mcmillan')
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_NAME, B.CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) AS A, SUM(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) AS B, SUM(CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) AS C FROM ORDERS AS A LEFT JOIN CUSTOMERS AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID GROUP BY CUSTOMER_NAME) AS T WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID, CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
(1168, 'Matthew Mcmillan')
*/