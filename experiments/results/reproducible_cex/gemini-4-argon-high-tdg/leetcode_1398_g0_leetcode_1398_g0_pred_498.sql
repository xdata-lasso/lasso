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
WITH A AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A'), B AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B'), C AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C'), RES AS (SELECT A.CUSTOMER_ID FROM A INNER JOIN B ON A.CUSTOMER_ID = B.CUSTOMER_ID), ORD AS (SELECT RES.CUSTOMER_ID FROM RES LEFT JOIN C ON RES.CUSTOMER_ID = C.CUSTOMER_ID WHERE C.CUSTOMER_ID IS NULL) SELECT * FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORD);

/*
Prediction Result:
(1, 'Hannah')
*/