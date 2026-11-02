-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1123, 'Tricia Valencia');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1128, 'Tricia Valencia');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1124, NULL, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1125, NULL, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1129, NULL, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, PRODUCT_NAME, CASE WHEN PRODUCT_NAME = 'A' THEN 1 WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END AS TAG FROM ORDERS WHERE NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME IN ('C'))) AS T1 LEFT JOIN CUSTOMERS AS C ON (T1.CUSTOMER_ID = C.CUSTOMER_ID) WHERE T1.TAG = 1 GROUP BY T1.CUSTOMER_ID HAVING COUNT(DISTINCT PRODUCT_NAME) = 2;

/*
Prediction Result:
(None, None)
*/