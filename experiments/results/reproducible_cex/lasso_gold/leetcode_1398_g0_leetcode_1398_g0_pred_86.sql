-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1001, 'Allison Hill');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1006, 'Allison Hill');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1002, 1001, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1003, 1001, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1007, 1001, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1001, 'Allison Hill')
*/

-- Prediction Query
WITH CTE AS (SELECT O.CUSTOMER_ID, C.CUSTOMER_NAME, O.PRODUCT_NAME, SUM(IIF(PRODUCT_NAME = 'A', '1', '0')) AS A, SUM(IIF(PRODUCT_NAME = 'B', '1', '0')) AS B, SUM(IIF(PRODUCT_NAME = 'C', '1', '0')) AS C FROM CUSTOMERS AS C LEFT JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID GROUP BY 1) SELECT CTE.CUSTOMER_ID, CTE.CUSTOMER_NAME FROM CTE WHERE A = 1 AND B = 1 AND C = 0;

/*
Prediction Result:
*/