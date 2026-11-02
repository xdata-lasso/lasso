-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1, 'c_s_5e068e');

INSERT INTO "customers" ("customer_id", "customer_name") VALUES (2, 'c_s_5e068e');

INSERT INTO "customers" ("customer_id", "customer_name") VALUES (-2147483647, 'c_s_5e068e');

INSERT INTO "customers" ("customer_id", "customer_name") VALUES (3, 'cus_8d1b6b');

-- Inserting into table: orders --
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483648, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483647, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483646, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483645, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483644, 2, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483643, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483642, 3, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483641, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483640, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483639, 3, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483638, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483637, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (2, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (3, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483634, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483633, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483632, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483631, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483630, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483629, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483628, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483627, 1, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'c_s_5e068e')
*/

-- Prediction Query
WITH T AS (SELECT CUSTOMER_ID FROM ORDERS AS O WHERE PRODUCT_NAME = 'B' AND CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C')) SELECT T.CUSTOMER_ID, C.CUSTOMER_NAME FROM T JOIN CUSTOMERS AS C ON T.CUSTOMER_ID = C.CUSTOMER_ID;

/*
Prediction Result:
(1, 'c_s_5e068e')
(1, 'c_s_5e068e')
(1, 'c_s_5e068e')
(1, 'c_s_5e068e')
(1, 'c_s_5e068e')
(1, 'c_s_5e068e')
(1, 'c_s_5e068e')
(1, 'c_s_5e068e')
*/