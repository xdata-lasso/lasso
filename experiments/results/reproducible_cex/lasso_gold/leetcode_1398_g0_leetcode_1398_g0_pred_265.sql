-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1110, 'Zachary Hicks');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1115, 'Zachary Hicks');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1121, 'Anthony Rodriguez');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1122, 'Rebecca Henderson');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1120, 'James Ferrell');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1111, 1110, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1112, 1110, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1116, 1110, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1117, 1110, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1118, 1110, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1119, NULL, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH C1 AS (SELECT CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) AS A_COUNT, SUM(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) AS B_COUNT, SUM(CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) AS C_COUNT FROM ORDERS GROUP BY 1) SELECT C1.CUSTOMER_ID, C.CUSTOMER_NAME FROM C1 JOIN CUSTOMERS AS C ON C1.CUSTOMER_ID = C.CUSTOMER_ID WHERE (A_COUNT > 0 AND B_COUNT > 0 AND C_COUNT = 0) ORDER BY 1, C.customer_id NULLS LAST;

/*
Prediction Result:
(1110, 'Zachary Hicks')
*/