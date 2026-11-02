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
SELECT TMP.CUSTOMER_ID, C.CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, CASE WHEN SUM(BOUGHT_A) >= 1 AND SUM(BOUGHT_B) >= 1 AND SUM(BOUGHT_C) = 0 THEN 1 ELSE 0 END AS BOUGHT_AB_NOT_C FROM (SELECT CUSTOMER_ID, CASE WHEN PRODUCT_NAME IN ('A') THEN 1 ELSE 0 END AS BOUGHT_A, CASE WHEN PRODUCT_NAME IN ('B') THEN 1 ELSE 0 END AS BOUGHT_B, CASE WHEN PRODUCT_NAME IN ('C') THEN 1 ELSE 0 END AS BOUGHT_C FROM ORDERS) AS A GROUP BY 1) AS TMP LEFT JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = TMP.CUSTOMER_ID WHERE BOUGHT_AB_NOT_C = 1;

/*
Prediction Result:
(1, 'ValidCustomer')
*/