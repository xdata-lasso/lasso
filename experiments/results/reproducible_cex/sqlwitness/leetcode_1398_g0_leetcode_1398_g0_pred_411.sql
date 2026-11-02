-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'B'), (-1, 'A'), (0, 'default1'), (2, 'B'), (3, 'C'), (4, 'default1'), (5, 'default2'), (6, NULL), (7, 'default2'), (8, 'default2'), (9, 'default1'), (10, 'B'), (11, 'B'), (12, 'default1'), (13, 'C'), (14, 'default1'), (15, 'default1'), (16, 'A'), (17, 'A'), (18, 'A'), (19, 'A'), (20, 'C'), (21, NULL), (22, 'A'), (23, 'B'), (24, 'default1'), (25, 'C'), (26, NULL), (27, 'default1'), (28, 'C'), (29, NULL), (30, NULL), (31, 'B'), (32, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, NULL, 'C'), (-1, 32, NULL), (0, 10, 'default2'), (2, -1, 'B'), (3, 0, 'default2'), (4, 16, 'A'), (5, 11, 'B'), (6, 7, 'C'), (7, 21, NULL), (8, 24, NULL), (9, 29, NULL), (10, 4, 'default2'), (11, 30, 'A'), (12, 30, 'default2'), (13, 5, NULL), (14, 30, 'B'), (15, 16, 'default1'), (16, 20, 'C'), (17, 25, NULL), (18, 2, NULL), (19, 9, 'default2'), (20, 6, 'C'), (21, 12, 'default2'), (22, 21, 'C'), (23, 3, 'C'), (24, 9, 'A'), (25, 26, 'default1'), (26, 19, NULL), (27, 22, NULL), (28, 22, 'A'), (29, 25, NULL), (30, -1, 'A'), (31, 16, 'B'), (32, 22, 'default2'), (33, 11, 'A'), (34, 29, 'default1'), (35, 11, NULL), (36, 2, 'default1'), (37, 16, 'C'), (38, -1, 'B'), (39, 15, NULL), (40, -1, 'C'), (41, 31, 'default1'), (42, 19, 'default1'), (43, 26, 'B'), (44, 21, 'default2'), (45, 17, 'C'), (46, 29, 'default2'), (47, 19, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT O.CUSTOMER_ID, C.CUSTOMER_NAME FROM ORDERS AS O LEFT JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID GROUP BY O.CUSTOMER_ID HAVING SUM(PRODUCT_NAME = 'A') >= 1 AND SUM(PRODUCT_NAME = 'B') >= 1 AND SUM(PRODUCT_NAME = 'C') = 0;

/*
Prediction Result:
(11, 'B')
(30, None)
*/