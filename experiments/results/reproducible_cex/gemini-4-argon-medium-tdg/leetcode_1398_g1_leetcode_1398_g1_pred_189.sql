-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Customers (customer_id, customer_name) VALUES (10, 'Zack');
INSERT INTO Customers (customer_id, customer_name) VALUES (5, 'Yara');
INSERT INTO Customers (customer_id, customer_name) VALUES (1, 'Xander');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (1, 10, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (2, 10, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (3, 10, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (4, 10, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (5, 10, 'D');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (6, 5, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (7, 5, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (8, 5, NULL);
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (9, 1, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (10, 1, 'D');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(5, 'Yara')
(10, 'Zack')
*/

-- Prediction Query
WITH CTE1 AS (SELECT CUSTOMER_ID FROM ORDERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND PRODUCT_NAME = 'A' AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C')) SELECT CTE1.CUSTOMER_ID, CUSTOMER_NAME FROM CTE1 JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = CTE1.CUSTOMER_ID ORDER BY CTE1.CUSTOMER_ID, C.customer_id NULLS LAST;

/*
Prediction Result:
(5, 'Yara')
(10, 'Zack')
(10, 'Zack')
*/