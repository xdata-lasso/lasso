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
SELECT T1.CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS AS T1 CROSS JOIN ORDERS AS T2 JOIN CUSTOMERS ON T1.CUSTOMER_ID = T2.CUSTOMER_ID AND T1.PRODUCT_NAME = 'A' AND T2.PRODUCT_NAME = 'B' AND T1.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID WHERE NOT T1.CUSTOMER_ID IN (SELECT T1.CUSTOMER_ID FROM ORDERS AS T1 CROSS JOIN ORDERS AS T2 JOIN ORDERS AS T3 ON T1.CUSTOMER_ID = T2.CUSTOMER_ID AND T3.CUSTOMER_ID = T2.CUSTOMER_ID AND T1.PRODUCT_NAME = 'A' AND T2.PRODUCT_NAME = 'B' AND T3.PRODUCT_NAME = 'C');

/*
Prediction Result:
(1001, 'Allison Hill')
(1001, 'Allison Hill')
*/