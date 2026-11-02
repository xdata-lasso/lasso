-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Customers (customer_id, customer_name) VALUES (1, 'Alice');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (1, 1, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (2, 1, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (3, NULL, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH ELIGIBLE_USERS AS (SELECT CUSTOMER_ID, MAX(IIF(PRODUCT_NAME = 'A', 1, 0)) AS IS_A, MAX(IIF(PRODUCT_NAME = 'B', 1, 0)) AS IS_B, MAX(IIF(PRODUCT_NAME = 'C', 1, 0)) AS IS_C FROM ORDERS GROUP BY 1) SELECT E.CUSTOMER_ID, C.CUSTOMER_NAME FROM ELIGIBLE_USERS AS E JOIN CUSTOMERS AS C ON E.CUSTOMER_ID = C.CUSTOMER_ID WHERE E.IS_A = 1 AND E.IS_B = 1 AND E.IS_C = 0;

/*
Prediction Result:
(1, 'Alice')
*/