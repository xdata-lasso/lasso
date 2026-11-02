-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (2, 'Bob');
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (1, 'Alice');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (1, 1, 'A');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (2, 1, 'B');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (3, 2, 'A');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (4, 2, 'B');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (5, NULL, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'Alice')
(2, 'Bob')
*/

-- Prediction Query
WITH B AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A' GROUP BY CUSTOMER_ID), D AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B' GROUP BY CUSTOMER_ID) SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C JOIN (SELECT B.CUSTOMER_ID FROM B JOIN D ON B.CUSTOMER_ID = D.CUSTOMER_ID) AS E ON C.CUSTOMER_ID = E.CUSTOMER_ID WHERE NOT C.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
*/