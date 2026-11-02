-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (20, 'A24');
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (23, NULL);
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (22, 23, 'B');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (21, 23, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME, SUM(CASE WHEN PRODUCT_NAME IN ('A', 'B') THEN 1 WHEN PRODUCT_NAME IN ('C') THEN -1 END) AS SCORE FROM CUSTOMERS AS C LEFT JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID GROUP BY 1, 2) AS A WHERE SCORE = 2;

/*
Prediction Result:
(23, None)
*/