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
SELECT V.CUSTOMER_ID, C.CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) AS SA, SUM(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) AS SB, SUM(CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) AS SC FROM ORDERS AS O WHERE 1 = 1 GROUP BY CUSTOMER_ID) AS V JOIN CUSTOMERS AS C ON V.CUSTOMER_ID = C.CUSTOMER_ID WHERE V.SA > 0 AND V.SB > 0 AND V.SC = 0 ORDER BY V.CUSTOMER_ID, C.customer_id NULLS LAST;

/*
Prediction Result:
(1, 'Alice')
*/