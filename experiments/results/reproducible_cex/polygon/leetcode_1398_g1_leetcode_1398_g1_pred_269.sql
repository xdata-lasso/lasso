-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (14, NULL);
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (11, NULL);
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (13, 14, 'C');
INSERT INTO "Orders" ("order_id", "customer_id", "product_name") VALUES (12, 11, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT B.* FROM CUSTOMERS AS B INNER JOIN (SELECT CUSTOMER_ID, COUNT(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE NULL END) AS A, COUNT(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE NULL END) AS B, COUNT(CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE NULL END) AS C FROM ORDERS GROUP BY 1) AS A ON A.CUSTOMER_ID = B.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0;

/*
Prediction Result:
*/