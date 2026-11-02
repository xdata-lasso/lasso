-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default2'), (-1, 'default1'), (1, 'C'), (2, 'B'), (3, 'A'), (4, 'C'), (5, 'A'), (6, 'B'), (7, 'default1'), (8, 'default2'), (9, 'A'), (10, 'C'), (11, 'A'), (12, 'B'), (13, 'C'), (14, 'C'), (15, 'default1'), (16, NULL), (17, 'B'), (18, 'default1'), (19, 'C'), (20, 'B'), (21, 'C'), (22, 'B'), (23, 'default2'), (24, NULL), (25, 'default1'), (26, NULL), (27, 'default2'), (28, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 0, NULL), (1, 19, NULL), (0, 25, 'B'), (2, -1, 'default1'), (3, NULL, 'C'), (4, 27, NULL), (5, 24, 'B'), (6, 17, 'default1'), (7, 5, 'default2'), (8, 16, 'default2'), (9, 24, 'B'), (10, 15, NULL), (11, 25, NULL), (12, 14, 'default2'), (13, 14, 'default1'), (14, 13, 'A'), (15, 14, 'default2'), (16, 7, 'C'), (17, 6, NULL), (18, 10, 'A'), (19, 17, 'B'), (20, 9, 'A'), (21, 13, 'B'), (22, 11, 'A'), (23, 8, 'C'), (24, 17, 'B'), (25, 18, NULL), (26, 0, 'A'), (27, NULL, 'B'), (28, 13, 'default1'), (29, 18, 'B'), (30, 3, 'A'), (31, 7, 'C'), (32, 3, 'B'), (33, 23, 'C'), (34, 2, 'B'), (35, 27, 'default1'), (36, 24, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM ORDERS AS O LEFT JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID GROUP BY O.CUSTOMER_ID HAVING SUM(O.PRODUCT_NAME = 'A') > 0 AND SUM(O.PRODUCT_NAME = 'B') > 0 AND SUM(O.PRODUCT_NAME = 'C') = 0 ORDER BY O.CUSTOMER_ID, C.CUSTOMER_ID NULLS LAST, C.CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
(3, 'A')
(13, 'C')
*/