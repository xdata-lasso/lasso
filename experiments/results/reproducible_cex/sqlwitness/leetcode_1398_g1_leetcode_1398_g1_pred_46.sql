-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'A'), (0, 'default1'), (-1, 'default1'), (2, 'default2'), (3, 'A'), (4, NULL), (5, 'C'), (6, 'A'), (7, 'default2'), (8, 'B'), (9, NULL), (10, NULL), (11, 'C'), (12, 'default1'), (13, NULL), (14, NULL), (15, 'C'), (16, 'C'), (17, NULL), (18, NULL), (19, 'default2'), (20, 'B'), (21, NULL), (22, NULL), (23, 'C'), (24, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 4, 'default1'), (1, 24, NULL), (0, 4, 'C'), (-1, 24, 'C'), (3, 4, NULL), (4, 8, 'default1'), (5, -1, 'default2'), (6, 20, 'default1'), (7, 2, 'A'), (8, 1, 'C'), (9, 11, 'default2'), (10, 10, 'B'), (11, 7, 'default2'), (12, 18, 'C'), (13, 9, 'default1'), (14, 13, NULL), (15, 7, 'B'), (16, 5, 'B'), (17, 19, NULL), (18, 4, NULL), (19, 16, 'A'), (20, 23, 'B'), (21, 20, 'A'), (22, 9, 'B'), (23, 24, 'default1'), (24, 18, NULL), (25, 24, 'default2'), (26, 6, 'B'), (27, 3, 'B'), (28, 7, NULL), (29, 9, 'A'), (30, 24, NULL), (31, 6, 'B'), (32, 15, 'C'), (33, NULL, 'C'), (34, 11, 'B'), (35, 1, 'default1'), (36, 16, 'A'), (37, 23, 'default1'), (38, 19, 'B'), (39, 14, 'A'), (40, 23, 'B'), (41, 16, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(9, None)
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS AS C WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Prediction Result:
*/