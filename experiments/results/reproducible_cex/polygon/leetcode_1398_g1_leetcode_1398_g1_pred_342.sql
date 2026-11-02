-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (10, 'A0');
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (13, 'B28');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (12, 13, 'A15');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (11, NULL, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH TB AS (SELECT CUSTOMER_ID, IIF(PRODUCT_NAME = 'A', 1, 0) AS A, IIF(PRODUCT_NAME = 'B', 1, 0) AS B, IIF(PRODUCT_NAME = 'C', 1, 0) AS C FROM ORDERS), TB1 AS (SELECT CUSTOMER_ID FROM TB GROUP BY CUSTOMER_ID HAVING SUM(A) > 0 AND SUM(B) > 0 AND SUM(C) = 0) SELECT CUSTOMERS.* FROM CUSTOMERS JOIN TB1 USING (CUSTOMER_ID);

/*
Prediction Result:
*/