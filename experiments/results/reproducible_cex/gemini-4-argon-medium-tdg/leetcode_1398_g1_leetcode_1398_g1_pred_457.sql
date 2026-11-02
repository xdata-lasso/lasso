-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO Customers (customer_id, customer_name) VALUES (1, NULL);
INSERT INTO Customers (customer_id, customer_name) VALUES (2, 'Bob');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (1, 1, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (2, 1, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (3, NULL, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (4, NULL, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (5, 2, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (6, 2, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (7, 2, 'C');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (8, 2, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, None)
*/

-- Prediction Query
WITH GET_ORDERS AS (SELECT CUSTOMER_ID, COUNT(DISTINCT CASE WHEN PRODUCT_NAME = 'A' THEN PRODUCT_NAME WHEN PRODUCT_NAME = 'B' THEN PRODUCT_NAME ELSE NULL END) AS C1, SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 WHEN PRODUCT_NAME = 'B' THEN 1 WHEN PRODUCT_NAME = 'C' THEN -2 ELSE 0 END) AS S1 FROM ORDERS GROUP BY CUSTOMER_ID) SELECT A.CUSTOMER_ID, B.CUSTOMER_NAME FROM GET_ORDERS AS A LEFT JOIN CUSTOMERS AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID WHERE S1 >= 2 AND C1 >= 2;

/*
Prediction Result:
(None, None)
(1, None)
*/