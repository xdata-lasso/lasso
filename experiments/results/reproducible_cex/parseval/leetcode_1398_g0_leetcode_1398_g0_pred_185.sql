-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1, 'cus_063295');

-- Inserting into table: orders --
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (2, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (3, 1, 'B');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483648, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483645, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483644, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483643, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483642, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483641, 1, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'cus_063295')
*/

-- Prediction Query
SELECT T1.CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS AS T1 CROSS JOIN ORDERS AS T2 JOIN CUSTOMERS ON T1.CUSTOMER_ID = T2.CUSTOMER_ID AND T1.PRODUCT_NAME = 'A' AND T2.PRODUCT_NAME = 'B' AND T1.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID WHERE NOT T1.CUSTOMER_ID IN (SELECT T1.CUSTOMER_ID FROM ORDERS AS T1 CROSS JOIN ORDERS AS T2 JOIN ORDERS AS T3 ON T1.CUSTOMER_ID = T2.CUSTOMER_ID AND T3.CUSTOMER_ID = T2.CUSTOMER_ID AND T1.PRODUCT_NAME = 'A' AND T2.PRODUCT_NAME = 'B' AND T3.PRODUCT_NAME = 'C');

/*
Prediction Result:
(1, 'cus_063295')
(1, 'cus_063295')
(1, 'cus_063295')
(1, 'cus_063295')
(1, 'cus_063295')
(1, 'cus_063295')
(1, 'cus_063295')
(1, 'cus_063295')
(1, 'cus_063295')
(1, 'cus_063295')
(1, 'cus_063295')
(1, 'cus_063295')
*/