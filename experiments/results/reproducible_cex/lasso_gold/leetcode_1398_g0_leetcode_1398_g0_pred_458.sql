-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1149, 'Jeffrey Chavez');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1151, 'Jeffrey Chavez');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1144, 'Sherri Baker');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1156, 'Sherri Baker');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1145, 1149, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1146, 1149, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1150, 1149, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1152, 1144, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1153, 1144, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1157, 1144, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1144, 'Sherri Baker')
(1149, 'Jeffrey Chavez')
*/

-- Prediction Query
WITH B AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A'), D AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C JOIN (SELECT B.CUSTOMER_ID FROM B JOIN D ON B.CUSTOMER_ID = D.CUSTOMER_ID) AS E ON C.CUSTOMER_ID = E.CUSTOMER_ID WHERE NOT C.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(1149, 'Jeffrey Chavez')
(1144, 'Sherri Baker')
*/