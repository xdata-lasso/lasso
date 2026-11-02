-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'default2'), (1, 'A'), (0, 'default2'), (2, 'B'), (3, 'C'), (4, NULL), (5, 'B'), (6, 'B'), (7, 'C'), (8, NULL), (9, NULL), (10, 'A'), (11, 'default1'), (12, 'B'), (13, 'default1'), (14, 'A'), (15, 'default2'), (16, 'B'), (17, 'default2'), (18, 'C'), (19, 'default1'), (20, 'default2'), (21, 'C'), (22, 'default1'), (23, 'A'), (24, NULL), (25, NULL), (26, 'C'), (27, 'default1'), (28, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 6, 'default1'), (-1, 12, NULL), (1, 4, 'B'), (0, 25, 'default2'), (3, 20, 'C'), (4, 26, NULL), (5, 21, 'B'), (6, 12, 'B'), (7, 16, NULL), (8, 10, 'A'), (9, 8, 'A'), (10, 11, 'C'), (11, 10, 'default2'), (12, 8, 'default1'), (13, 13, 'default1'), (14, NULL, 'C'), (15, 2, 'default1'), (16, 2, 'C'), (17, 10, 'B'), (18, 25, 'default1'), (19, 23, 'C'), (20, 0, 'A'), (21, 23, NULL), (22, 8, 'A'), (23, 2, 'C'), (24, 22, 'C'), (25, 9, 'default2'), (26, NULL, 'C'), (27, 21, NULL), (28, 17, 'C'), (29, 18, 'default2'), (30, 11, 'B'), (31, 4, 'B'), (32, 8, NULL), (33, 21, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT O.CUSTOMER_ID, C.CUSTOMER_NAME FROM ORDERS AS O JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID GROUP BY O.CUSTOMER_ID HAVING SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) = 0;

/*
Prediction Result:
(10, 'A')
*/