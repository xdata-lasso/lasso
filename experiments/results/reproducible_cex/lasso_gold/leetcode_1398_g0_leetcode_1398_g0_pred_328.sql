-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (0, 'Sherry Decker');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1226, 'Sherry Decker');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1234, 'Anthony Humphrey');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1220, 0, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1221, 0, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1223, 0, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1224, 0, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1227, 0, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1228, 0, NULL);
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1229, 0, NULL);
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1231, 0, NULL);
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1232, 0, NULL);
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1235, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(0, 'Sherry Decker')
*/

-- Prediction Query
WITH T1 AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE (CUSTOMER_ID, 'A') IN (SELECT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS) AND (CUSTOMER_ID, 'B') IN (SELECT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS) AND NOT (CUSTOMER_ID, 'C') IN (SELECT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS)) SELECT * FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT * FROM T1);

/*
Prediction Result:
*/