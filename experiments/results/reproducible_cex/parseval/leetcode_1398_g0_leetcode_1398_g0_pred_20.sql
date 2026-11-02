-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (2, 'c_s_7d88eb');

INSERT INTO "customers" ("customer_id", "customer_name") VALUES (4, 'c_s_7d88eb');

INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1, 'cus_8d1b6b');

-- Inserting into table: orders --
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (2, 2, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (3, 2, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483648, 2, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483645, 2, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483644, 2, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483643, 2, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483642, 2, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483641, 2, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483640, 2, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483639, 2, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483638, 2, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483637, 2, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483636, 2, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483635, 2, NULL);

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483634, 2, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483633, 2, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483632, 2, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483631, 2, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483630, 2, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT O.CUSTOMER_ID, C.CUSTOMER_NAME FROM ORDERS AS O JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID WHERE O.PRODUCT_NAME IN ('A', 'B') AND NOT O.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') GROUP BY O.CUSTOMER_ID HAVING COUNT(O.CUSTOMER_ID) > 1;

/*
Prediction Result:
(2, 'c_s_7d88eb')
*/