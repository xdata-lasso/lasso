-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO Customers (customer_id, customer_name) VALUES (1, 'Hannah');
INSERT INTO Customers (customer_id, customer_name) VALUES (2, 'Ian');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (1, 1, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (2, 1, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (3, 2, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (4, 2, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (5, 2, 'C');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (6, NULL, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT C.CUSTOMER_ID AS CUSTOMER_ID, C.CUSTOMER_NAME AS CUSTOMER_NAME, (SUM(PRODUCT_NAME = 'A') >= 1) AND (SUM(PRODUCT_NAME = 'B') >= 1) AND (SUM(PRODUCT_NAME = 'C') = 0) AS COND FROM CUSTOMERS AS C LEFT JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID GROUP BY C.CUSTOMER_ID) AS D WHERE COND = TRUE;

/*
Prediction Result:
(1, 'Hannah')
*/