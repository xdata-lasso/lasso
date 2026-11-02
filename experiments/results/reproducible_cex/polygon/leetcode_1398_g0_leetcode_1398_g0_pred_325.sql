-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (21, 'B29');
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (20, 'B29');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (23, NULL, 'A');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (22, NULL, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT T.CUSTOMER_ID, T.CUSTOMER_NAME FROM (SELECT O.CUSTOMER_ID, C.CUSTOMER_NAME, SUM(IIF(O.PRODUCT_NAME = 'A', 1, 0)) AS PROD_A, SUM(IIF(O.PRODUCT_NAME = 'B', 1, 0)) AS PROD_B, SUM(IIF(O.PRODUCT_NAME = 'C', 1, 0)) AS PROD_C, SUM(IIF(O.PRODUCT_NAME = 'D', 1, 0)) AS PROD_D FROM ORDERS AS O LEFT JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID GROUP BY O.CUSTOMER_ID) AS T WHERE T.PROD_A > 0 AND T.PROD_B > 0 AND T.PROD_C = 0;

/*
Prediction Result:
(None, None)
*/