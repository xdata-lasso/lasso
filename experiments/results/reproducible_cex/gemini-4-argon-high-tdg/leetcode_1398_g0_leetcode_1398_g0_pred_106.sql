-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO Customers (customer_id, customer_name) VALUES (1, NULL);
INSERT INTO Customers (customer_id, customer_name) VALUES (2, 'Frank');
INSERT INTO Customers (customer_id, customer_name) VALUES (3, 'Grace');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (1, 1, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (2, 1, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (3, 2, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (4, 2, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (5, 2, NULL);
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (6, 3, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (7, 3, NULL);
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (8, NULL, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (9, NULL, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, None)
(2, 'Frank')
*/

-- Prediction Query
SELECT A.CUSTOMER_ID, B.CUSTOMER_NAME FROM ORDERS AS A LEFT JOIN CUSTOMERS AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID GROUP BY A.CUSTOMER_ID HAVING SUM(IIF(A.PRODUCT_NAME = 'A', 1, 0)) > 0 AND SUM(IIF(A.PRODUCT_NAME = 'B', 1, 0)) > 0 AND SUM(IIF(A.PRODUCT_NAME = 'C', 1, 0)) = 0;

/*
Prediction Result:
(None, None)
(1, None)
(2, 'Frank')
*/