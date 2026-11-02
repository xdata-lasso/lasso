-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'default2'), (2, 'B'), (0, 'B'), (3, NULL), (4, 'C'), (5, 'B'), (6, 'default1'), (7, 'A'), (8, 'B'), (9, 'B'), (10, NULL), (11, 'A'), (12, 'default1'), (13, NULL), (14, NULL), (15, 'default1'), (16, 'A'), (17, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, NULL, 'B'), (0, 6, 'B'), (2, 1, 'default1'), (3, 0, 'A'), (4, 16, 'default2'), (5, 4, 'A'), (6, 5, 'A'), (7, 13, 'C'), (8, 7, 'A'), (9, 16, 'B'), (10, 6, 'C'), (11, 10, 'A'), (12, 9, 'B'), (13, 15, 'B'), (14, 13, 'B'), (15, 14, 'C'), (16, 14, 'C'), (17, 16, 'default2'), (18, 12, 'A'), (19, 15, 'default2'), (20, 15, NULL), (21, 4, NULL), (22, 12, 'B'), (23, 4, 'default1'), (24, 15, 'B'), (25, 13, 'default2'), (26, NULL, 'C'), (27, 0, NULL), (28, 9, 'default1'), (29, 3, 'B'), (30, 17, 'B'), (31, 8, 'C'), (32, NULL, NULL), (33, 4, 'default2'), (34, 11, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT T.CUSTOMER_ID, C.CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(DISTINCT PRODUCT_NAME = 'A') * SUM(DISTINCT PRODUCT_NAME = 'B') * (1 - SUM(DISTINCT PRODUCT_NAME = 'C')) AS ISAB_NOTC FROM ORDERS GROUP BY CUSTOMER_ID) AS T CROSS JOIN CUSTOMERS AS C WHERE T.CUSTOMER_ID = C.CUSTOMER_ID AND ISAB_NOTC = 1;

/*
Prediction Result:
(12, 'default1')
*/