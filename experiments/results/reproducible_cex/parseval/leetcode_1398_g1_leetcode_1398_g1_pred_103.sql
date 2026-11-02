-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1, 'cus_32e865');

INSERT INTO "customers" ("customer_id", "customer_name") VALUES (2, 'cus_32e865');

INSERT INTO "customers" ("customer_id", "customer_name") VALUES (-2147483647, 'cus_32e865');

-- Inserting into table: orders --
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483648, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483647, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483646, 2, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483645, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483644, 2, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483643, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483642, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483641, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483640, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483639, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483638, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483637, 1, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'cus_32e865')
(2, 'cus_32e865')
*/

-- Prediction Query
SELECT A.CUSTOMER_ID, CUSTOMERS.CUSTOMER_NAME FROM (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AS A JOIN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID LEFT JOIN CUSTOMERS ON A.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID WHERE NOT A.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(1, 'cus_32e865')
(1, 'cus_32e865')
(1, 'cus_32e865')
(1, 'cus_32e865')
(1, 'cus_32e865')
(2, 'cus_32e865')
(1, 'cus_32e865')
(1, 'cus_32e865')
(1, 'cus_32e865')
(1, 'cus_32e865')
(1, 'cus_32e865')
(1, 'cus_32e865')
(1, 'cus_32e865')
(1, 'cus_32e865')
(1, 'cus_32e865')
(1, 'cus_32e865')
(1, 'cus_32e865')
(1, 'cus_32e865')
(1, 'cus_32e865')
(1, 'cus_32e865')
(1, 'cus_32e865')
(1, 'cus_32e865')
(1, 'cus_32e865')
(1, 'cus_32e865')
(1, 'cus_32e865')
(1, 'cus_32e865')
*/