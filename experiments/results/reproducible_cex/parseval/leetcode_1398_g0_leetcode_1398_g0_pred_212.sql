-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1, 'c_s_e92c86');

INSERT INTO "customers" ("customer_id", "customer_name") VALUES (5, 'c_s_e92c86');

INSERT INTO "customers" ("customer_id", "customer_name") VALUES (2, 'cus_8d1b6b');

INSERT INTO "customers" ("customer_id", "customer_name") VALUES (3, 'cus_8d1b6b');

-- Inserting into table: orders --
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483648, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483647, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483646, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483645, 2, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483644, 2, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483643, 2, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483642, 2, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483641, 2, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483640, 2, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483639, 2, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483638, 2, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483637, 2, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (2, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (3, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483636, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483633, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483632, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483631, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483630, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483629, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483628, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483627, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483626, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483625, 2, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483624, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483623, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483622, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483621, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483620, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483619, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483618, 1, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483617, 3, 'BA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT CUSTOMER_ID, GROUP_CONCAT(PRODUCT_NAME) AS CONCAT FROM ORDERS GROUP BY CUSTOMER_ID) SELECT C.CUSTOMER_ID AS CUSTOMER_ID, C.CUSTOMER_NAME AS CUSTOMER_NAME FROM CTE JOIN CUSTOMERS AS C ON CTE.CUSTOMER_ID = C.CUSTOMER_ID WHERE (CTE.CONCAT LIKE '%A%B%' AND CTE.CONCAT NOT LIKE '%C%' OR CTE.CONCAT LIKE '%B%A%' AND CTE.CONCAT NOT LIKE '%C%');

/*
Prediction Result:
(3, 'cus_8d1b6b')
*/