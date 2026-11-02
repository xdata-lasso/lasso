-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1075, 'Tricia Valencia');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1080, 'Nathan Maldonado');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (0, NULL);
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1076, 0, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1077, 0, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1079, 1075, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1081, 1075, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(0, None)
*/

-- Prediction Query
SELECT DISTINCT C.CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS AS C CROSS JOIN ORDERS AS O WHERE C.CUSTOMER_ID = O.CUSTOMER_ID AND PRODUCT_NAME = 'A' AND CUSTOMER_NAME IN (SELECT DISTINCT CUSTOMER_NAME FROM CUSTOMERS AS C CROSS JOIN ORDERS AS O WHERE C.CUSTOMER_ID = O.CUSTOMER_ID AND PRODUCT_NAME = 'B') AND NOT CUSTOMER_NAME IN (SELECT DISTINCT CUSTOMER_NAME FROM CUSTOMERS AS C CROSS JOIN ORDERS AS O WHERE C.CUSTOMER_ID = O.CUSTOMER_ID AND PRODUCT_NAME = 'C');

/*
Prediction Result:
*/