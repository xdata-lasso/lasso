-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (20, 'B1');
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (19, 'B1');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (22, NULL, 'A');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (21, NULL, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT O.CUSTOMER_ID AS CUSTOMER_ID, C.CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(PRODUCT_NAME = 'A') AS CA, SUM(PRODUCT_NAME = 'B') AS CB, SUM(PRODUCT_NAME = 'C') AS CC FROM ORDERS GROUP BY CUSTOMER_ID) AS O LEFT JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID WHERE CA > 0 AND CB > 0 AND CC = 0 ORDER BY CUSTOMER_ID;

/*
Prediction Result:
(None, None)
*/