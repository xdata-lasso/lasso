-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (20, 'B25');
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (25, NULL);
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (21, 25, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT C.* FROM (SELECT O.CUSTOMER_ID, SUM(O.PRODUCT_NAME = 'A') AS A, SUM(O.PRODUCT_NAME = 'B') AS B, SUM(O.PRODUCT_NAME = 'C') AS C FROM ORDERS AS O GROUP BY O.CUSTOMER_ID) AS OO LEFT OUTER JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = OO.CUSTOMER_ID WHERE OO.A > 0 AND OO.B > 0 AND OO.C = 0;

/*
Prediction Result:
*/