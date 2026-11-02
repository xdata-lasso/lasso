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
WITH ORDER_AB AS (SELECT CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME = 'C' THEN -1 WHEN PRODUCT_NAME = 'A' THEN 0.5 WHEN PRODUCT_NAME = 'B' THEN 0.5 ELSE 0 END) AS PRODUCT_COUNT FROM ORDERS GROUP BY CUSTOMER_ID HAVING PRODUCT_COUNT = 1) SELECT A.CUSTOMER_ID, B.CUSTOMER_NAME FROM ORDER_AB AS A LEFT JOIN CUSTOMERS AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID;

/*
Prediction Result:
*/