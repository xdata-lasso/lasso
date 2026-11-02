-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'A'), (-1, 'default1'), (0, 'A'), (1, 'B'), (3, 'default2'), (4, NULL), (5, NULL), (6, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 0, 'default1'), (-1, 3, 'C'), (2, NULL, 'default1'), (0, 3, 'A'), (3, 1, 'B'), (4, 1, 'default1'), (5, 0, 'B'), (6, NULL, 'A'), (7, 2, 'A'), (8, 0, 'B'), (9, 1, 'default2'), (10, 4, 'default2'), (11, -1, 'B'), (12, NULL, 'A'), (13, 2, 'C'), (14, 3, 'C'), (15, 2, NULL), (16, 2, 'A'), (17, 3, 'default1'), (18, 0, 'B'), (19, NULL, 'default2'), (20, 5, NULL), (21, 1, 'default1'), (22, 1, 'C'), (23, -1, 'default1'), (24, 2, 'default1'), (25, 6, NULL), (26, 4, NULL), (27, NULL, 'default1'), (28, 3, 'A'), (29, 5, 'default1'), (30, 1, NULL), (31, 5, 'B'), (32, 5, 'A'), (33, 1, 'C'), (34, 2, 'default1'), (35, 2, 'B'), (36, -1, 'A'), (37, 0, 'C'), (38, 1, 'B'), (39, 6, 'A'), (40, NULL, 'default1'), (41, NULL, NULL), (42, 0, 'default2'), (43, 6, NULL), (44, 6, 'default1'), (45, 5, NULL), (46, NULL, 'C'), (47, 1, 'B'), (48, 0, 'C'), (49, -1, 'B'), (50, -1, 'default2'), (51, 2, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT A.CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) AS PRODA, SUM(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) AS PRODB, SUM(CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) AS PRODC FROM ORDERS GROUP BY CUSTOMER_ID) AS A JOIN CUSTOMERS AS C ON A.CUSTOMER_ID = C.CUSTOMER_ID WHERE PRODA >= 1 AND PRODB >= 1 AND PRODC = 0;

/*
Prediction Result:
(-1, 'default1')
(5, None)
*/