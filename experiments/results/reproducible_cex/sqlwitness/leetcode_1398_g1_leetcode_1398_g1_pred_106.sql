-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'default2'), (1, 'C'), (0, 'default2'), (-1, 'A'), (3, 'A'), (4, NULL), (5, 'A'), (6, NULL), (7, 'B'), (8, NULL), (9, 'B'), (10, 'B'), (11, 'C'), (12, 'B'), (13, NULL), (14, NULL), (15, 'A'), (16, 'B'), (17, 'default1'), (18, 'default1'), (19, NULL), (20, 'B'), (21, 'C'), (22, 'A'), (23, 'default1'), (24, 'A'), (25, 'B'), (26, 'A'), (27, 'B'), (28, 'A'), (29, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 21, 'B'), (0, 4, 'B'), (2, 15, 'C'), (1, 25, 'C'), (3, 25, 'B'), (4, 3, 'B'), (5, 20, 'A'), (6, 2, 'default1'), (7, 18, 'default1'), (8, 19, 'A'), (9, NULL, 'B'), (10, -1, 'C'), (11, 13, 'A'), (12, 23, 'C'), (13, 14, 'B'), (14, 19, 'C'), (15, 27, NULL), (16, 12, 'B'), (17, NULL, 'A'), (18, 11, 'C'), (19, 20, 'C'), (20, 3, NULL), (21, 28, 'A'), (22, 27, 'A'), (23, NULL, NULL), (24, 0, 'default2'), (25, 28, 'A'), (26, 5, 'A'), (27, 3, 'B'), (28, 6, 'default2'), (29, 2, 'A'), (30, 20, 'A'), (31, NULL, 'A'), (32, 1, 'B'), (33, 10, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT A.CUSTOMER_ID, B.CUSTOMER_NAME FROM ORDERS AS A LEFT JOIN CUSTOMERS AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID GROUP BY A.CUSTOMER_ID HAVING SUM(IIF(A.PRODUCT_NAME = 'A', 1, 0)) > 0 AND SUM(IIF(A.PRODUCT_NAME = 'B', 1, 0)) > 0 AND SUM(IIF(A.PRODUCT_NAME = 'C', 1, 0)) = 0;

/*
Prediction Result:
(None, None)
*/