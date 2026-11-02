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
WITH AB_C AS (SELECT DISTINCT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS WHERE PRODUCT_NAME IN ('A', 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C')) SELECT DISTINCT AB1.CUSTOMER_ID, C.CUSTOMER_NAME FROM AB_C AS AB1 CROSS JOIN AB_C AS AB2 CROSS JOIN CUSTOMERS AS C WHERE AB1.CUSTOMER_ID = AB2.CUSTOMER_ID AND AB1.CUSTOMER_ID = C.CUSTOMER_ID AND AB1.PRODUCT_NAME = 'A' AND AB2.PRODUCT_NAME = 'B';

/*
Prediction Result:
(100, 'Customer100')
(5, 'Customer5')
(50, 'Customer50')
*/