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
SELECT B.CUSTOMER_ID, B.CUSTOMER_NAME FROM (SELECT A.CUSTOMER_ID, A.CUSTOMER_NAME, SUM(CASE WHEN A.PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) AS PRODUCTA, SUM(CASE WHEN A.PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) AS PRODUCTB, SUM(CASE WHEN A.PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) AS PRODUCTC FROM (SELECT ORDERS.CUSTOMER_ID, ORDERS.PRODUCT_NAME, CUSTOMERS.CUSTOMER_NAME FROM ORDERS LEFT JOIN CUSTOMERS ON ORDERS.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID) AS A GROUP BY A.CUSTOMER_ID, A.CUSTOMER_NAME) AS B WHERE B.PRODUCTA > 0 AND B.PRODUCTB > 0 AND B.PRODUCTC = 0;

/*
Prediction Result:
(1110, 'Zachary Hicks')
*/