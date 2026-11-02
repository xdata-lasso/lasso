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
SELECT DISTINCT O.CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS AS O JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE PRODUCT_NAME = 'A' AND EXISTS(SELECT CUSTOMER_ID FROM ORDERS WHERE CUSTOMER_ID = O.CUSTOMER_ID AND PRODUCT_NAME = 'B') AND NOT EXISTS(SELECT CUSTOMER_ID FROM ORDERS WHERE CUSTOMER_ID = O.CUSTOMER_ID AND PRODUCT_NAME = 'C');

/*
Prediction Result:
(1, 'ValidCustomer')
*/