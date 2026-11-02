-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (18, 'A21');
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (21, 'A21');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (20, 21, 'C');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (19, NULL, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH NUM_PROD_ORDERS AS (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS NUM_A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS NUM_B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS NUM_C FROM ORDERS GROUP BY CUSTOMER_ID) SELECT * FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM NUM_PROD_ORDERS WHERE NUM_A > 0 AND NUM_B > 0 AND NUM_C = 0) ORDER BY CUSTOMER_ID;

/*
Prediction Result:
*/