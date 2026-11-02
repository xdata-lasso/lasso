-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'default1'), (1, 'A'), (2, 'default1'), (0, 'default2'), (9, 'A'), (109, 'C'), (99, 'C'), (111, 'A'), (100, NULL), (101, 'B'), (10, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 10, 'B'), (109, -1, 'default2'), (11, 0, 'A'), (0, 109, NULL), (-1, 109, 'default2'), (101, NULL, NULL), (100, 101, 'C'), (99, 9, 'B'), (110, 1, NULL), (2, 10, 'default2'), (10, -1, 'A'), (9, 111, 'B'), (111, -1, 'A'), (3, 1, 'default2'), (4, 109, NULL), (5, -1, 'default2'), (6, 100, 'B'), (7, 100, 'A'), (8, NULL, 'B'), (12, 111, 'C'), (13, 99, NULL), (14, 9, NULL), (15, 100, 'A'), (16, 10, 'B'), (17, 109, 'default2'), (18, 109, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(100, None)
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT O.CUSTOMER_ID, C.CUSTOMER_NAME, SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 100 WHEN PRODUCT_NAME = 'B' THEN 10 WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) AS PRODUCT_INDEX FROM ORDERS AS O JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID GROUP BY O.CUSTOMER_ID, C.CUSTOMER_NAME) AS TMP WHERE PRODUCT_INDEX = 110;

/*
Prediction Result:
*/