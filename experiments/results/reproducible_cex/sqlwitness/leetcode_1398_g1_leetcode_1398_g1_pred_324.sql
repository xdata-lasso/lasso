-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'default2'), (0, NULL), (2, 'default1'), (-1, 'default2'), (3, NULL), (4, 'C'), (5, 'default2'), (6, 'default2'), (7, 'B'), (8, 'default1'), (9, NULL), (10, 'A'), (11, NULL), (12, 'C'), (13, 'A'), (14, NULL), (15, 'default2'), (16, NULL), (17, 'default1'), (18, 'B'), (19, 'default1'), (20, 'default2'), (21, 'C'), (22, 'default1'), (23, 'B'), (24, 'B'), (25, NULL), (26, 'A'), (27, 'default1'), (28, 'default2'), (29, 'B'), (30, NULL), (31, 'B'), (32, 'B'), (33, 'B'), (34, 'C'), (35, NULL), (36, 'default1'), (37, 'default1'), (38, 'default1'), (39, NULL), (40, 'B'), (41, 'default1'), (42, NULL), (43, 'default2'), (44, 'default2'), (45, 'C'), (46, 'C'), (47, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 31, NULL), (-1, NULL, 'C'), (2, 35, 'A'), (1, -1, 'B'), (3, 38, 'default2'), (4, 46, 'default1'), (5, 28, 'default1'), (6, 30, NULL), (7, 36, 'B'), (8, 32, 'B'), (9, 25, 'default1'), (10, 21, 'A'), (11, 23, 'default2'), (12, 19, 'default2'), (13, 26, 'B'), (14, 38, 'default1'), (15, 18, 'default2'), (16, 14, 'A'), (17, 20, 'default2'), (18, 1, 'A'), (19, 26, 'default1'), (20, NULL, 'C'), (21, 21, 'default1'), (22, 42, 'B'), (23, 18, NULL), (24, 42, 'default1'), (25, 34, NULL), (26, 34, 'B'), (27, 29, 'B'), (28, 5, 'A'), (29, 46, 'B'), (30, 10, 'C'), (31, 20, 'A'), (32, 0, 'default1'), (33, 4, 'C'), (34, 32, 'A'), (35, 36, 'A'), (36, 39, 'B'), (37, 26, 'C'), (38, 14, 'default2'), (39, 35, 'default1'), (40, 1, 'C'), (41, 1, 'C'), (42, 25, 'A'), (43, 36, 'default2'), (44, 21, 'A'), (45, 25, 'B'), (46, 33, 'default2'), (47, 39, 'B'), (48, 27, 'C'), (49, 8, 'default2'), (50, 7, 'C'), (51, 35, 'B'), (52, 11, 'default1'), (53, 13, 'default1'), (54, 37, 'default1'), (55, 3, 'default1'), (56, 37, 'default1'), (57, 41, NULL), (58, 3, 'C'), (59, 3, 'default2'), (60, 19, 'A'), (61, 5, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(25, None)
(32, 'B')
(35, None)
(36, 'default1')
*/

-- Prediction Query
WITH T1 AS (SELECT DISTINCT CUSTOMER_ID AS TESTA FROM ORDERS WHERE PRODUCT_NAME = 'A'), T2 AS (SELECT DISTINCT CUSTOMER_ID AS TESTB FROM ORDERS WHERE PRODUCT_NAME = 'B'), T3 AS (SELECT DISTINCT CUSTOMER_ID AS TESTC FROM ORDERS WHERE PRODUCT_NAME = 'C') SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT * FROM T1) AND CUSTOMER_ID IN (SELECT * FROM T2) AND NOT CUSTOMER_ID IN (SELECT * FROM T3);

/*
Prediction Result:
*/