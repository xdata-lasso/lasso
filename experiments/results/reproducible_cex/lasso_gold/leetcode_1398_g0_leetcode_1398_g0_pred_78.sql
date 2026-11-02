-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (0, 'Cassandra Gaines');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1163, 'Cassandra Gaines');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (-1, 'Elizabeth Fowler');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1170, 'Elizabeth Fowler');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1159, 0, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1160, 0, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1164, 0, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1166, -1, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1167, -1, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1171, -1, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(-1, 'Elizabeth Fowler')
(0, 'Cassandra Gaines')
*/

-- Prediction Query
WITH CUSTOMERC AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C' GROUP BY CUSTOMER_ID), CUSTOMERA AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A' GROUP BY CUSTOMER_ID), CUSTOMERB AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B' GROUP BY CUSTOMER_ID) SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS JOIN ORDERS USING (CUSTOMER_ID) JOIN CUSTOMERA USING (CUSTOMER_ID) JOIN CUSTOMERB USING (CUSTOMER_ID) WHERE NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM CUSTOMERC) AND CUSTOMER_ID GROUP BY CUSTOMER_ID, CUSTOMER_NAME ORDER BY CUSTOMER_ID, CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
(-1, 'Elizabeth Fowler')
*/