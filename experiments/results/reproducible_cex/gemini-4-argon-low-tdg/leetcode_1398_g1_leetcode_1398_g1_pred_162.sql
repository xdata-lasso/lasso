-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO Customers (customer_id, customer_name) VALUES (1, 'NullAndCaseTest1');
INSERT INTO Customers (customer_id, customer_name) VALUES (2, 'NullAndCaseTest2');
INSERT INTO Customers (customer_id, customer_name) VALUES (3, 'NullAndCaseTest3');
INSERT INTO Customers (customer_id, customer_name) VALUES (4, NULL);
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (1, 1, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (2, 1, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (3, 1, NULL);
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (4, 1, 'c');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (5, 2, 'a');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (6, 2, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (7, 3, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (8, 3, NULL);
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (9, 4, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (10, 4, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (11, NULL, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (12, NULL, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (13, NULL, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'NullAndCaseTest1')
(4, None)
*/

-- Prediction Query
SELECT DISTINCT CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME, O.PRODUCT_NAME FROM ORDERS AS O JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID) AS ITM WHERE (NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C')) GROUP BY CUSTOMER_ID, CUSTOMER_NAME HAVING SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) > 0 ORDER BY CUSTOMER_ID, CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
*/