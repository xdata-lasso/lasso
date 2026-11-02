-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'A'), (0, 'B'), (-1, 'default2'), (2, 'A'), (3, 'C'), (4, 'C'), (5, NULL), (6, 'B'), (7, 'default1'), (8, 'default1'), (9, 'default1'), (10, 'A'), (11, NULL), (12, 'C'), (13, 'default2'), (14, 'B'), (15, 'A'), (16, 'B'), (17, 'A'), (18, NULL), (19, 'A'), (20, 'default2'), (21, 'C'), (22, 'C'), (23, 'A'), (24, NULL), (25, 'default1'), (26, 'default1'), (27, 'B'), (28, 'default1'), (29, 'default2'), (30, 'B'), (31, 'A'), (32, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 29, 'A'), (2, 6, NULL), (0, 26, 'A'), (1, 15, 'default1'), (3, 7, 'default1'), (4, 13, 'default2'), (5, 12, 'B'), (6, -1, 'C'), (7, 28, NULL), (8, NULL, 'C'), (9, 28, NULL), (10, 14, 'A'), (11, 10, 'default2'), (12, 18, 'default1'), (13, 20, 'default2'), (14, 26, 'A'), (15, -1, 'B'), (16, 6, 'A'), (17, 25, 'C'), (18, 3, 'B'), (19, NULL, 'B'), (20, 14, 'B'), (21, 15, NULL), (22, -1, NULL), (23, 22, 'A'), (24, 7, 'A'), (25, -1, 'A'), (26, 16, NULL), (27, 5, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(14, 'B')
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C')) AS O JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID;

/*
Prediction Result:
*/