-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'C'), (0, NULL), (-1, 'default1'), (1, 'B'), (3, 'default2'), (4, 'default2'), (5, NULL), (6, 'default2'), (7, 'A'), (8, NULL), (9, 'default1'), (10, 'A'), (11, 'C'), (12, 'A'), (13, 'A'), (14, 'C'), (15, NULL), (16, 'C'), (17, 'B'), (18, 'default1'), (19, 'default2'), (20, 'A'), (21, 'C'), (22, 'default1'), (23, 'default1'), (24, NULL), (25, 'A'), (26, 'C'), (27, 'A'), (28, 'A'), (29, 'default1'), (30, 'C'), (31, NULL), (32, 'A'), (33, 'default1'), (34, 'A'), (35, 'default2'), (36, 'default2'), (37, 'A'), (38, 'B'), (39, 'C'), (40, 'A'), (41, 'default2'), (42, NULL), (43, 'default1'), (44, NULL), (45, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 40, 'default2'), (2, NULL, 'C'), (1, NULL, 'default1'), (0, 11, 'B'), (3, 8, 'default1'), (4, 39, 'B'), (5, 24, 'B'), (6, 23, 'A'), (7, 45, 'default2'), (8, 10, NULL), (9, 33, 'C'), (10, 23, NULL), (11, 20, 'A'), (12, 8, 'B'), (13, 26, NULL), (14, 34, 'default1'), (15, 44, 'default2'), (16, 14, 'default1'), (17, 30, NULL), (18, 42, 'C'), (19, 29, 'B'), (20, 10, 'A'), (21, 20, 'B'), (22, 33, NULL), (23, 26, 'B'), (24, 34, 'A'), (25, 28, 'default1'), (26, 15, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(20, 'A')
*/

-- Prediction Query
SELECT DISTINCT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B');

/*
Prediction Result:
*/