-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Customers (customer_id, customer_name) VALUES (10, 'Alice');
INSERT INTO Customers (customer_id, customer_name) VALUES (2, 'Zoe');
INSERT INTO Customers (customer_id, customer_name) VALUES (3, 'Xander');
INSERT INTO Customers (customer_id, customer_name) VALUES (4, 'Will');
INSERT INTO Customers (customer_id, customer_name) VALUES (5, 'Victor');
INSERT INTO Customers (customer_id, customer_name) VALUES (6, 'Uma');
INSERT INTO Customers (customer_id, customer_name) VALUES (7, 'Tom');
INSERT INTO Customers (customer_id, customer_name) VALUES (8, 'Sam');
INSERT INTO Customers (customer_id, customer_name) VALUES (9, 'Rose');
INSERT INTO Customers (customer_id, customer_name) VALUES (1, 'Quinn');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (101, 10, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (102, 10, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (103, 10, 'D');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (104, 2, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (105, 2, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (106, 3, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (107, 4, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (108, 5, 'C');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (109, 6, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (110, 6, 'C');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (111, 7, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (112, 7, 'C');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (113, 8, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (114, 8, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (115, 8, 'C');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (116, 9, 'D');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(2, 'Zoe')
(10, 'Alice')
*/

-- Prediction Query
WITH A AS (SELECT DISTINCT (CUSTOMER_ID) AS CUSTS_A FROM ORDERS WHERE PRODUCT_NAME = 'A'), B AS (SELECT DISTINCT (CUSTOMER_ID) AS CUSTS_B FROM ORDERS WHERE PRODUCT_NAME = 'B'), C AS (SELECT DISTINCT (CUSTOMER_ID) AS CUSTS_C FROM ORDERS WHERE PRODUCT_NAME = 'C') SELECT CUSTOMERS.CUSTOMER_ID, CUSTOMERS.CUSTOMER_NAME FROM (SELECT A.CUSTS_A FROM A JOIN B ON A.CUSTS_A = B.CUSTS_B LEFT JOIN C ON A.CUSTS_A = C.CUSTS_C WHERE C.CUSTS_C IS NULL) AS T JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = T.CUSTS_A;

/*
Prediction Result:
(10, 'Alice')
(2, 'Zoe')
*/