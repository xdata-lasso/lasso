-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Customers (customer_id, customer_name) VALUES (0, 'Bob');
INSERT INTO Customers (customer_id, customer_name) VALUES (1, 'Alice');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (1, 0, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (2, 0, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (3, 1, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (4, 1, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (5, 1, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(0, 'Bob')
(1, 'Alice')
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C LEFT JOIN (SELECT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS WHERE PRODUCT_NAME = 'A') AS T1 ON C.CUSTOMER_ID = T1.CUSTOMER_ID LEFT JOIN (SELECT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS WHERE PRODUCT_NAME = 'B') AS T2 ON C.CUSTOMER_ID = T2.CUSTOMER_ID LEFT JOIN (SELECT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS WHERE PRODUCT_NAME = 'C') AS T3 ON C.CUSTOMER_ID = T3.CUSTOMER_ID WHERE T1.CUSTOMER_ID AND T2.CUSTOMER_ID AND (T3.CUSTOMER_ID IS NULL);

/*
Prediction Result:
(1, 'Alice')
(1, 'Alice')
*/