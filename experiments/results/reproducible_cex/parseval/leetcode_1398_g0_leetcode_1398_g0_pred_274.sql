-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1, 'b_s_12ad34');

INSERT INTO "customers" ("customer_id", "customer_name") VALUES (2, 'b_s_12ad34');

INSERT INTO "customers" ("customer_id", "customer_name") VALUES (-2147483647, 'b_s_12ad34');

INSERT INTO "customers" ("customer_id", "customer_name") VALUES (5, 'b_s_12ad34');

-- Inserting into table: orders --
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483648, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483647, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483646, 1, 'A');

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

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483635, 2, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483634, 2, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (2, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (3, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483633, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483630, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483629, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483628, 1, NULL);

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483627, 1, NULL);

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483626, 1, NULL);

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483625, 1, NULL);

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483624, 1, NULL);

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483623, 1, NULL);

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483622, 1, NULL);

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483621, 1, NULL);

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483620, 1, NULL);

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483619, 1, NULL);

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483618, 1, NULL);

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483617, 1, NULL);

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483616, 1, NULL);

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483615, 1, NULL);

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (-2147483614, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME IN ('A', 'B') GROUP BY CUSTOMER_ID HAVING COUNT(PRODUCT_NAME) >= 2) SELECT A.CUSTOMER_ID, B.CUSTOMER_NAME FROM CTE AS A JOIN CUSTOMERS AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID WHERE NOT A.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(1, 'b_s_12ad34')
(2, 'b_s_12ad34')
*/