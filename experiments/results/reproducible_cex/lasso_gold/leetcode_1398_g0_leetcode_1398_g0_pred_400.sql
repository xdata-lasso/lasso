-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1031, 'Monica Herrera');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1034, 'Monica Herrera');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1032, 1031, 'Abigail Shaffer');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1035, 1031, 'Abigail Shaffer');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE1 AS (SELECT CUSTOMER_ID, GROUP_CONCAT(DISTINCT PRODUCT_NAME) AS CT FROM ORDERS GROUP BY 1), CTE2 AS (SELECT CUSTOMER_ID FROM CTE1 WHERE CT NOT LIKE '%C%' AND CT LIKE '%A%' AND CT LIKE '%B%') SELECT C.CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS AS C JOIN CTE2 ON C.CUSTOMER_ID = CTE2.CUSTOMER_ID;

/*
Prediction Result:
(1031, 'Monica Herrera')
*/