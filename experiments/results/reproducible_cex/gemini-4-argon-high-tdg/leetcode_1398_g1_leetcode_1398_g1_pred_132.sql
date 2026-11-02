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
SELECT C.CUSTOMER_ID, CU.CUSTOMER_NAME FROM (SELECT O1.CUSTOMER_ID, O3.PRODUCT_NAME FROM ORDERS AS O1 LEFT JOIN ORDERS AS O2 ON O1.CUSTOMER_ID = O2.CUSTOMER_ID LEFT JOIN (SELECT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS WHERE PRODUCT_NAME = 'C') AS O3 ON O3.CUSTOMER_ID = O1.CUSTOMER_ID WHERE O1.PRODUCT_NAME = 'A' AND O2.PRODUCT_NAME = 'B') AS C LEFT JOIN CUSTOMERS AS CU ON CU.CUSTOMER_ID = C.CUSTOMER_ID WHERE C.PRODUCT_NAME IS NULL;

/*
Prediction Result:
(1, 'Multi_AB')
(1, 'Multi_AB')
(1, 'Multi_AB')
(1, 'Multi_AB')
(1, 'Multi_AB')
(1, 'Multi_AB')
*/