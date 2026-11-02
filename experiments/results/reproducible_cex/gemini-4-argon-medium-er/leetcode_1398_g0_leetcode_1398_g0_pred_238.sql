-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (1, 'Alice');
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (2, 'Bob');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (101, 2, 'A');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (102, 2, 'B');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (103, 1, 'A');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (104, 1, 'B');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (105, NULL, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT COMPILED_RESULT.CUSTOMER_ID, C1.CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) AS A, SUM(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) AS B, SUM(CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS COMPILED_RESULT INNER JOIN CUSTOMERS AS C1 ON COMPILED_RESULT.CUSTOMER_ID = C1.CUSTOMER_ID AND A >= 1 AND B >= 1 AND C = 0;

/*
Prediction Result:
(1, 'Alice')
(2, 'Bob')
*/