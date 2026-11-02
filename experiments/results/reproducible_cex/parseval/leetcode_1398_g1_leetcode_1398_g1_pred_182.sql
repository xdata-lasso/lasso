-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1, 'c_s_64df46');

INSERT INTO "customers" ("customer_id", "customer_name") VALUES (2, 'c_s_64df46');

INSERT INTO "customers" ("customer_id", "customer_name") VALUES (3, 'c_s_64df46');

-- Inserting into table: orders --
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483648, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (2, 2, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (3, 3, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483646, 3, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483643, 2, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483642, 2, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483641, 1, 'o1__046650');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483640, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483639, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483638, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483637, 1, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'c_s_64df46')
(3, 'c_s_64df46')
*/

-- Prediction Query
SELECT O1.CUSTOMER_ID, C.CUSTOMER_NAME FROM ORDERS AS O1 CROSS JOIN ORDERS AS O2 CROSS JOIN CUSTOMERS AS C WHERE O1.CUSTOMER_ID = C.CUSTOMER_ID AND O1.CUSTOMER_ID = O2.CUSTOMER_ID AND O1.PRODUCT_NAME = 'A' AND O2.PRODUCT_NAME = 'B' AND NOT O1.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY O1.CUSTOMER_ID, O1.order_id NULLS LAST, O2.order_id NULLS LAST, C.customer_id NULLS LAST;

/*
Prediction Result:
(1, 'c_s_64df46')
(1, 'c_s_64df46')
(1, 'c_s_64df46')
(1, 'c_s_64df46')
(1, 'c_s_64df46')
(3, 'c_s_64df46')
*/