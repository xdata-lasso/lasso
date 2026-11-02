-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'A'), (3, 'A'), (2, 'C'), (0, 'default2'), (-1, 'default2'), (4, 'A'), (5, 'default1'), (6, 'default1'), (7, 'A'), (8, 'A'), (9, 'A'), (10, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 0, 'C'), (2, 0, NULL), (1, 6, 'C'), (-1, 0, 'B'), (3, 8, 'A'), (4, 9, 'B'), (5, 5, 'A'), (6, 9, 'C'), (7, 9, NULL), (8, 10, 'C'), (9, 3, NULL), (10, 1, 'default2'), (11, 3, 'B'), (12, 7, 'A'), (13, 2, 'B'), (14, 6, 'default1'), (15, 8, 'A'), (16, 8, 'B'), (17, 1, 'B'), (18, NULL, 'B'), (19, 10, 'A'), (20, -1, NULL), (21, 5, 'C'), (22, 2, 'C'), (23, 9, NULL), (24, 1, 'A'), (25, 6, 'default2'), (26, 4, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'A')
(8, 'A')
*/

-- Prediction Query
WITH ORDER_CNT AS (SELECT CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME IN ('A', 'B') THEN 1 WHEN PRODUCT_NAME = 'C' THEN -1 ELSE 0 END) AS CNT FROM ORDERS GROUP BY CUSTOMER_ID) SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM ORDER_CNT JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = ORDER_CNT.CUSTOMER_ID WHERE ORDER_CNT.CNT = 2;

/*
Prediction Result:
(1, 'A')
*/