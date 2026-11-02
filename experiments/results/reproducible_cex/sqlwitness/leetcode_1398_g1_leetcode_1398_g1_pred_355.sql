-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'B'), (0, NULL), (2, 'B'), (1, 'default1'), (3, 'default1'), (4, 'default2'), (5, NULL), (6, 'B'), (7, 'C'), (8, 'B'), (9, 'default2'), (10, NULL), (11, 'C'), (12, 'default2'), (13, 'C'), (14, 'default1'), (15, 'A'), (16, 'A'), (17, 'A'), (18, NULL), (19, 'default2'), (20, NULL), (21, NULL), (22, 'default1'), (23, 'B'), (24, NULL), (25, 'default2'), (26, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 16, 'B'), (1, 13, NULL), (2, NULL, 'C'), (-1, 18, 'default1'), (3, 3, 'default1'), (4, 23, NULL), (5, 8, 'default1'), (6, 4, 'C'), (7, 9, 'A'), (8, 23, 'default1'), (9, 24, NULL), (10, 6, 'B'), (11, 8, 'default2'), (12, 23, 'default2'), (13, 15, 'default2'), (14, 7, 'B'), (15, 23, 'A'), (16, 17, 'A'), (17, 25, 'B'), (18, 23, 'B'), (19, 3, 'B'), (20, 25, NULL), (21, 2, NULL), (22, -1, 'default1'), (23, 5, NULL), (24, 21, 'default2'), (25, 7, 'default2'), (26, 21, 'default1'), (27, NULL, 'A'), (28, 19, 'default2'), (29, 25, 'B'), (30, 25, 'A'), (31, 16, 'C'), (32, 26, 'C'), (33, 25, 'default1'), (34, 17, 'C'), (35, 21, 'C'), (36, 8, NULL), (37, 3, NULL), (38, 2, NULL), (39, 2, 'C'), (40, 15, 'default1'), (41, 15, 'default2'), (42, NULL, 'default1'), (43, 21, 'default2'), (44, 14, 'A'), (45, 20, 'default1'), (46, 15, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(23, 'B')
(25, 'default2')
*/

-- Prediction Query
SELECT DISTINCT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE NOT C.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') AND C.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND C.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B');

/*
Prediction Result:
*/