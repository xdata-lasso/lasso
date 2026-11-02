-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'default1'), (3, 'default2'), (1, 'default2'), (2, NULL), (0, 'default2'), (4, NULL), (5, 'C'), (6, NULL), (7, NULL), (8, NULL), (9, 'B'), (10, 'A'), (11, NULL), (12, 'default1'), (13, NULL), (14, 'B'), (15, 'B'), (16, NULL), (17, 'default2'), (18, 'B'), (19, NULL), (20, 'B'), (21, 'A'), (22, 'C'), (23, 'A'), (24, NULL), (25, 'default1'), (26, 'default2'), (27, 'A'), (28, 'B'), (29, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (3, 24, 'A'), (0, 16, NULL), (1, 19, NULL), (2, -1, 'default1'), (-1, 16, 'default1'), (4, 14, NULL), (5, 18, 'A'), (6, 2, 'C'), (7, 1, 'C'), (8, 25, 'C'), (9, 24, 'B'), (10, 16, 'default2'), (11, 28, 'B'), (12, 14, 'B'), (13, 14, NULL), (14, 2, 'B'), (15, 24, 'default1'), (16, 9, 'B'), (17, 9, 'default2'), (18, 28, 'B'), (19, 15, 'B'), (20, 12, 'default1'), (21, 2, 'C'), (22, 2, 'A'), (23, 11, NULL), (24, 21, 'default2'), (25, 15, 'default2'), (26, 14, 'C'), (27, 24, 'default2'), (28, NULL, 'B'), (29, 23, 'A'), (30, 19, 'default1'), (31, 29, 'B'), (32, NULL, 'C'), (33, 21, 'default2'), (34, 18, NULL), (35, NULL, 'default2'), (36, 9, 'default2'), (37, 22, 'C'), (38, -1, NULL), (39, 20, 'default1'), (40, 12, 'A'), (41, 24, 'A'), (42, 25, 'B'), (43, 23, 'B'), (44, 2, 'default2'), (45, 6, 'default2'), (46, 19, 'A'), (47, NULL, 'C'), (48, 9, 'C'), (49, 6, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(23, 'A')
(24, None)
*/

-- Prediction Query
SELECT T.CUSTOMER_ID, C.CUSTOMER_NAME FROM (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A' OR PRODUCT_NAME = 'B' GROUP BY CUSTOMER_ID HAVING COUNT(DISTINCT PRODUCT_NAME) = 2) AS T JOIN CUSTOMERS AS C ON T.CUSTOMER_ID = C.CUSTOMER_ID WHERE NOT T.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY T.CUSTOMER_ID, C.customer_id NULLS LAST;

/*
Prediction Result:
*/