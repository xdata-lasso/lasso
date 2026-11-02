-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default1'), (1, 'B'), (-1, 'B'), (2, 'default2'), (3, 'default2'), (4, 'B'), (5, 'default1'), (6, 'default2'), (7, 'default1'), (8, 'default1'), (9, 'default2'), (10, NULL), (11, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 7, 'C'), (0, 1, 'default1'), (1, 4, 'default1'), (2, 3, 'default2'), (3, 10, NULL), (4, 7, 'A'), (5, 7, 'A'), (6, 0, 'default1'), (7, 5, 'C'), (8, 3, 'C'), (9, 7, NULL), (10, 2, 'B'), (11, 0, 'default2'), (12, 3, 'B'), (13, 2, 'A'), (14, 8, 'C'), (15, 7, 'A'), (16, 3, 'C'), (17, 3, 'C'), (18, NULL, 'default1'), (19, 11, 'B'), (20, 7, 'C'), (21, 8, 'C'), (22, NULL, 'default2'), (23, 10, 'default1'), (24, 4, NULL), (25, 6, 'C'), (26, -1, NULL), (27, 11, 'B'), (28, NULL, 'C'), (29, 6, NULL), (30, 8, 'A'), (31, 10, 'default2'), (32, 4, 'C'), (33, 0, NULL), (34, 3, 'C'), (35, 0, 'default2'), (36, 8, 'A'), (37, 11, NULL), (38, NULL, 'C'), (39, 7, 'A'), (40, 2, NULL), (41, 11, 'C'), (42, 5, 'C'), (43, 3, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH ORDER_TOTALS AS (SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME, SUM(O.PRODUCT_NAME = 'A') AS A_TOTAL, SUM(O.PRODUCT_NAME = 'B') AS B_TOTAL, SUM(O.PRODUCT_NAME = 'C') AS C_TOTAL FROM CUSTOMERS AS C JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID GROUP BY C.CUSTOMER_ID) SELECT CUSTOMER_ID, CUSTOMER_NAME FROM ORDER_TOTALS WHERE A_TOTAL <> 0 AND B_TOTAL <> 0 AND C_TOTAL = 0 ORDER BY CUSTOMER_ID, CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
(2, 'default2')
*/