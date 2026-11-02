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
WITH AB AS (SELECT C.CUSTOMER_ID AS ID, C.CUSTOMER_NAME AS NAME FROM CUSTOMERS AS C JOIN ORDERS AS O ON O.CUSTOMER_ID = C.CUSTOMER_ID JOIN ORDERS AS O2 ON O2.CUSTOMER_ID = C.CUSTOMER_ID WHERE O.PRODUCT_NAME = 'A' AND O2.PRODUCT_NAME = 'B'), HAVEC AS (SELECT C2.CUSTOMER_ID AS ID2, C2.CUSTOMER_NAME AS NAME2 FROM CUSTOMERS AS C2 JOIN ORDERS AS O4 ON O4.CUSTOMER_ID = C2.CUSTOMER_ID WHERE O4.PRODUCT_NAME = 'C'), JOINER AS (SELECT * FROM AB LEFT JOIN HAVEC ON AB.ID = HAVEC.ID2) SELECT ID AS CUSTOMER_ID, NAME AS CUSTOMER_NAME FROM JOINER WHERE ID2 IS NULL;

/*
Prediction Result:
(10, 'Alice')
(2, 'Zoe')
*/