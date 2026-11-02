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
WITH TEMP AS (SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME, GROUP_CONCAT(O.PRODUCT_NAME) AS PRD_GRPS FROM CUSTOMERS AS C LEFT JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID GROUP BY 1, 2) SELECT CUSTOMER_ID, CUSTOMER_NAME FROM TEMP WHERE (PRD_GRPS LIKE '%A%' AND PRD_GRPS LIKE '%B%') AND (PRD_GRPS NOT LIKE '%C%');

/*
Prediction Result:
(1031, 'Monica Herrera')
*/