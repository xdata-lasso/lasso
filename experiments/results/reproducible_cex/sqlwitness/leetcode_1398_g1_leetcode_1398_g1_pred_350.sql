-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default1'), (-1, 'default1'), (2, 'A'), (1, 'default1'), (3, 'C'), (4, 'default2'), (5, 'C'), (6, 'C'), (7, 'B'), (8, 'default2'), (9, 'A'), (10, 'B'), (11, 'B'), (12, 'default2'), (13, 'C'), (14, NULL), (15, 'A'), (16, 'B'), (17, 'default1'), (18, 'default2'), (19, 'default2'), (20, 'default2'), (21, 'default2'), (22, 'B'), (23, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 4, 'default2'), (-1, 10, 'default2'), (2, 11, 'default1'), (0, 12, 'default2'), (3, 8, 'B'), (4, 5, NULL), (5, 23, 'default1'), (6, 7, 'default2'), (7, 18, NULL), (8, 1, 'A'), (9, 6, 'B'), (10, -1, NULL), (11, 22, 'default1'), (12, -1, 'B'), (13, 11, NULL), (14, 19, NULL), (15, NULL, 'C'), (16, 2, 'A'), (17, 21, 'C'), (18, -1, 'default1'), (19, 10, NULL), (20, 18, 'default2'), (21, 5, 'B'), (22, 2, NULL), (23, 19, 'B'), (24, 11, 'default2'), (25, 17, NULL), (26, 16, 'B'), (27, 13, 'C'), (28, 23, 'B'), (29, 0, 'B'), (30, 16, 'C'), (31, 17, 'B'), (32, -1, 'default1'), (33, 0, 'default1'), (34, 1, 'B'), (35, 0, 'A'), (36, 0, 'default2'), (37, 2, NULL), (38, 0, NULL), (39, 17, 'A'), (40, 7, 'B'), (41, 13, 'B'), (42, 17, 'default2'), (43, 18, 'default2'), (44, 15, NULL), (45, 19, 'A'), (46, 10, 'default2'), (47, 12, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(0, 'default1')
(1, 'default1')
(17, 'default1')
(19, 'default2')
*/

-- Prediction Query
SELECT DISTINCT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C LEFT JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE C.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND C.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT C.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY 1, C.CUSTOMER_ID NULLS LAST, C.CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
*/