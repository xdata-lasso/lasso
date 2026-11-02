-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1262, 'Courtney Gonzalez');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1263, 'Jose Schultz');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1267, 'Robert Potter');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1261, 'Rebecca Jackson');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1268, 'David Alvarez');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1269, 'Angel Perry');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1264, 1262, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1265, 1262, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1266, 1262, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1270, 1261, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1271, 1261, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1272, 1261, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1261, 'Rebecca Jackson')
(1262, 'Courtney Gonzalez')
*/

-- Prediction Query
SELECT DISTINCT CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS LEFT JOIN CUSTOMERS USING (CUSTOMER_ID) WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(1262, 'Courtney Gonzalez')
(1261, 'Rebecca Jackson')
*/