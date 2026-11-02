-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1, 'c_s_ff7682');

INSERT INTO "customers" ("customer_id", "customer_name") VALUES (0, 'c_s_ff7682');

INSERT INTO "customers" ("customer_id", "customer_name") VALUES (2, 'cus_8d1b6b');

INSERT INTO "customers" ("customer_id", "customer_name") VALUES (-1, 'c_s_ff7682');

INSERT INTO "customers" ("customer_id", "customer_name") VALUES (3, NULL);

-- Inserting into table: orders --
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483648, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483647, 2, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483646, 2, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483645, 2, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483644, 2, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483643, 2, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483642, 2, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (2, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (3, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483639, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (4, 3, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(2, 'cus_8d1b6b')
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE (PRODUCT_NAME = 'A' OR PRODUCT_NAME = 'B') AND NOT C.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') GROUP BY C.CUSTOMER_ID, CUSTOMER_NAME HAVING COUNT(CUSTOMER_NAME) = 2 ORDER BY C.CUSTOMER_ID, CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
*/