-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'A'), (1, NULL), (0, 'A'), (-1, 'A'), (3, 'A'), (4, 'default1'), (5, 'A'), (6, 'B'), (7, 'B'), (8, 'B'), (9, 'default2'), (10, NULL), (11, 'A'), (12, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 7, 'default1'), (1, 5, 'default2'), (2, 1, 'default2'), (-1, 12, 'C'), (3, 2, NULL), (4, -1, 'B'), (5, 6, 'C'), (6, 8, 'default1'), (7, -1, 'B'), (8, NULL, 'C'), (9, 7, NULL), (10, 12, 'C'), (11, 9, 'C'), (12, NULL, 'B'), (13, -1, 'A'), (14, 4, 'B'), (15, 2, 'C'), (16, 10, NULL), (17, NULL, 'B'), (18, 11, 'A'), (19, 4, 'A'), (20, -1, 'B'), (21, 7, 'C'), (22, 11, 'default1'), (23, 12, 'A'), (24, 7, NULL), (25, 3, NULL), (26, 2, NULL), (27, 10, 'C'), (28, NULL, 'default2'), (29, 8, 'default1'), (30, 9, 'B'), (31, 9, NULL), (32, 0, NULL), (33, 8, NULL), (34, 11, 'default2'), (35, -1, 'C'), (36, 10, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(4, 'default1')
*/

-- Prediction Query
SELECT DISTINCT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C INNER JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE PRODUCT_NAME = 'A' AND C.CUSTOMER_ID IN (SELECT O.CUSTOMER_ID FROM ORDERS AS O WHERE PRODUCT_NAME = 'B') AND NOT C.CUSTOMER_ID IN (SELECT O.CUSTOMER_ID FROM ORDERS AS O WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
*/