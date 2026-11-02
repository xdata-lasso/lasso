-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (2, 'Alice');
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (1, 'Bob');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (1, 2, 'A');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (2, 2, 'B');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (3, 1, 'A');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (4, 1, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'Bob')
(2, 'Alice')
*/

-- Prediction Query
WITH CUSTOMER_TO_MATCH AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C')) SELECT M.CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS AS C JOIN CUSTOMER_TO_MATCH AS M ON C.CUSTOMER_ID = M.CUSTOMER_ID;

/*
Prediction Result:
(2, 'Alice')
(1, 'Bob')
*/