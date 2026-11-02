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
WITH CTE AS (SELECT ORDER_ID, CUSTOMER_ID, PRODUCT_NAME, CASE WHEN PRODUCT_NAME = 'A' THEN 1 WHEN PRODUCT_NAME = 'B' THEN 2 WHEN PRODUCT_NAME = 'C' THEN 3 ELSE 4 END AS CUSTOM_RNK FROM ORDERS) SELECT DISTINCT B.CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS AS A INNER JOIN CUSTOMERS AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID WHERE NOT A.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM CTE WHERE CUSTOM_RNK = 3) AND A.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM CTE WHERE CUSTOM_RNK = 1) AND A.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM CTE WHERE CUSTOM_RNK = 2);

/*
Prediction Result:
(1262, 'Courtney Gonzalez')
(1261, 'Rebecca Jackson')
*/