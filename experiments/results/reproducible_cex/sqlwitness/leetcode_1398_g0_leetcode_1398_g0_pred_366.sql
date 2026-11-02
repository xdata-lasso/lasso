-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'C'), (1, 'A'), (-1, 'C'), (2, 'B'), (3, 'B'), (4, 'A'), (5, 'default2'), (6, 'default2'), (7, 'A'), (8, 'C'), (9, 'B'), (10, 'C'), (11, 'B'), (12, 'A'), (13, 'default1'), (14, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 12, NULL), (0, 11, 'A'), (1, 4, 'default1'), (2, 5, 'C'), (3, -1, 'default1'), (4, 3, 'A'), (5, 8, 'C'), (6, NULL, 'B'), (7, 13, 'default2'), (8, 11, 'default1'), (9, 12, 'C'), (10, 9, 'B'), (11, 0, 'A'), (12, 12, 'B'), (13, 9, 'default1'), (14, 7, 'B'), (15, 4, 'B'), (16, NULL, 'C'), (17, 8, 'B'), (18, 14, 'C'), (19, 0, 'default1'), (20, 5, 'C'), (21, 13, NULL), (22, 11, 'A'), (23, NULL, 'default2'), (24, 4, 'default1'), (25, 12, 'default1'), (26, 10, NULL), (27, 11, 'A'), (28, 4, 'A'), (29, 13, 'default2'), (30, 2, 'default1'), (31, 1, 'A'), (32, -1, 'A'), (33, 1, 'default1'), (34, 1, 'default1'), (35, NULL, NULL), (36, 0, 'default2'), (37, 3, 'default2'), (38, 2, 'C'), (39, 12, 'B'), (40, 0, 'B'), (41, 2, 'default1'), (42, 11, 'C'), (43, 7, 'C'), (44, 14, 'default2'), (45, 6, 'B'), (46, 8, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH PRODUCT_COUNTS AS (SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME, SUM(O.PRODUCT_NAME = 'A') AS A_COUNT, SUM(O.PRODUCT_NAME = 'B') AS B_COUNT, SUM(O.PRODUCT_NAME = 'C') AS C_COUNT FROM CUSTOMERS AS C JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID GROUP BY C.CUSTOMER_ID) SELECT CUSTOMER_ID, CUSTOMER_NAME FROM PRODUCT_COUNTS WHERE A_COUNT > 0 AND B_COUNT > 0 AND C_COUNT = 0 ORDER BY CUSTOMER_ID, CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
(0, 'C')
(4, 'A')
*/