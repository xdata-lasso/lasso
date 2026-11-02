-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO Customers (customer_id, customer_name) VALUES (1, 'Alex');
INSERT INTO Customers (customer_id, customer_name) VALUES (2, 'Alex');
INSERT INTO Customers (customer_id, customer_name) VALUES (3, 'Sam');
INSERT INTO Customers (customer_id, customer_name) VALUES (4, 'Sam');
INSERT INTO Customers (customer_id, customer_name) VALUES (5, 'Pat');
INSERT INTO Customers (customer_id, customer_name) VALUES (6, 'Pat');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (1, 1, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (2, 2, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (3, 3, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (4, 3, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (5, 4, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (6, 4, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (7, 5, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (8, 5, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (9, 6, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (10, 6, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (11, 6, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(3, 'Sam')
(4, 'Sam')
(5, 'Pat')
*/

-- Prediction Query
SELECT DISTINCT C.CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS AS C CROSS JOIN ORDERS AS O WHERE C.CUSTOMER_ID = O.CUSTOMER_ID AND PRODUCT_NAME = 'A' AND CUSTOMER_NAME IN (SELECT DISTINCT CUSTOMER_NAME FROM CUSTOMERS AS C CROSS JOIN ORDERS AS O WHERE C.CUSTOMER_ID = O.CUSTOMER_ID AND PRODUCT_NAME = 'B') AND NOT CUSTOMER_NAME IN (SELECT DISTINCT CUSTOMER_NAME FROM CUSTOMERS AS C CROSS JOIN ORDERS AS O WHERE C.CUSTOMER_ID = O.CUSTOMER_ID AND PRODUCT_NAME = 'C');

/*
Prediction Result:
(1, 'Alex')
(3, 'Sam')
(4, 'Sam')
*/