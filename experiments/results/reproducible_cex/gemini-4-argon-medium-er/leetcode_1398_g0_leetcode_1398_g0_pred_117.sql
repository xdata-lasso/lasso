-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (1, 'Alice');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (1, 1, 'A');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (2, 1, 'B');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (3, NULL, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O ON O.CUSTOMER_ID = C.CUSTOMER_ID GROUP BY C.CUSTOMER_ID HAVING SUM(O.PRODUCT_NAME = 'A') > 0 AND SUM(O.PRODUCT_NAME = 'B') > 0 AND SUM(O.PRODUCT_NAME = 'C') = 0 ORDER BY C.CUSTOMER_ID, C.CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
(1, 'Alice')
*/