-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1102, 'Stephanie Ross');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1107, 'Stephanie Ross');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1113, 'Zachary Hicks');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1114, 'Anthony Rodriguez');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1112, 'Rebecca Henderson');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1103, 1102, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1104, 1102, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1108, 1102, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1109, 1102, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1110, 1102, 'B');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1111, NULL, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1102, 'Stephanie Ross')
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM ORDERS AS O JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID WHERE C.CUSTOMER_ID IN (SELECT O2.CUSTOMER_ID FROM ORDERS AS O2 WHERE O2.PRODUCT_NAME = 'A') AND C.CUSTOMER_ID IN (SELECT O2.CUSTOMER_ID FROM ORDERS AS O2 WHERE O2.PRODUCT_NAME = 'B') AND NOT C.CUSTOMER_ID IN (SELECT O2.CUSTOMER_ID FROM ORDERS AS O2 WHERE O2.PRODUCT_NAME = 'C') GROUP BY 1, 2 ORDER BY 1, C.CUSTOMER_ID NULLS LAST, C.CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
*/