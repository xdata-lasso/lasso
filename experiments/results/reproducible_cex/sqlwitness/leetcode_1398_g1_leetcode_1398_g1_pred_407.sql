-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (100, 'default2'), (3, 'default1'), (1, 'default1'), (0, NULL), (101, 'A'), (-1, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 3, 'default2'), (1, 101, NULL), (101, 1, NULL), (3, 3, 'B'), (0, NULL, 'A'), (100, 101, 'A'), (99, NULL, 'default2'), (2, 1, 'B'), (4, 100, 'C'), (5, 3, 'default2'), (6, 1, 'B'), (7, 0, 'C'), (8, NULL, NULL), (9, 3, 'default1'), (10, 0, 'B'), (11, 3, NULL), (12, -1, 'B'), (13, 100, 'C'), (14, 3, 'B'), (15, -1, 'C'), (16, NULL, 'default2'), (17, 1, 'A'), (18, 101, 'default2'), (19, NULL, 'default1'), (20, NULL, 'B'), (21, 3, 'default2'), (22, 101, 'A'), (23, NULL, 'A'), (24, -1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'default1')
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME = 'A' OR PRODUCT_NAME = 'B' THEN 1 WHEN PRODUCT_NAME = 'C' THEN -100 ELSE 0 END) AS SCORE FROM ORDERS GROUP BY 1) AS A LEFT JOIN CUSTOMERS AS C ON A.CUSTOMER_ID = C.CUSTOMER_ID WHERE SCORE >= 2;

/*
Prediction Result:
(None, None)
(1, 'default1')
(3, 'default1')
(101, 'A')
*/