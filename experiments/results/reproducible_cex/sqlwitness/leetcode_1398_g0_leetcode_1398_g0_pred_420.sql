-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'A'), (0, NULL), (-1, 'A'), (1, 'B'), (3, 'C'), (4, NULL), (5, 'default1'), (6, NULL), (7, 'C'), (8, 'B'), (9, 'default1'), (10, 'A'), (11, 'C'), (12, 'default1'), (13, NULL), (14, 'B'), (15, 'C'), (16, 'A'), (17, 'A'), (18, 'B'), (19, 'C'), (20, 'B'), (21, 'default1'), (22, 'C'), (23, 'B'), (24, 'default1'), (25, 'A'), (26, 'default1'), (27, 'C'), (28, 'default2'), (29, 'B'), (30, 'B'), (31, 'default2'), (32, 'C'), (33, 'B'), (34, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 31, 'default1'), (0, 17, 'C'), (1, 27, 'A'), (-1, 31, 'default2'), (3, 23, 'C'), (4, 14, 'A'), (5, 5, 'default2'), (6, 28, 'A'), (7, 16, 'default1'), (8, 5, 'C'), (9, 1, 'default2'), (10, 16, 'B'), (11, 32, 'A'), (12, 8, 'C'), (13, 2, 'B'), (14, 31, 'B'), (15, 4, 'B'), (16, 34, NULL), (17, 21, 'B'), (18, 21, 'default1'), (19, 9, 'C'), (20, 15, NULL), (21, 5, 'default2'), (22, 3, NULL), (23, 5, NULL), (24, 30, 'default1'), (25, 2, 'B'), (26, 10, NULL), (27, -1, 'default2'), (28, 18, 'default1'), (29, 24, 'default2'), (30, 4, NULL), (31, 19, 'C'), (32, 31, 'B'), (33, 3, 'B'), (34, 24, 'B'), (35, 2, 'default2'), (36, 34, NULL), (37, 11, NULL), (38, 6, 'B'), (39, 5, 'B'), (40, 16, 'default1'), (41, 30, 'A'), (42, 25, 'A'), (43, 30, 'B'), (44, 18, 'B'), (45, 34, 'B'), (46, 20, 'B'), (47, NULL, 'C'), (48, 7, 'A'), (49, 33, NULL), (50, 5, 'default2'), (51, 14, 'default2'), (52, 26, 'C'), (53, 24, 'C'), (54, 12, 'default2'), (55, 5, NULL), (56, 7, NULL), (57, 6, 'default2'), (58, 16, 'B'), (59, 13, 'B'), (60, 27, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT SUMMARY.CUSTOMER_ID, CUSTOMERS.CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) AS A, SUM(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) AS B, SUM(CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS SUMMARY JOIN CUSTOMERS ON SUMMARY.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0;

/*
Prediction Result:
(30, 'B')
*/