-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, NULL), (0, 'default1'), (2, 'A'), (1, 'B'), (3, 'A'), (4, 'B'), (5, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, NULL, 'default1'), (2, -1, 'C'), (0, 3, 'default2'), (1, 3, 'default1'), (3, -1, 'default1'), (4, 3, 'C'), (5, NULL, NULL), (6, NULL, 'default2'), (7, 1, 'default2'), (8, 3, 'B'), (9, 3, 'C'), (10, 5, 'B'), (11, 1, NULL), (12, 4, 'default1'), (13, 3, 'C'), (14, 1, 'default2'), (15, NULL, 'A'), (16, 3, 'A'), (17, NULL, 'C'), (18, -1, 'C'), (19, -1, 'default2'), (20, 5, 'B'), (21, 5, 'default2'), (22, 4, 'default1'), (23, -1, 'B'), (24, -1, 'default1'), (25, 3, 'A'), (26, 2, 'default1'), (27, 4, 'default1'), (28, NULL, 'C'), (29, 5, 'default1'), (30, 5, 'A'), (31, 5, 'B'), (32, 4, 'C'), (33, -1, 'C'), (34, 4, 'B'), (35, 0, 'default1'), (36, 1, 'A'), (37, -1, 'default1'), (38, 0, 'default1'), (39, -1, 'A'), (40, -1, NULL), (41, -1, NULL), (42, 2, 'default1'), (43, 0, 'B'), (44, 1, 'A'), (45, 3, 'A'), (46, 3, 'C'), (47, 3, 'B'), (48, 5, 'B'), (49, NULL, 'default2'), (50, 0, 'default2'), (51, 4, 'A'), (52, 4, 'B'), (53, -1, 'C'), (54, 2, 'default1'), (55, 3, 'default1'), (56, 0, 'A'), (57, 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM (SELECT CUSTOMER_ID FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS ACOUNT, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS BCOUNT, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS CCOUNT FROM ORDERS GROUP BY CUSTOMER_ID) AS A WHERE ACOUNT > 0 AND BCOUNT > 0 AND CCOUNT = 0) AS B JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = B.CUSTOMER_ID;

/*
Prediction Result:
(0, 'default1')
(5, None)
*/