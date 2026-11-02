-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1, 'a_s_8117e7');

INSERT INTO "customers" ("customer_id", "customer_name") VALUES (-2147483647, 'a_s_726049');

INSERT INTO "customers" ("customer_id", "customer_name") VALUES (2, 'a_s_8117e7');

INSERT INTO "customers" ("customer_id", "customer_name") VALUES (4, 'cus_8d1b6b');

-- Inserting into table: orders --
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (2, 1, 'A');

INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (3, 1, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT * FROM (SELECT A.CUSTOMER_ID, A.CUSTOMER_NAME FROM CUSTOMERS AS A INNER JOIN ORDERS AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID WHERE B.PRODUCT_NAME = 'A' OR B.PRODUCT_NAME = 'B' GROUP BY A.CUSTOMER_ID HAVING COUNT(DISTINCT ORDER_ID) > 1) AS T WHERE NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(1, 'a_s_8117e7')
*/