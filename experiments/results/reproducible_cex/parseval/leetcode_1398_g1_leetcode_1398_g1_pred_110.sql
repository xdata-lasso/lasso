-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1, 'c_s_704f00');

INSERT INTO "customers" ("customer_id", "customer_name") VALUES (-2147483647, 'c_s_704f00');

INSERT INTO "customers" ("customer_id", "customer_name") VALUES (2, 'c_s_704f00');

INSERT INTO "customers" ("customer_id", "customer_name") VALUES (3, 'cus_8d1b6b');

-- Inserting into table: orders --
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483648, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483647, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (2, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (3, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483646, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483643, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483642, 2, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483641, 3, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483640, 3, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483639, 3, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483638, 2, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483637, 3, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483636, 3, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483635, 3, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483634, 2, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483633, 3, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483632, 3, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483631, 3, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483630, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483629, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483628, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483627, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483626, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483625, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483624, 1, 'a_s_d07c39');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483623, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483622, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483621, 1, 'b_s_687295');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483620, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483619, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483618, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483617, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483616, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483615, 1, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'c_s_704f00')
(3, 'cus_8d1b6b')
*/

-- Prediction Query
SELECT A.CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS AS A JOIN ORDERS AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID JOIN CUSTOMERS AS C ON A.CUSTOMER_ID = C.CUSTOMER_ID WHERE A.PRODUCT_NAME = 'A' AND B.PRODUCT_NAME = 'B' AND NOT A.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(3, 'cus_8d1b6b')
(3, 'cus_8d1b6b')
(3, 'cus_8d1b6b')
(3, 'cus_8d1b6b')
(3, 'cus_8d1b6b')
(3, 'cus_8d1b6b')
(3, 'cus_8d1b6b')
(3, 'cus_8d1b6b')
(3, 'cus_8d1b6b')
(3, 'cus_8d1b6b')
(3, 'cus_8d1b6b')
(3, 'cus_8d1b6b')
(3, 'cus_8d1b6b')
(3, 'cus_8d1b6b')
(3, 'cus_8d1b6b')
(3, 'cus_8d1b6b')
(3, 'cus_8d1b6b')
(3, 'cus_8d1b6b')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
(1, 'c_s_704f00')
*/