-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1110, 'Zachary Hicks');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1115, 'Zachary Hicks');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1121, 'Anthony Rodriguez');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1122, 'Rebecca Henderson');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1120, 'James Ferrell');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1111, 1110, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1112, 1110, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1116, 1110, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1117, 1110, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1118, 1110, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1119, NULL, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT CUSTOMERS.CUSTOMER_ID, CUSTOMERS.CUSTOMER_NAME FROM (SELECT T.CUSTOMER_ID FROM (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B')) AS T LEFT JOIN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C')) AS W ON T.CUSTOMER_ID = W.CUSTOMER_ID WHERE W.CUSTOMER_ID IS NULL) AS X INNER JOIN CUSTOMERS ON X.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID;

/*
Prediction Result:
(1110, 'Zachary Hicks')
*/