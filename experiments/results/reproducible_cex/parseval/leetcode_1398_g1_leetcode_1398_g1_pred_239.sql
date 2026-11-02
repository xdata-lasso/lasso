-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1, 'c_s_7cda96');

INSERT INTO "customers" ("customer_id", "customer_name") VALUES (-2147483647, 'c_s_7cda96');

INSERT INTO "customers" ("customer_id", "customer_name") VALUES (2, 'cus_8d1b6b');

-- Inserting into table: orders --
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483648, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483647, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483646, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483645, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483644, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483643, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483642, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483641, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483640, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483639, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483638, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483637, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483636, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483635, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483634, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483633, -2147483647, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483632, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483631, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483630, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483629, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483628, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483627, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483626, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483625, 2, 'A,B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (2, 1, 'ord_ee1ea6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT A.CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, GROUP_CONCAT(PRODUCT_NAME) AS PRODUCTS FROM ORDERS GROUP BY CUSTOMER_ID) AS A JOIN CUSTOMERS AS C ON A.CUSTOMER_ID = C.CUSTOMER_ID WHERE PRODUCTS LIKE '%A,B%' AND PRODUCTS NOT LIKE '%C%';

/*
Prediction Result:
(2, 'cus_8d1b6b')
*/