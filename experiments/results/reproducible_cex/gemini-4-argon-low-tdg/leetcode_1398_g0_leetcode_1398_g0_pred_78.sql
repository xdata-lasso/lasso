-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
-- Same Name Different IDs & Negative/Zero IDs: Catches GROUP BY customer_name instead of customer_id.
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (-5, 'John Smith');
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (0, 'John Smith');
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (5, 'John Smith');
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (10, 'John Smith');
-- Both -5 and 0 are valid and have the exact same name (Both must be returned)
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (501, -5, 'A');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (502, -5, 'B');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (503, 0, 'A');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (504, 0, 'B');
-- 5 has only A, 10 has only B, but they share the name 'John Smith' (Catches grouping by customer_name)
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (505, 5, 'A');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (506, 10, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(-5, 'John Smith')
(0, 'John Smith')
*/

-- Prediction Query
WITH CUSTOMERC AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C' GROUP BY CUSTOMER_ID), CUSTOMERA AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A' GROUP BY CUSTOMER_ID), CUSTOMERB AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B' GROUP BY CUSTOMER_ID) SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS JOIN ORDERS USING (CUSTOMER_ID) JOIN CUSTOMERA USING (CUSTOMER_ID) JOIN CUSTOMERB USING (CUSTOMER_ID) WHERE NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM CUSTOMERC) AND CUSTOMER_ID GROUP BY CUSTOMER_ID, CUSTOMER_NAME ORDER BY CUSTOMER_ID, CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
(-5, 'John Smith')
*/