-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Customers (customer_id, customer_name) VALUES (10, 'Zebra');
INSERT INTO Customers (customer_id, customer_name) VALUES (20, 'Alpha');
INSERT INTO Customers (customer_id, customer_name) VALUES (30, 'Beta');
INSERT INTO Customers (customer_id, customer_name) VALUES (40, 'Gamma');
INSERT INTO Customers (customer_id, customer_name) VALUES (50, 'Delta');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (1, 10, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (2, 10, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (3, 10, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (4, 10, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (5, 10, 'D');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (6, 20, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (7, 20, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (8, 30, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (9, 30, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (10, 40, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (11, 40, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (12, 50, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (13, 50, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (14, 50, 'C');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (15, 50, 'D');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(10, 'Zebra')
(20, 'Alpha')
*/

-- Prediction Query
SELECT SUB1.CUSTOMER_ID, C.CUSTOMER_NAME FROM (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AS SUB1 JOIN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AS SUB2 ON SUB1.CUSTOMER_ID = SUB2.CUSTOMER_ID LEFT JOIN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') AS SUB3 ON SUB1.CUSTOMER_ID = SUB3.CUSTOMER_ID JOIN CUSTOMERS AS C ON SUB1.CUSTOMER_ID = C.CUSTOMER_ID WHERE SUB3.CUSTOMER_ID IS NULL;

/*
Prediction Result:
(10, 'Zebra')
(10, 'Zebra')
(10, 'Zebra')
(10, 'Zebra')
(20, 'Alpha')
*/