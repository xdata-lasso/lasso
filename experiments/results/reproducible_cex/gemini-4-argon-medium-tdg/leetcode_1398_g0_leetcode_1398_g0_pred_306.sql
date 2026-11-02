-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Customers (customer_id, customer_name) VALUES (1, 'ValidCustomer');
INSERT INTO Customers (customer_id, customer_name) VALUES (2, 'CaseCheckCustomer');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (1, 1, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (2, 1, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (3, 1, NULL);
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (4, NULL, 'C');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (5, NULL, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (6, NULL, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (7, 2, 'a');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (8, 2, 'b');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH PRE_PIVOT AS (SELECT CUSTOMER_ID, IIF(PRODUCT_NAME = 'A', 1, 0) AS PROD_A, IIF(PRODUCT_NAME = 'B', 1, 0) AS PROD_B, IIF(PRODUCT_NAME = 'C', 1, 0) AS PROD_C FROM ORDERS), PIVOT AS (SELECT CUSTOMER_ID, MAX(PROD_A) AS PROD_A, MAX(PROD_B) AS PROD_B, MAX(PROD_C) AS PROD_C FROM PRE_PIVOT GROUP BY CUSTOMER_ID) SELECT P.CUSTOMER_ID, C.CUSTOMER_NAME FROM PIVOT AS P INNER JOIN CUSTOMERS AS C ON P.CUSTOMER_ID = C.CUSTOMER_ID WHERE P.PROD_A = 1 AND P.PROD_B = 1 AND P.PROD_C = 0 ORDER BY P.CUSTOMER_ID, C.customer_id NULLS LAST;

/*
Prediction Result:
(1, 'ValidCustomer')
*/