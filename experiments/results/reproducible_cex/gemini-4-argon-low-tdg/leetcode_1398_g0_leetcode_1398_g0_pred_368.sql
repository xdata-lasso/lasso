-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- NULL Handling: Tests NOT IN behavior when NULLs are present in customer_id or product_name.
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (1, 'Valid_AB');
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (2, 'Valid_AB_NullName');
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (3, 'Invalid_OnlyA_WithNullProd');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (301, 1, 'A');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (302, 1, 'B');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (303, 2, 'A');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (304, 2, 'B');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (305, 2, NULL);
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (306, 3, 'A');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (307, 3, NULL);
-- Order with NULL customer_id and product 'C' (Catches NOT IN subqueries that fail to filter properly or if NULL customer_id is returned in the 'C' subquery, causing NOT IN to evaluate to UNKNOWN for all rows)
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (308, NULL, 'C');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (309, NULL, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT C1.CUSTOMER_ID, C1.CUSTOMER_NAME FROM CUSTOMERS AS C1 JOIN ORDERS AS O1 ON C1.CUSTOMER_ID = O1.CUSTOMER_ID JOIN ORDERS AS O2 ON O1.CUSTOMER_ID = O2.CUSTOMER_ID AND O1.PRODUCT_NAME = 'A' AND O2.PRODUCT_NAME = 'B' LEFT JOIN ORDERS AS O3 ON O3.CUSTOMER_ID = O2.CUSTOMER_ID AND O3.PRODUCT_NAME = 'C' WHERE O3.CUSTOMER_ID IS NULL ORDER BY 1, C1.CUSTOMER_ID NULLS LAST, C1.CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
(1, 'Valid_AB')
(2, 'Valid_AB_NullName')
*/