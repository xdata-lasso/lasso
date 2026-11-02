-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1102, 'Stephanie Ross');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1107, 'Stephanie Ross');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1113, 'Zachary Hicks');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1114, 'Anthony Rodriguez');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1112, 'Rebecca Henderson');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1103, 1102, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1104, 1102, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1108, 1102, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1109, 1102, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1110, 1102, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1111, NULL, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1102, 'Stephanie Ross')
*/

-- Prediction Query
WITH TABLE_A AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A'), TABLE_B AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B'), TABLE_C AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') SELECT DISTINCT C.CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE C.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM TABLE_A) AND C.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM TABLE_B) AND NOT C.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM TABLE_C) ORDER BY C.CUSTOMER_ID, CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
*/