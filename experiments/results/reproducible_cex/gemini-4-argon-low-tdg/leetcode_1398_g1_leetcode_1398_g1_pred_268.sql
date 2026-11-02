-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Customers (customer_id, customer_name) VALUES (50, 'Zack');
INSERT INTO Customers (customer_id, customer_name) VALUES (10, 'Alpha');
INSERT INTO Customers (customer_id, customer_name) VALUES (30, 'Beta');
INSERT INTO Customers (customer_id, customer_name) VALUES (5, 'Alpha');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (1, 50, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (2, 50, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (3, 10, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (4, 10, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (5, 30, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (6, 30, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (7, 30, 'E');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (8, 5, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (9, 5, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(5, 'Alpha')
(10, 'Alpha')
(30, 'Beta')
(50, 'Zack')
*/

-- Prediction Query
WITH A AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A'), B AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B'), C AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C'), TEMP AS (SELECT CUSTOMER_ID FROM A WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM B) AND NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM C)) SELECT DISTINCT T.CUSTOMER_ID, C.CUSTOMER_NAME FROM TEMP AS T JOIN CUSTOMERS AS C ON T.CUSTOMER_ID = C.CUSTOMER_ID;

/*
Prediction Result:
(50, 'Zack')
(10, 'Alpha')
(30, 'Beta')
(5, 'Alpha')
*/