-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1156, 'Zachary Ferrell');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1157, 'Daniel Baker');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1158, 'Shirley Suarez');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1167, 'Christopher Bass');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1162, 'Lisa Archer');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1163, 'Aimee Montoya');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1159, 1156, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1160, 1156, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1161, 1156, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1164, 1156, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1165, 1156, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1166, 1156, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1156, 'Zachary Ferrell')
*/

-- Prediction Query
WITH T AS (SELECT CUSTOMER_ID FROM ORDERS AS O WHERE PRODUCT_NAME = 'B' AND CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C')) SELECT T.CUSTOMER_ID, C.CUSTOMER_NAME FROM T JOIN CUSTOMERS AS C ON T.CUSTOMER_ID = C.CUSTOMER_ID;

/*
Prediction Result:
(1156, 'Zachary Ferrell')
(1156, 'Zachary Ferrell')
*/