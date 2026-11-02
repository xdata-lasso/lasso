-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (12, 'C14');
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (11, 'C14');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (13, NULL, 'B');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (29, NULL, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT A.CUSTOMER_ID, B.CUSTOMER_NAME FROM ORDERS AS A LEFT JOIN CUSTOMERS AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID GROUP BY A.CUSTOMER_ID HAVING SUM(IIF(A.PRODUCT_NAME = 'A', 1, 0)) > 0 AND SUM(IIF(A.PRODUCT_NAME = 'B', 1, 0)) > 0 AND SUM(IIF(A.PRODUCT_NAME = 'C', 1, 0)) = 0;

/*
Prediction Result:
(None, None)
*/