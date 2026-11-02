-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'default1'), (0, 'default1'), (1, 'default1'), (2, 'C'), (3, 'C'), (4, 'C'), (5, 'C'), (6, 'default2'), (7, 'B'), (8, 'A'), (9, 'C'), (10, 'default1'), (11, 'default2'), (12, 'B'), (13, 'A'), (14, 'A'), (15, 'B'), (16, 'A'), (17, 'A'), (18, 'default1'), (19, 'A'), (20, 'A'), (21, 'A'), (22, 'default1'), (23, 'B'), (24, 'C'), (25, NULL), (26, NULL), (27, 'default2'), (28, 'B'), (29, 'default1'), (30, NULL), (31, 'A'), (32, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 9, 'A'), (-1, 0, 'B'), (0, 23, 'default1'), (2, 17, 'B'), (3, 16, 'default1'), (4, 6, 'B'), (5, NULL, 'C'), (6, 19, 'C'), (7, 32, 'B'), (8, -1, NULL), (9, 5, 'C'), (10, 12, 'A'), (11, 19, 'C'), (12, 32, 'default1'), (13, 31, 'A'), (14, 24, 'default2'), (15, 5, 'B'), (16, 7, 'B'), (17, 10, 'default2'), (18, 18, 'B'), (19, 12, 'B'), (20, NULL, 'default1'), (21, 23, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT * FROM (SELECT IIF(SUM(O.PRODUCT_NAME = 'A') > 0 AND SUM(O.PRODUCT_NAME = 'B') > 0 AND SUM(O.PRODUCT_NAME = 'C') = 0, C.CUSTOMER_ID, NULL) AS CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID GROUP BY C.CUSTOMER_ID ORDER BY C.CUSTOMER_ID, CUSTOMER_ID NULLS LAST, C.CUSTOMER_NAME NULLS LAST) AS T WHERE NOT CUSTOMER_ID IS NULL;

/*
Prediction Result:
(12, 'B')
*/