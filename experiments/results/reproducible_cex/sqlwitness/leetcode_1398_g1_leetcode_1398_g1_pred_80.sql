-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, NULL), (0, NULL), (2, 'default2'), (1, 'default1'), (3, 'C'), (4, 'B'), (5, NULL), (6, 'default1'), (7, 'C'), (8, 'default2'), (9, 'C'), (10, 'C'), (11, NULL), (12, 'default2'), (13, 'A'), (14, 'default1'), (15, NULL), (16, NULL), (17, NULL), (18, 'C'), (19, 'A'), (20, 'C'), (21, 'default2'), (22, 'default2'), (23, NULL), (24, 'B'), (25, 'B'), (26, 'C'), (27, 'A'), (28, 'B'), (29, NULL), (30, 'B'), (31, 'default2'), (32, 'default1'), (33, NULL), (34, NULL), (35, NULL), (36, 'default2'), (37, 'default2'), (38, NULL), (39, 'default2'), (40, 'A'), (41, 'A'), (42, NULL), (43, 'C'), (44, 'C'), (45, 'default2'), (46, NULL), (47, 'default1'), (48, 'C'), (49, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 41, 'B'), (2, -1, 'B'), (0, 36, 'C'), (-1, 4, 'C'), (3, 15, 'default1'), (4, 7, 'default1'), (5, 49, 'A'), (6, 27, 'B'), (7, 5, 'C'), (8, 30, 'C'), (9, 23, 'default2'), (10, 23, 'B'), (11, 38, 'C'), (12, 4, 'default2'), (13, 22, 'B'), (14, 12, 'B'), (15, 16, 'B'), (16, 31, 'default1'), (17, 35, 'C'), (18, 25, 'C'), (19, 17, 'C'), (20, 31, 'A'), (21, 45, 'B'), (22, 46, 'default1'), (23, 10, 'A'), (24, 26, 'C'), (25, 39, 'A'), (26, 18, 'default1'), (27, 26, 'default1'), (28, 48, 'B'), (29, 29, NULL), (30, 42, 'C'), (31, 31, 'B'), (32, 17, 'default1'), (33, 37, 'C'), (34, 1, 'default1'), (35, 26, NULL), (36, 46, 'A'), (37, 27, 'default2'), (38, 3, 'A'), (39, 44, 'default1'), (40, 13, 'default1'), (41, 15, 'default1'), (42, -1, 'A'), (43, 20, 'default2'), (44, 38, 'A'), (45, 20, 'C'), (46, 42, 'default2'), (47, 8, 'C'), (48, 41, NULL), (49, 15, 'B'), (50, 30, 'default2'), (51, 22, 'default1'), (52, 42, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(-1, None)
(31, 'default2')
*/

-- Prediction Query
WITH TEMP AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A' AND CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B')) SELECT DISTINCT TEMP.CUSTOMER_ID, C.CUSTOMER_NAME FROM TEMP JOIN CUSTOMERS AS C ON TEMP.CUSTOMER_ID = C.CUSTOMER_ID WHERE NOT TEMP.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(31, 'default2')
(-1, None)
*/