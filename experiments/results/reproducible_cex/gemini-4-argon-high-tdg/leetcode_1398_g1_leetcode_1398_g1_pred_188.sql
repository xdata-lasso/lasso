-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Customers (customer_id, customer_name) VALUES (1, 'Multi_AB');
INSERT INTO Customers (customer_id, customer_name) VALUES (2, 'Double_A_Only');
INSERT INTO Customers (customer_id, customer_name) VALUES (3, 'Double_B_Only');
INSERT INTO Customers (customer_id, customer_name) VALUES (4, 'Multi_ABC');
INSERT INTO Customers (customer_id, customer_name) VALUES (5, 'Single_A_Multi_D');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (1, 1, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (2, 1, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (3, 1, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (4, 1, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (5, 1, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (6, 2, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (7, 2, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (8, 3, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (9, 3, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (10, 4, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (11, 4, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (12, 4, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (13, 4, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (14, 4, 'C');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (15, 5, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (16, 5, 'D');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (17, 5, 'D');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'Multi_AB')
*/

-- Prediction Query
WITH AB AS (SELECT C.CUSTOMER_ID AS ID, C.CUSTOMER_NAME AS NAME FROM CUSTOMERS AS C JOIN ORDERS AS O ON O.CUSTOMER_ID = C.CUSTOMER_ID JOIN ORDERS AS O2 ON O2.CUSTOMER_ID = C.CUSTOMER_ID WHERE O.PRODUCT_NAME = 'A' AND O2.PRODUCT_NAME = 'B'), HAVEC AS (SELECT C2.CUSTOMER_ID AS ID2, C2.CUSTOMER_NAME AS NAME2 FROM CUSTOMERS AS C2 JOIN ORDERS AS O4 ON O4.CUSTOMER_ID = C2.CUSTOMER_ID WHERE O4.PRODUCT_NAME = 'C'), JOINER AS (SELECT * FROM AB LEFT JOIN HAVEC ON AB.ID = HAVEC.ID2) SELECT ID AS CUSTOMER_ID, NAME AS CUSTOMER_NAME FROM JOINER WHERE ID2 IS NULL;

/*
Prediction Result:
(1, 'Multi_AB')
(1, 'Multi_AB')
(1, 'Multi_AB')
(1, 'Multi_AB')
(1, 'Multi_AB')
(1, 'Multi_AB')
*/