-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'C'), (-1, NULL), (0, 'B'), (2, NULL), (3, 'A'), (4, 'default1'), (5, NULL), (6, 'C'), (7, 'C'), (8, 'default1'), (9, 'C'), (10, NULL), (11, NULL), (12, 'default2'), (13, 'C'), (14, 'default2'), (15, 'B'), (16, NULL), (17, 'default1'), (18, 'B'), (19, 'B'), (20, 'default2'), (21, 'default2'), (22, NULL), (23, 'B'), (24, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 3, 'B'), (-1, 7, NULL), (0, 5, 'A'), (1, NULL, 'C'), (3, 10, 'default2'), (4, 6, 'B'), (5, 13, 'C'), (6, 20, 'default2'), (7, 7, 'default1'), (8, 13, 'C'), (9, 18, NULL), (10, 10, 'B'), (11, 10, 'C'), (12, 9, NULL), (13, 1, NULL), (14, 14, 'C'), (15, 24, NULL), (16, 1, 'A'), (17, 9, 'C'), (18, 8, NULL), (19, 6, 'C'), (20, 17, NULL), (21, 12, NULL), (22, NULL, NULL), (23, 10, 'default2'), (24, 19, 'default1'), (25, 0, NULL), (26, 9, NULL), (27, NULL, 'C'), (28, 4, 'default1'), (29, 19, 'A'), (30, 12, 'A'), (31, 14, 'C'), (32, 10, 'B'), (33, 13, 'B'), (34, 14, 'default2'), (35, 11, 'A'), (36, 5, 'B'), (37, 15, 'C'), (38, 8, 'C'), (39, 12, 'default1'), (40, 0, 'default2'), (41, 24, 'default1'), (42, 24, NULL), (43, NULL, 'A'), (44, 11, 'default2'), (45, -1, 'A'), (46, 15, 'A'), (47, 6, 'B'), (48, 14, 'default1'), (49, 8, 'B'), (50, 5, 'B'), (51, 0, 'default1'), (52, 21, 'default2'), (53, 24, 'default1'), (54, 24, NULL), (55, 8, 'A'), (56, 11, 'C'), (57, 24, 'C'), (58, -1, 'default1'), (59, 14, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME, SUM(IIF(O.PRODUCT_NAME = 'A', 1, 0)) AS ACOUNT, SUM(IIF(O.PRODUCT_NAME = 'B', 1, 0)) AS BCOUNT, SUM(IIF(O.PRODUCT_NAME = 'C', 1, 0)) AS CCOUNT FROM CUSTOMERS AS C JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID GROUP BY 1) SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CTE WHERE ACOUNT > 0 AND BCOUNT > 0 AND CCOUNT = 0;

/*
Prediction Result:
(5, None)
*/