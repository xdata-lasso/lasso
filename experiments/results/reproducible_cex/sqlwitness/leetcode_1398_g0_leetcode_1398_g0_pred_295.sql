-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'default2'), (1, 'default2'), (0, 'default1'), (3, 'default2'), (4, 'B'), (5, 'default1'), (6, 'default2'), (7, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 1, 'B'), (2, 5, NULL), (1, 4, 'default1'), (3, 3, NULL), (4, 0, 'default1'), (5, 5, 'default1'), (6, 3, 'A'), (7, 5, NULL), (8, 0, 'default1'), (9, 5, 'default2'), (10, 3, 'A'), (11, 4, 'C'), (12, 6, 'C'), (13, 2, 'A'), (14, 4, 'default2'), (15, 1, 'B'), (16, 4, 'default2'), (17, 6, 'C'), (18, 5, 'default1'), (19, 6, 'default2'), (20, 6, NULL), (21, 2, 'default1'), (22, 4, 'default2'), (23, 0, 'B'), (24, NULL, 'B'), (25, 6, 'A'), (26, NULL, 'default1'), (27, 5, 'C'), (28, NULL, 'default2'), (29, 1, 'A'), (30, 1, 'C'), (31, 7, 'default2'), (32, 7, NULL), (33, 1, 'default1'), (34, 3, 'B'), (35, 4, NULL), (36, NULL, 'default2'), (37, 0, 'C'), (38, 1, 'default1'), (39, 1, NULL), (40, NULL, 'C'), (41, 2, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT T.CUSTOMER_ID, C.CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(PRODUCT_NAME = 'A') * SUM(PRODUCT_NAME = 'B') * (1 - SUM(PRODUCT_NAME = 'C')) AS ISAB_NOTC FROM ORDERS GROUP BY CUSTOMER_ID) AS T CROSS JOIN CUSTOMERS AS C WHERE T.CUSTOMER_ID = C.CUSTOMER_ID AND ISAB_NOTC >= 1;

/*
Prediction Result:
(2, 'default2')
(3, 'default2')
*/