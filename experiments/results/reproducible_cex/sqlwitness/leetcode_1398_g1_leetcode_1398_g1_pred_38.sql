-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'C'), (-1, 'B'), (0, 'C'), (3, 'C'), (1, 'default1'), (4, 'default2'), (5, 'C'), (6, 'C'), (7, 'A'), (8, 'default2'), (9, 'default2'), (10, NULL), (11, 'B'), (12, 'B'), (13, 'B'), (14, 'C'), (15, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 9, 'default1'), (0, 13, 'default1'), (3, NULL, 'A'), (-1, 14, 'A'), (2, 15, 'A'), (4, -1, 'B'), (5, 8, 'default2'), (6, NULL, 'A'), (7, 13, 'C'), (8, 14, 'C'), (9, 10, 'default2'), (10, 9, 'A'), (11, 8, 'C'), (12, 0, 'A'), (13, 10, NULL), (14, 3, 'A'), (15, 13, 'default1'), (16, NULL, 'B'), (17, 10, NULL), (18, -1, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME, SUM(CASE WHEN PRODUCT_NAME IN ('A', 'B') THEN 1 WHEN PRODUCT_NAME IN ('C') THEN -1 END) AS SCORE FROM CUSTOMERS AS C LEFT JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID GROUP BY 1, 2) AS A WHERE SCORE = 2;

/*
Prediction Result:
(-1, 'B')
*/