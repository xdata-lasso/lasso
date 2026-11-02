-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1007, 'Daniel Wagner');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1008, 'Cristian Santos');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1009, 'Connie Lawrence');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1010, 1007, 'Abigail Shaffer');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1013, 1007, 'Gina Moore');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT * FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM (SELECT CUSTOMER_ID, GROUP_CONCAT(PRODUCT_NAME, '') AS PRODUCTS FROM ORDERS GROUP BY CUSTOMER_ID) AS T1 WHERE PRODUCTS NOT LIKE '%C%' AND PRODUCTS LIKE '%A%' AND PRODUCTS LIKE '%B%');

/*
Prediction Result:
(1007, 'Daniel Wagner')
*/