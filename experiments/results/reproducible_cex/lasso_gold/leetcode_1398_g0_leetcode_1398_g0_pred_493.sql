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
WITH DATA1 AS (SELECT C.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O USING (CUSTOMER_ID) WHERE PRODUCT_NAME IN ('A')), DATA2 AS (SELECT C.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O USING (CUSTOMER_ID) WHERE PRODUCT_NAME IN ('B')) SELECT DISTINCT DATA1.CUSTOMER_ID, DATA1.CUSTOMER_NAME FROM DATA1 JOIN DATA2 USING (CUSTOMER_ID) WHERE NOT DATA1.CUSTOMER_NAME IN (SELECT CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O USING (CUSTOMER_ID) WHERE PRODUCT_NAME IN ('C')) ORDER BY DATA1.CUSTOMER_ID ASC, DATA1.CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
(1110, 'Zachary Hicks')
*/