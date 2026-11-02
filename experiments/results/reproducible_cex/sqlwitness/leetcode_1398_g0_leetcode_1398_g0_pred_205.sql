-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'default2'), (0, 'B'), (1, 'D'), (-1, 'A'), (3, NULL), (4, 'D'), (5, 'B'), (6, 'C'), (7, 'D'), (8, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 1, 'D'), (-1, 5, 'A'), (2, 8, NULL), (1, NULL, 'C'), (3, NULL, NULL), (4, 5, 'B'), (5, NULL, 'A'), (6, 5, 'default1'), (7, 3, 'default1'), (8, 1, 'D');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT C.CUSTOMER_NAME, O.CUSTOMER_ID, O.PRODUCT_NAME, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C, SUM(IIF(PRODUCT_NAME = 'D', 1, 0)) AS D FROM ORDERS AS O JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID GROUP BY O.CUSTOMER_ID) SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CTE WHERE A = 1 AND B = 1 AND C = 0;

/*
Prediction Result:
(5, 'B')
*/