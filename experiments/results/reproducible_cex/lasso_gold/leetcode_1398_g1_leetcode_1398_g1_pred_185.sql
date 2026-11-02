-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1001, 'Allison Hill');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1002, 'Noah Rhodes');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1003, 'Angie Henderson');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1004, 1001, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1005, 1001, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1006, 1001, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1001, 'Allison Hill')
*/

-- Prediction Query
SELECT T1.CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS AS T1 CROSS JOIN ORDERS AS T2 JOIN CUSTOMERS ON T1.CUSTOMER_ID = T2.CUSTOMER_ID AND T1.PRODUCT_NAME = 'A' AND T2.PRODUCT_NAME = 'B' AND T1.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID WHERE NOT T1.CUSTOMER_ID IN (SELECT T1.CUSTOMER_ID FROM ORDERS AS T1 CROSS JOIN ORDERS AS T2 JOIN ORDERS AS T3 ON T1.CUSTOMER_ID = T2.CUSTOMER_ID AND T3.CUSTOMER_ID = T2.CUSTOMER_ID AND T1.PRODUCT_NAME = 'A' AND T2.PRODUCT_NAME = 'B' AND T3.PRODUCT_NAME = 'C');

/*
Prediction Result:
(1001, 'Allison Hill')
(1001, 'Allison Hill')
*/