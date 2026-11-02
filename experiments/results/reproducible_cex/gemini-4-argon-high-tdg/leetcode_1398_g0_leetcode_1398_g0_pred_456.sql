-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Customers (customer_id, customer_name) VALUES (1, 'John Smith');
INSERT INTO Customers (customer_id, customer_name) VALUES (2, 'John Smith');
INSERT INTO Customers (customer_id, customer_name) VALUES (3, 'Jane Doe');
INSERT INTO Customers (customer_id, customer_name) VALUES (4, 'Jane Doe');
INSERT INTO Customers (customer_id, customer_name) VALUES (5, 'Bob');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (1, 1, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (2, 1, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (3, 1, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (4, 1, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (5, 1, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (6, 2, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (7, 2, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (8, 3, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (9, 3, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (10, 4, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (11, 4, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (12, 5, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (13, 5, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (14, 5, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (15, 5, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (16, 5, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'John Smith')
(2, 'John Smith')
*/

-- Prediction Query
WITH GET_ORDERS AS (SELECT CUSTOMER_ID, COUNT(DISTINCT CASE WHEN PRODUCT_NAME = 'A' THEN PRODUCT_NAME WHEN PRODUCT_NAME = 'B' THEN PRODUCT_NAME ELSE NULL END) AS C1, SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 WHEN PRODUCT_NAME = 'B' THEN 1 WHEN PRODUCT_NAME = 'C' THEN -2 ELSE 0 END) AS S1 FROM ORDERS GROUP BY CUSTOMER_ID) SELECT A.CUSTOMER_ID, B.CUSTOMER_NAME FROM GET_ORDERS AS A LEFT JOIN CUSTOMERS AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID WHERE S1 >= 2 AND C1 >= 2;

/*
Prediction Result:
(1, 'John Smith')
(2, 'John Smith')
(5, 'Bob')
*/