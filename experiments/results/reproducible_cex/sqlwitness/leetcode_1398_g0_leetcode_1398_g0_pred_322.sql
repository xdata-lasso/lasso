-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, NULL), (2, 'C'), (0, 'default2'), (1, 'B'), (3, NULL), (4, 'default2'), (5, 'B'), (6, 'default1'), (7, 'default2'), (8, 'C'), (9, 'default1'), (10, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 0, 'default1'), (0, NULL, 'C'), (1, 3, 'C'), (2, 9, 'A'), (3, 4, 'default2'), (4, 8, 'B'), (5, 7, NULL), (6, 6, 'B'), (7, 6, 'default1'), (8, -1, 'default1'), (9, 10, 'default2'), (10, 10, 'A'), (11, -1, 'A'), (12, 7, 'A'), (13, 6, 'default2'), (14, 10, 'C'), (15, 10, 'default2'), (16, 2, 'default1'), (17, 8, 'C'), (18, 10, 'A'), (19, 9, 'default2'), (20, 9, 'A'), (21, 4, NULL), (22, 5, 'C'), (23, 4, 'B'), (24, 4, 'default1'), (25, 3, 'A'), (26, 1, 'default1'), (27, 0, 'A'), (28, 4, 'default1'), (29, 9, 'B'), (30, 10, 'B'), (31, 0, 'default2'), (32, 3, 'default2'), (33, 7, 'B'), (34, 8, 'default2'), (35, 8, NULL), (36, 4, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT A.CUSTOMER_ID, B.CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) AS A_FLAG, SUM(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) AS B_FLAG, SUM(CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) AS C_FLAG FROM ORDERS GROUP BY CUSTOMER_ID) AS A JOIN CUSTOMERS AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID WHERE A.A_FLAG >= 1 AND A.B_FLAG >= 1 AND A.C_FLAG = 0;

/*
Prediction Result:
(7, 'default2')
(9, 'default1')
*/