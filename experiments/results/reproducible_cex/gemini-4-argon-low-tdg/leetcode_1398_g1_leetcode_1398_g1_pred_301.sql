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
SELECT T3.* FROM (SELECT T1.CUSTOMER_ID, CNT1, CNT2 FROM (SELECT CUSTOMER_ID, COUNT(DISTINCT ORDER_ID) AS CNT1 FROM ORDERS WHERE PRODUCT_NAME IN ('A', 'B') GROUP BY CUSTOMER_ID) AS T1 LEFT JOIN (SELECT CUSTOMER_ID, COUNT(DISTINCT ORDER_ID) AS CNT2 FROM ORDERS WHERE PRODUCT_NAME IN ('C') GROUP BY CUSTOMER_ID) AS T2 ON T1.CUSTOMER_ID = T2.CUSTOMER_ID WHERE CNT1 >= 2) AS T INNER JOIN (SELECT * FROM CUSTOMERS) AS T3 ON T.CUSTOMER_ID = T3.CUSTOMER_ID WHERE CNT2 IS NULL;

/*
Prediction Result:
(10, 'MultiBuyer')
(30, 'OnlyA_Multi')
*/