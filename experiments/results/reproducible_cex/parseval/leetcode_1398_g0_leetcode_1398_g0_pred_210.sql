-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1, 'cus_8445b1');

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
(1, 'cus_8445b1')
*/

-- Prediction Query
WITH CTE AS (SELECT ORDER_ID, CUSTOMER_ID, PRODUCT_NAME FROM ORDERS WHERE PRODUCT_NAME = 'A' OR PRODUCT_NAME = 'B'), CTE2 AS (SELECT CUSTOMER_ID, COUNT(PRODUCT_NAME) AS N FROM CTE GROUP BY 1), CTE3 AS (SELECT CUSTOMER_ID FROM CTE2 WHERE N = 2), CTE4 AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') SELECT DISTINCT O.CUSTOMER_ID, C.CUSTOMER_NAME FROM ORDERS AS O JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID WHERE O.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM CTE3) AND NOT O.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM CTE4);

/*
Prediction Result:
*/