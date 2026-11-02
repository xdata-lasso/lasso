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
WITH TB AS (SELECT CUSTOMER_ID, IIF(PRODUCT_NAME = 'A', 1, 0) AS A, IIF(PRODUCT_NAME = 'B', 1, 0) AS B, IIF(PRODUCT_NAME = 'C', 1, 0) AS C FROM ORDERS), TB1 AS (SELECT CUSTOMER_ID FROM TB GROUP BY CUSTOMER_ID HAVING SUM(A) > 0 AND SUM(B) > 0 AND SUM(C) = 0) SELECT CUSTOMERS.* FROM CUSTOMERS JOIN TB1 USING (CUSTOMER_ID);

/*
Prediction Result:
(1, 'Hannah')
*/