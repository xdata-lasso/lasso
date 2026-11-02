-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1021, 'Jamie Arnold');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1022, 'Lisa Hensley');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1023, 'Michele Williams');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1027, 'Dylan Miller');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1028, 'Brian Ramirez');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1029, 'Holly Wood');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1039, 'Derek Zuniga');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1033, 'Lisa Jackson');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1034, 'Carla Gray');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1024, 1021, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1025, 1021, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1026, 1021, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1030, 1027, NULL);
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1031, 1027, NULL);
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1032, 1027, NULL);
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1035, 1027, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1036, 1027, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1037, 1027, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1038, 1021, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1021, 'Jamie Arnold')
(1027, 'Dylan Miller')
*/

-- Prediction Query
SELECT DISTINCT O.CUSTOMER_ID, C.CUSTOMER_NAME FROM ORDERS AS O LEFT JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID WHERE (O.CUSTOMER_ID, 'A') IN (SELECT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS) AND (O.CUSTOMER_ID, 'B') IN (SELECT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS) AND NOT (O.CUSTOMER_ID, 'C') IN (SELECT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS);

/*
Prediction Result:
*/