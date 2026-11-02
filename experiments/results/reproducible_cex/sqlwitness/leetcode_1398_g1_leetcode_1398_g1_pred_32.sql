-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'default2'), (2, 'B'), (0, 'A'), (-1, 'C'), (3, NULL), (4, 'C'), (5, 'B'), (6, NULL), (7, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 6, 'C'), (0, 7, 'default1'), (2, 4, 'default1'), (-1, 3, 'default1'), (3, 5, 'B'), (4, 0, 'A'), (5, 1, 'A'), (6, NULL, 'A'), (7, 2, 'C'), (8, NULL, 'default2'), (9, 0, 'B'), (10, 1, NULL), (11, 2, 'default2'), (12, 3, NULL), (13, 2, 'A'), (14, 1, 'default2'), (15, 1, NULL), (16, 5, 'default1'), (17, NULL, 'B'), (18, 0, 'default2'), (19, 0, NULL), (20, 3, 'A'), (21, 1, NULL), (22, 6, 'A'), (23, 2, 'default2'), (24, 7, 'default2'), (25, 5, NULL), (26, 3, 'default2'), (27, 5, 'default1'), (28, 7, 'C'), (29, 1, 'default2'), (30, -1, 'default2'), (31, 7, NULL), (32, 1, 'default2'), (33, -1, 'C'), (34, 0, 'C'), (35, 5, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(5, 'B')
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM ORDERS AS O LEFT JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID GROUP BY O.CUSTOMER_ID HAVING SUM(O.PRODUCT_NAME = 'A') > 0 AND SUM(O.PRODUCT_NAME = 'B') > 0 AND SUM(O.PRODUCT_NAME = 'C') = 0 ORDER BY O.CUSTOMER_ID, C.CUSTOMER_ID NULLS LAST, C.CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
(None, None)
(5, 'B')
*/