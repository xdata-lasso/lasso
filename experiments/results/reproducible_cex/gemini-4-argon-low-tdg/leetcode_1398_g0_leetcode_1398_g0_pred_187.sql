-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Duplicates and Count Traps: Tests queries that omit DISTINCT on joins or count total orders = 2.
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (10, 'Multi_AB');
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (20, 'Double_A');
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (30, 'Double_B');
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (40, 'AB_Plus_D');
-- Bought A twice, B twice (Valid, should appear once)
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (201, 10, 'A');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (202, 10, 'A');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (203, 10, 'B');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (204, 10, 'B');
-- Bought A twice, no B (Invalid, catches HAVING COUNT(product_name) = 2 without DISTINCT)
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (205, 20, 'A');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (206, 20, 'A');
-- Bought B twice, no A (Invalid)
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (207, 30, 'B');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (208, 30, 'B');
-- Bought A, B, and D (Valid, catches queries that restrict total distinct products to 2)
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (209, 40, 'A');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (210, 40, 'B');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (211, 40, 'D');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(10, 'Multi_AB')
(40, 'AB_Plus_D')
*/

-- Prediction Query
WITH AB AS (SELECT C.CUSTOMER_ID AS ID, C.CUSTOMER_NAME AS NAME FROM CUSTOMERS AS C JOIN ORDERS AS O ON O.CUSTOMER_ID = C.CUSTOMER_ID JOIN ORDERS AS O2 ON O2.CUSTOMER_ID = C.CUSTOMER_ID WHERE O.PRODUCT_NAME = 'A' AND O2.PRODUCT_NAME = 'B'), HAVEC AS (SELECT C2.CUSTOMER_ID AS ID2, C2.CUSTOMER_NAME AS NAME2 FROM CUSTOMERS AS C2 JOIN ORDERS AS O4 ON O4.CUSTOMER_ID = C2.CUSTOMER_ID WHERE O4.PRODUCT_NAME = 'C'), JOINER AS (SELECT * FROM AB LEFT JOIN HAVEC ON AB.ID = HAVEC.ID2) SELECT ID AS CUSTOMER_ID, NAME AS CUSTOMER_NAME FROM JOINER WHERE ID2 IS NULL;

/*
Prediction Result:
(10, 'Multi_AB')
(10, 'Multi_AB')
(10, 'Multi_AB')
(10, 'Multi_AB')
(40, 'AB_Plus_D')
*/