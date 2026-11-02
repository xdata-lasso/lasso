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
WITH T1 AS (SELECT CUSTOMER_ID, PRODUCT_NAME, COUNT(1) AS CN FROM ORDERS GROUP BY CUSTOMER_ID, PRODUCT_NAME), GET_TRANS AS (SELECT CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME = 'A' THEN CN END) AS A, SUM(CASE WHEN PRODUCT_NAME = 'B' THEN CN END) AS B, SUM(CASE WHEN PRODUCT_NAME = 'C' THEN CN END) AS C FROM T1 GROUP BY 1) SELECT G.CUSTOMER_ID, C.CUSTOMER_NAME FROM GET_TRANS AS G JOIN CUSTOMERS AS C ON G.CUSTOMER_ID = C.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C IS NULL ORDER BY 1, C.customer_id NULLS LAST;

/*
Prediction Result:
(1, 'Valid_AB')
(2, 'Valid_AB_NullName')
*/