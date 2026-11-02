-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'default1'), (0, NULL), (2, 'default1'), (1, 'A'), (3, 'B'), (4, 'default2'), (5, 'B'), (6, 'default1'), (7, 'default2'), (8, 'default1'), (9, 'default2'), (10, 'default1'), (11, 'C'), (12, NULL), (13, 'B'), (14, 'B'), (15, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 2, 'C'), (2, 3, 'default2'), (0, 11, 'default2'), (-1, 10, 'A'), (3, 0, 'default2'), (4, NULL, NULL), (5, 8, NULL), (6, 7, 'default1'), (7, 9, 'default1'), (8, 5, 'A'), (9, 5, 'A'), (10, 11, NULL), (11, -1, 'C'), (12, 10, NULL), (13, 7, NULL), (14, 6, 'C'), (15, -1, 'A'), (16, 15, 'default1'), (17, 6, 'default1'), (18, 5, 'B'), (19, 0, 'default2'), (20, 11, 'C'), (21, 4, 'C'), (22, 11, 'C'), (23, 1, 'B'), (24, 9, 'A'), (25, 0, NULL), (26, 10, NULL), (27, 1, 'A'), (28, 12, 'C'), (29, NULL, 'default2'), (30, 6, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'A')
(5, 'B')
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID GROUP BY 1 HAVING SUM(O.PRODUCT_NAME = 'A') = 1 AND SUM(O.PRODUCT_NAME = 'B') = 1 AND SUM(O.PRODUCT_NAME = 'C') = 0 ORDER BY 1, C.CUSTOMER_ID NULLS LAST, C.CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
(1, 'A')
*/