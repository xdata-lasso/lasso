-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, NULL), (1, NULL), (0, 'default1'), (2, 'A'), (3, 'default1'), (4, 'C'), (5, 'default1'), (6, 'C'), (7, NULL), (8, 'default2'), (9, 'A'), (10, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 3, 'B'), (2, 6, 'default1'), (1, 2, 'C'), (0, NULL, 'default1'), (3, 10, 'default2'), (4, 5, 'default1'), (5, 2, 'default1'), (6, 4, 'A'), (7, NULL, 'A'), (8, 2, 'default2'), (9, NULL, NULL), (10, 6, 'default2'), (11, 7, 'A'), (12, 2, 'B'), (13, 8, 'default1'), (14, 2, 'C'), (15, -1, 'default1'), (16, NULL, 'C'), (17, 9, 'C'), (18, 2, 'default1'), (19, 1, 'A'), (20, 0, 'default2'), (21, 1, 'default2'), (22, -1, 'default1'), (23, -1, 'A'), (24, 4, 'default2'), (25, 7, 'default2'), (26, 2, 'C'), (27, -1, 'default1'), (28, NULL, 'A'), (29, 9, 'B'), (30, 5, 'C'), (31, 8, 'C'), (32, -1, 'B'), (33, 0, 'default2'), (34, NULL, 'default2'), (35, 6, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(-1, None)
*/

-- Prediction Query
SELECT DISTINCT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O1 ON C.CUSTOMER_ID = O1.CUSTOMER_ID AND O1.PRODUCT_NAME = 'A' JOIN ORDERS AS O2 ON C.CUSTOMER_ID = O2.CUSTOMER_ID AND O2.PRODUCT_NAME = 'B' WHERE NOT C.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
*/