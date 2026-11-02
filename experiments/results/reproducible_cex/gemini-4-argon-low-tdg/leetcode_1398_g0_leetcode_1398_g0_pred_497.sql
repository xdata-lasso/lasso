-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
-- Ordering and String Matching: Tests ORDER BY customer_id vs insertion order / customer_name, and LIKE vs '='.
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (50, 'Zebra');
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (10, 'Apple');
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (30, 'Mango');
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (20, 'Banana');
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (40, 'Peach');
-- Valid, inserted first, highest ID, last alphabetically
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (401, 50, 'A');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (402, 50, 'B');
-- Valid, lowest ID, first alphabetically
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (403, 10, 'A');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (404, 10, 'B');
-- Valid, middle ID, middle alphabetically (order of ID vs Name differs if we compare 30-Mango and 40-Peach vs 50-Zebra)
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (405, 30, 'A');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (406, 30, 'B');
-- Invalid: Substring/Case traps (Catches LIKE '%A%' or case-insensitive comparisons)
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (407, 20, 'a');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (408, 20, 'b');
-- Valid AB, but has 'CC' (Catches LIKE '%C%' excluding valid customers)
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (409, 40, 'A');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (410, 40, 'B');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (411, 40, 'CC');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(10, 'Apple')
(30, 'Mango')
(40, 'Peach')
(50, 'Zebra')
*/

-- Prediction Query
WITH CTE1 AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A'), CTE2 AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') SELECT DISTINCT CTE1.CUSTOMER_ID, C.CUSTOMER_NAME FROM CTE1 INNER JOIN CTE2 ON CTE1.CUSTOMER_ID = CTE2.CUSTOMER_ID INNER JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = CTE1.CUSTOMER_ID WHERE NOT CTE1.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(50, 'Zebra')
(10, 'Apple')
(30, 'Mango')
(40, 'Peach')
*/