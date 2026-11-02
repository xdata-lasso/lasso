-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Customers (customer_id, customer_name) VALUES (10, 'MultiBuyer');
INSERT INTO Customers (customer_id, customer_name) VALUES (20, 'MultiWithC');
INSERT INTO Customers (customer_id, customer_name) VALUES (30, 'OnlyA_Multi');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (1, 10, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (2, 10, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (3, 10, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (4, 10, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (5, 10, 'D');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (6, 20, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (7, 20, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (8, 20, 'C');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (9, 20, 'C');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (10, 30, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (11, 30, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(10, 'MultiBuyer')
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT O.CUSTOMER_ID, C.CUSTOMER_NAME, SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 100 WHEN PRODUCT_NAME = 'B' THEN 10 WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) AS PRODUCT_INDEX FROM ORDERS AS O JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID GROUP BY O.CUSTOMER_ID, C.CUSTOMER_NAME) AS TMP WHERE PRODUCT_INDEX = 110;

/*
Prediction Result:
*/