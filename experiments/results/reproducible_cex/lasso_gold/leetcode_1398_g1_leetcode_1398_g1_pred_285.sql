-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1192, 'Rebecca Henderson');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1197, 'Rebecca Henderson');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1236, 'Fred Smith');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1237, 'Sherry Decker');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1238, 'Anthony Humphrey');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1249, 'Anthony Humphrey');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1193, 1192, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1194, 1192, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1195, NULL, 'C');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1198, NULL, 'C');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1239, 1236, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1240, 1236, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1241, 1236, 'Paula Moreno');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1242, 1236, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1243, 1236, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1244, 1236, 'Paula Moreno');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1245, NULL, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1246, NULL, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1247, NULL, 'Paula Moreno');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1250, NULL, 'Paula Moreno');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1192, 'Rebecca Henderson')
(1236, 'Fred Smith')
*/

-- Prediction Query
SELECT A.CUSTOMER_ID, C.CUSTOMER_NAME FROM (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME IN ('A', 'B') GROUP BY CUSTOMER_ID HAVING COUNT(DISTINCT PRODUCT_NAME) = 2) AS A JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = A.CUSTOMER_ID WHERE NOT A.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME IN ('A', 'B', 'C') GROUP BY CUSTOMER_ID HAVING COUNT(DISTINCT PRODUCT_NAME) = 3);

/*
Prediction Result:
*/