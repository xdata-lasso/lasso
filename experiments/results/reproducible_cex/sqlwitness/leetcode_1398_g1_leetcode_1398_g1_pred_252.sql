-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'A'), (1, 'default2'), (0, NULL), (2, 'B'), (3, 'default1'), (4, 'B'), (5, NULL), (6, NULL), (7, 'C'), (8, 'default1'), (9, 'C'), (10, 'B'), (11, 'default2'), (12, 'C'), (13, 'C'), (14, 'default2'), (15, 'B'), (16, 'default1'), (17, 'C'), (18, 'C'), (19, 'B'), (20, NULL), (21, NULL), (22, 'default1'), (23, NULL), (24, 'default1'), (25, 'C'), (26, 'default2'), (27, 'default1'), (28, 'default1'), (29, 'B'), (30, 'C'), (31, 'default1'), (32, NULL), (33, NULL), (34, 'C'), (35, 'A'), (36, 'C'), (37, 'default1'), (38, NULL), (39, 'default2'), (40, 'default1'), (41, NULL), (42, 'default1'), (43, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 42, 'B'), (1, 5, 'B'), (0, 38, NULL), (-1, 35, 'B'), (3, 21, 'B'), (4, 35, 'C'), (5, 24, 'default2'), (6, 2, 'default1'), (7, 36, 'default1'), (8, 9, 'A'), (9, 25, 'B'), (10, 36, 'default1'), (11, 25, NULL), (12, 6, 'default1'), (13, 43, 'B'), (14, 0, NULL), (15, 43, 'A'), (16, 3, 'A'), (17, 10, 'default1'), (18, 15, 'default2'), (19, 22, 'A'), (20, 42, 'default1'), (21, 11, 'default2'), (22, NULL, 'C'), (23, 2, 'B'), (24, 27, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(43, 'C')
*/

-- Prediction Query
WITH AB AS (SELECT A.CUSTOMER_ID FROM ORDERS AS A INNER JOIN ORDERS AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID WHERE A.PRODUCT_NAME = 'A' AND B.PRODUCT_NAME = 'B'), C AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME IN ('C')) SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM AB WHERE NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM C));

/*
Prediction Result:
*/