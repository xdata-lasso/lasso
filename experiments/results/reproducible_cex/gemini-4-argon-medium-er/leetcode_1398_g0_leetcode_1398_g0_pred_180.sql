-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (1, 'Alice');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (1, 1, 'A');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (2, 1, 'A');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (3, 1, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'Alice')
*/

-- Prediction Query
SELECT O1.CUSTOMER_ID, C.CUSTOMER_NAME FROM ORDERS AS O1 CROSS JOIN ORDERS AS O2 CROSS JOIN CUSTOMERS AS C WHERE O1.CUSTOMER_ID = C.CUSTOMER_ID AND O1.CUSTOMER_ID = O2.CUSTOMER_ID AND O1.PRODUCT_NAME = 'A' AND O2.PRODUCT_NAME = 'B' AND NOT O1.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY O1.CUSTOMER_ID, O1.order_id NULLS LAST, O2.order_id NULLS LAST, C.customer_id NULLS LAST;

/*
Prediction Result:
(1, 'Alice')
(1, 'Alice')
*/