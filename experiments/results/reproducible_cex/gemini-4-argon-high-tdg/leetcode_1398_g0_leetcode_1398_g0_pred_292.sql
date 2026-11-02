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
WITH CTE_IS_BOUGHT AS (SELECT S.CUSTOMER_ID, S.CUSTOMER_NAME, MAX(CASE WHEN O.PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) AS IS_BOUGHT_A, MAX(CASE WHEN O.PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) AS IS_BOUGHT_B, MAX(CASE WHEN O.PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) AS IS_BOUGHT_C FROM CUSTOMERS AS S INNER JOIN ORDERS AS O ON O.CUSTOMER_ID = S.CUSTOMER_ID GROUP BY S.CUSTOMER_ID, S.CUSTOMER_NAME) SELECT DISTINCT CUSTOMER_ID, CUSTOMER_NAME FROM CTE_IS_BOUGHT WHERE IS_BOUGHT_A = 1 AND IS_BOUGHT_B = 1 AND IS_BOUGHT_C = 0 ORDER BY CUSTOMER_ID, CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
(1, 'Hannah')
*/