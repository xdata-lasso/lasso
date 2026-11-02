-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'default1'), (1, 'default2'), (2, 'default1'), (0, 'B'), (3, 'default2'), (4, 'default1'), (5, 'B'), (6, 'default1'), (7, 'C'), (8, NULL), (9, NULL), (10, 'B'), (11, 'default2'), (12, 'B'), (13, NULL), (14, 'default1'), (15, 'default1'), (16, 'B'), (17, 'default2'), (18, 'C'), (19, 'A'), (20, 'default1'), (21, 'A'), (22, 'default2'), (23, 'C'), (24, 'C'), (25, 'B'), (26, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 25, 'default2'), (-1, 20, 'B'), (2, 25, 'B'), (0, 24, 'A'), (3, 15, NULL), (4, 0, NULL), (5, 15, 'A'), (6, 12, NULL), (7, 3, 'B'), (8, 24, 'C'), (9, -1, 'B'), (10, 8, 'default2'), (11, 8, 'C'), (12, 12, 'default1'), (13, NULL, 'default1'), (14, 24, NULL), (15, 16, 'B'), (16, 24, 'A'), (17, 19, 'C'), (18, 19, 'default1'), (19, 23, 'default2'), (20, 25, 'default1'), (21, 4, 'B'), (22, -1, 'B'), (23, 19, 'default1'), (24, 17, NULL), (25, 13, 'default1'), (26, NULL, 'C'), (27, 18, 'C'), (28, 18, 'A'), (29, -1, 'default2'), (30, 13, 'C'), (31, 24, 'C'), (32, 10, 'C'), (33, -1, 'C'), (34, 2, 'default2'), (35, 3, 'B'), (36, 1, 'default2'), (37, 25, 'A'), (38, 2, 'default2'), (39, 2, 'A'), (40, 3, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(25, 'B')
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C WHERE C.CUSTOMER_ID IN (SELECT O.CUSTOMER_ID FROM ORDERS AS O WHERE O.PRODUCT_NAME = 'A') AND C.CUSTOMER_ID IN (SELECT O.CUSTOMER_ID FROM ORDERS AS O WHERE O.PRODUCT_NAME = 'B') AND NOT C.CUSTOMER_ID IN (SELECT O.CUSTOMER_ID FROM ORDERS AS O WHERE O.PRODUCT_NAME = 'C') ORDER BY C.CUSTOMER_ID ASC;

/*
Prediction Result:
*/