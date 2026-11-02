-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'A'), (1, 'A'), (-1, 'default1'), (2, 'C'), (3, 'A'), (4, 'default1'), (5, 'C'), (6, 'A'), (7, 'default2'), (8, 'default1'), (9, 'A'), (10, 'C'), (11, 'B'), (12, 'default1'), (13, 'default1'), (14, NULL), (15, 'default1'), (16, NULL), (17, NULL), (18, 'A'), (19, 'A'), (20, NULL), (21, 'default1'), (22, 'default2'), (23, 'A'), (24, NULL), (25, NULL), (26, 'default1'), (27, NULL), (28, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, NULL, 'C'), (-1, 20, 'default1'), (1, 17, 'default2'), (2, 4, 'A'), (3, 12, 'default2'), (4, 26, 'default2'), (5, 6, 'A'), (6, 25, 'A'), (7, -1, 'B'), (8, 26, 'C'), (9, 0, NULL), (10, 6, NULL), (11, -1, 'B'), (12, 18, 'A'), (13, 22, 'A'), (14, 24, 'C'), (15, NULL, 'default2'), (16, 12, 'C'), (17, 18, 'C'), (18, 27, 'default1'), (19, -1, 'default2'), (20, 24, 'B'), (21, -1, 'B'), (22, 23, 'default1'), (23, 4, NULL), (24, 8, 'default2'), (25, 13, NULL), (26, 23, 'C'), (27, -1, 'A'), (28, 3, 'default2'), (29, 13, 'C'), (30, -1, 'A'), (31, 9, 'B'), (32, 19, 'B'), (33, 20, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID GROUP BY C.CUSTOMER_ID, C.CUSTOMER_NAME HAVING SUM(CASE WHEN O.PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN O.PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN O.PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) = 0;

/*
Prediction Result:
(-1, 'default1')
*/