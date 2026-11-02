-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'default1'), (2, 'default2'), (1, 'default2'), (0, 'default1'), (3, NULL), (4, 'default2'), (5, 'A'), (6, 'A'), (7, 'B'), (8, NULL), (9, 'default1'), (10, 'default2'), (11, 'B'), (12, 'C'), (13, 'B'), (14, 'default2'), (15, 'C'), (16, 'C'), (17, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 1, NULL), (-1, 3, 'B'), (1, 5, 'A'), (2, 6, 'default2'), (3, 7, 'C'), (4, 13, 'default1'), (5, 14, 'B'), (6, NULL, 'default1'), (7, 14, 'default1'), (8, 17, 'C'), (9, 16, 'default2'), (10, 6, 'C'), (11, 4, 'A'), (12, 17, 'C'), (13, 6, 'default2'), (14, 14, NULL), (15, 17, 'C'), (16, 0, 'default1'), (17, 6, 'C'), (18, 6, 'B'), (19, 0, 'B'), (20, 8, 'A'), (21, 13, 'B'), (22, 13, NULL), (23, 11, 'default2'), (24, 3, 'C'), (25, 8, 'C'), (26, 11, 'default2'), (27, 4, NULL), (28, 1, 'C'), (29, 15, 'default2'), (30, 10, 'default2'), (31, 14, 'default2'), (32, 17, 'B'), (33, 14, 'A'), (34, NULL, 'C'), (35, -1, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(14, 'default2')
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS AS A WHERE PRODUCT_NAME = 'A' AND CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C'));

/*
Prediction Result:
*/