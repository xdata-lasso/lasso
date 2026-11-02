-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Customers (customer_id, customer_name) VALUES (1, 'Alice');
INSERT INTO Customers (customer_id, customer_name) VALUES (2, 'Bob');
INSERT INTO Customers (customer_id, customer_name) VALUES (3, 'Charlie');
INSERT INTO Customers (customer_id, customer_name) VALUES (4, 'David');
INSERT INTO Customers (customer_id, customer_name) VALUES (5, 'Eve');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (1, 1, 'AB');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (2, 2, 'a');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (3, 2, 'b');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (4, 3, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (5, 3, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (6, 3, 'c');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (7, 4, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (8, 4, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (9, 4, 'CA');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (10, 5, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (11, 5, 'BC');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(3, 'Charlie')
(4, 'David')
*/

-- Prediction Query
WITH TABLE1 AS (SELECT CUSTOMER_ID, GROUP_CONCAT(PRODUCT_NAME) AS TOTAL_PRODUCT FROM ORDERS GROUP BY 1) SELECT TABLE1.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME AS CUSTOMER_NAME FROM TABLE1 LEFT JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = TABLE1.CUSTOMER_ID WHERE TOTAL_PRODUCT LIKE '%A%' AND TOTAL_PRODUCT LIKE '%B%' AND TOTAL_PRODUCT NOT LIKE '%C%';

/*
Prediction Result:
(1, 'Alice')
(2, 'Bob')
*/