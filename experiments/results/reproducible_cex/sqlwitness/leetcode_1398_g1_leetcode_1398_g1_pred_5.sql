-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'default2'), (1, 'A'), (2, 'default2'), (0, NULL), (3, 'A'), (4, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, -1, 'B'), (2, 1, 'A'), (1, 1, 'default2'), (0, NULL, NULL), (3, 0, 'default2'), (4, 2, 'B'), (5, NULL, 'B'), (6, 3, 'default2'), (7, 3, NULL), (8, 0, 'A'), (9, 3, 'B'), (10, 0, 'A'), (11, 4, NULL), (12, NULL, 'C'), (13, 2, 'B'), (14, 1, NULL), (15, 3, 'A'), (16, 0, 'C'), (17, 3, 'B'), (18, 4, 'default1'), (19, 0, 'B'), (20, 0, 'default2'), (21, 3, 'default1'), (22, -1, 'B'), (23, 4, NULL), (24, 2, 'B'), (25, 2, 'B'), (26, 1, 'C'), (27, 1, 'default1'), (28, 0, NULL), (29, NULL, 'A'), (30, 4, 'A'), (31, 2, 'default1'), (32, NULL, 'default2'), (33, 2, 'C'), (34, -1, NULL), (35, -1, 'C'), (36, NULL, 'B'), (37, 4, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(3, 'A')
(4, 'B')
*/

-- Prediction Query
SELECT DISTINCT C.CUSTOMER_ID AS CUSTOMER_ID, C.CUSTOMER_NAME AS CUSTOMER_NAME FROM CUSTOMERS AS C INNER JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE NOT C.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') AND C.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND C.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B');

/*
Prediction Result:
*/