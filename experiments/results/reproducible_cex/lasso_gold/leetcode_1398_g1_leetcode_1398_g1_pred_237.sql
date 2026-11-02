-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1285, 'Victoria Larson');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1286, 'Stephanie Salazar');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1287, 'Kathy Rivas');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1288, 1285, 'C ');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1289, 1285, 'A');
INSERT INTO "orders" ("order_id", "customer_id", "product_name") VALUES (1290, 1285, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1285, 'Victoria Larson')
*/

-- Prediction Query
SELECT A.CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, GROUP_CONCAT(PRODUCT_NAME) AS PRODUCTS FROM ORDERS GROUP BY CUSTOMER_ID) AS A JOIN CUSTOMERS AS C ON A.CUSTOMER_ID = C.CUSTOMER_ID WHERE PRODUCTS LIKE '%A,B%' AND PRODUCTS NOT LIKE '%C%';

/*
Prediction Result:
*/