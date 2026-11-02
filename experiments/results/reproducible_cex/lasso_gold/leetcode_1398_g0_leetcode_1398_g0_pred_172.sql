-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1066, 'Carla Gray');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1071, 'Carla Gray');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1067, 1066, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1068, 1066, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1072, 1066, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1073, 1066, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1066, 'Carla Gray')
*/

-- Prediction Query
SELECT O.CUSTOMER_ID, C.CUSTOMER_NAME FROM ORDERS AS O JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE O.PRODUCT_NAME = 'A' AND O.CUSTOMER_ID IN (SELECT O.CUSTOMER_ID FROM ORDERS AS O WHERE O.PRODUCT_NAME = 'B') AND NOT O.CUSTOMER_ID IN (SELECT O.CUSTOMER_ID FROM ORDERS AS O WHERE O.PRODUCT_NAME = 'C');

/*
Prediction Result:
(1066, 'Carla Gray')
(1066, 'Carla Gray')
*/