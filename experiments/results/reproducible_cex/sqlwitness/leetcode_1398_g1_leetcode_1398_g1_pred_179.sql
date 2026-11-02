-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'default1'), (0, 'A'), (3, 'C'), (-1, 'A'), (2, NULL), (4, NULL), (5, NULL), (6, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, -1, NULL), (2, 3, 'default1'), (3, 0, 'A'), (1, 2, 'B'), (0, 1, 'A'), (4, 3, NULL), (5, 5, NULL), (6, 5, 'C'), (7, 0, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT O.CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS AS O JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID GROUP BY C.CUSTOMER_NAME, O.CUSTOMER_ID HAVING SUM(CASE WHEN O.PRODUCT_NAME IN ('A', 'B') THEN 1 WHEN O.PRODUCT_NAME IN ('C') THEN 0.5 ELSE 0 END) = 2;

/*
Prediction Result:
(0, 'A')
*/