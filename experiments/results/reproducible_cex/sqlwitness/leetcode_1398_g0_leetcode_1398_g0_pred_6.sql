-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, NULL), (0, 'C'), (1, 'C'), (2, 'default1'), (3, 'C'), (4, 'C'), (5, 'default1'), (6, 'C'), (7, 'default2'), (8, 'default2'), (9, 'A'), (10, NULL), (11, 'A'), (12, 'C'), (13, 'C'), (14, 'C'), (15, 'default1'), (16, 'A'), (17, 'C'), (18, NULL), (19, 'default1'), (20, 'B'), (21, 'C'), (22, 'default2'), (23, 'B'), (24, 'A'), (25, 'A'), (26, 'C'), (27, 'B'), (28, 'B'), (29, NULL), (30, 'default2'), (31, 'default1'), (32, 'A'), (33, 'default1'), (34, 'C'), (35, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 28, 'default2'), (-1, 33, NULL), (0, 20, 'B'), (2, 24, 'default1'), (3, 28, 'default2'), (4, 20, NULL), (5, 18, NULL), (6, 9, 'default2'), (7, 21, 'A'), (8, 20, 'A'), (9, 13, 'A'), (10, 2, 'default2'), (11, 1, 'B'), (12, 10, 'default1'), (13, 28, 'A'), (14, 33, 'A'), (15, 18, 'C'), (16, NULL, 'C'), (17, 31, 'A'), (18, 7, NULL), (19, 10, 'B'), (20, 24, 'A'), (21, 3, 'B'), (22, 26, 'default1'), (23, 11, 'C'), (24, 17, 'C'), (25, 27, 'C'), (26, 3, 'C'), (27, 14, 'C'), (28, 20, 'B'), (29, 25, 'default1'), (30, 32, NULL), (31, 1, 'default2'), (32, 9, 'default1'), (33, 2, NULL), (34, 1, 'A'), (35, 30, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID GROUP BY C.CUSTOMER_ID HAVING SUM(PRODUCT_NAME = 'A') > 0 AND SUM(PRODUCT_NAME = 'B') > 0 AND SUM(PRODUCT_NAME = 'C') = 0;

/*
Prediction Result:
(1, 'C')
(20, 'B')
*/