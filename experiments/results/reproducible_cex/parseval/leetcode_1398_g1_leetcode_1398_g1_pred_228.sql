-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1, 'c_s_09e671');

INSERT INTO "customers" ("customer_id", "customer_name") VALUES (2, 'c_s_09e671');

INSERT INTO "customers" ("customer_id", "customer_name") VALUES (-2147483647, 'c_s_09e671');

INSERT INTO "customers" ("customer_id", "customer_name") VALUES (3, 'cus_8d1b6b');

-- Inserting into table: orders --
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483648, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483647, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (2, 2, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (3, 3, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483646, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483643, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483642, 3, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483641, 2, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483640, 3, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483639, 3, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483638, 3, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483637, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483636, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483635, 3, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483634, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483633, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483632, 3, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483631, 2, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483630, 3, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483629, 3, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483628, 3, 'ord_ee1ea6');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483627, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483626, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483625, 3, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483624, 2, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483623, 3, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483622, 3, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483621, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483620, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483619, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483618, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483617, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483616, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483615, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483614, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483613, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483612, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483611, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483610, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483609, 1, 'o1__6d17b3');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483608, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483607, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483606, 1, 'o2__7f4ca8');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483605, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483604, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483603, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483602, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483601, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483600, 1, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'c_s_09e671')
(2, 'c_s_09e671')
(3, 'cus_8d1b6b')
*/

-- Prediction Query
WITH T1 AS (SELECT DISTINCT (C.CUSTOMER_ID) AS ID FROM CUSTOMERS AS C JOIN ORDERS AS O USING (CUSTOMER_ID) WHERE PRODUCT_NAME = 'C') SELECT O1.CUSTOMER_ID, C.CUSTOMER_NAME FROM ORDERS AS O1 JOIN ORDERS AS O2 USING (CUSTOMER_ID) JOIN CUSTOMERS AS C USING (CUSTOMER_ID) WHERE O1.PRODUCT_NAME = 'A' AND O2.PRODUCT_NAME = 'B' AND NOT CUSTOMER_ID IN (SELECT ID FROM T1);

/*
Prediction Result:
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(3, 'cus_8d1b6b')
(3, 'cus_8d1b6b')
(3, 'cus_8d1b6b')
(3, 'cus_8d1b6b')
(3, 'cus_8d1b6b')
(3, 'cus_8d1b6b')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(3, 'cus_8d1b6b')
(3, 'cus_8d1b6b')
(3, 'cus_8d1b6b')
(3, 'cus_8d1b6b')
(3, 'cus_8d1b6b')
(3, 'cus_8d1b6b')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(3, 'cus_8d1b6b')
(3, 'cus_8d1b6b')
(3, 'cus_8d1b6b')
(3, 'cus_8d1b6b')
(3, 'cus_8d1b6b')
(3, 'cus_8d1b6b')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(1, 'c_s_09e671')
(2, 'c_s_09e671')
(2, 'c_s_09e671')
(2, 'c_s_09e671')
(3, 'cus_8d1b6b')
(3, 'cus_8d1b6b')
(3, 'cus_8d1b6b')
*/