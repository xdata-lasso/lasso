-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1, 'a_s_1b4f01');

INSERT INTO "customers" ("customer_id", "customer_name") VALUES (2, 'a_s_1b4f01');

INSERT INTO "customers" ("customer_id", "customer_name") VALUES (4, 'cus_8d1b6b');

-- Inserting into table: orders --
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483648, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483647, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483646, 4, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483645, 4, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483644, 4, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483643, 4, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483642, 4, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483641, 4, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483640, 4, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483639, 4, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483638, 4, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483637, 4, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (2, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (3, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483634, 1, NULL);

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483633, 1, NULL);

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483632, 1, NULL);

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483631, 1, NULL);

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483630, 1, NULL);

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483629, 1, NULL);

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483628, 1, NULL);

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483627, 1, NULL);

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483626, 1, NULL);

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483625, 1, NULL);

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483624, 1, NULL);

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483623, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT A.CUSTOMER_ID, A.CUSTOMER_NAME FROM CUSTOMERS AS A INNER JOIN ORDERS AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID WHERE B.PRODUCT_NAME IN ('A', 'B') AND NOT A.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') GROUP BY A.CUSTOMER_ID, A.CUSTOMER_NAME HAVING COUNT(B.PRODUCT_NAME) >= 2;

/*
Prediction Result:
(1, 'a_s_1b4f01')
(4, 'cus_8d1b6b')
*/