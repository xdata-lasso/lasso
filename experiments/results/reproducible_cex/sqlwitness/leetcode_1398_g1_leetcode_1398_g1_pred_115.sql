-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (3, 'A'), (-1, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, -1, 'default2'), (-1, 3, 'A'), (1, 3, 'C'), (3, -1, 'A'), (0, 3, 'default2'), (4, 3, 'B'), (5, NULL, 'B'), (6, -1, 'C'), (7, NULL, 'default2'), (8, 3, 'default1'), (9, NULL, 'A'), (10, 3, NULL), (11, NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT B.CUSTOMER_ID, C.CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(FLAG) AS FLAGS FROM (SELECT CUSTOMER_ID, CASE WHEN PRODUCT_NAME = 'C' THEN -1 WHEN PRODUCT_NAME = 'A' THEN 1 WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END AS FLAG FROM (SELECT DISTINCT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS WHERE PRODUCT_NAME = 'A' OR PRODUCT_NAME = 'B' OR PRODUCT_NAME = 'C') AS D) AS A GROUP BY CUSTOMER_ID) AS B LEFT JOIN CUSTOMERS AS C ON B.CUSTOMER_ID = C.CUSTOMER_ID WHERE FLAGS = 2;

/*
Prediction Result:
(None, None)
*/