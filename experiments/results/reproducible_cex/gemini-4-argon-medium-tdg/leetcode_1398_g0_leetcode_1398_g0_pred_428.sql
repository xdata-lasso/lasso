-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO Customers (customer_id, customer_name) VALUES (100, 'Customer100');
INSERT INTO Customers (customer_id, customer_name) VALUES (5, 'Customer5');
INSERT INTO Customers (customer_id, customer_name) VALUES (50, 'Customer50');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (1, 100, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (2, 100, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (3, 5, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (4, 5, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (5, 50, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (6, 50, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(5, 'Customer5')
(50, 'Customer50')
(100, 'Customer100')
*/

-- Prediction Query
WITH BOUGHT_A AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A'), BOUGHT_B AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B'), DID_NOT_BUY_C AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C')), CUSTOMER_FILTERED AS (SELECT A.CUSTOMER_ID FROM (BOUGHT_A AS A INNER JOIN BOUGHT_B AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID) INNER JOIN DID_NOT_BUY_C AS C ON B.CUSTOMER_ID = C.CUSTOMER_ID) SELECT CF.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMER_FILTERED AS CF INNER JOIN CUSTOMERS AS C ON CF.CUSTOMER_ID = C.CUSTOMER_ID;

/*
Prediction Result:
(100, 'Customer100')
(5, 'Customer5')
(50, 'Customer50')
*/