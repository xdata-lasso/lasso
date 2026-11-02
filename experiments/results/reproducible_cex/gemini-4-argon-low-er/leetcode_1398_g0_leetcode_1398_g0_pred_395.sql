-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (1, 'Bob');
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (2, 'Alice');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (1, 2, 'A');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (2, 2, 'B');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (3, 1, 'A');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (4, 1, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'Bob')
(2, 'Alice')
*/

-- Prediction Query
SELECT DISTINCT U.CUSTOMER_ID, U.CUSTOMER_NAME FROM (SELECT C.CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS AS O JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID WHERE PRODUCT_NAME = 'A') AS U JOIN (SELECT C.CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS AS O JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID WHERE PRODUCT_NAME = 'B') AS T ON T.CUSTOMER_ID = U.CUSTOMER_ID WHERE NOT U.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(2, 'Alice')
(1, 'Bob')
*/