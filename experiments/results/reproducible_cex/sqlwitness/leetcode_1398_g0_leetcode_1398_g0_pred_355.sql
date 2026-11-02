-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default2'), (1, 'default1'), (2, 'default1'), (3, 'A'), (4, 'C'), (5, 'C'), (6, 'A'), (7, 'default2'), (8, NULL), (9, NULL), (10, NULL), (11, 'B'), (12, 'B'), (13, 'A'), (14, 'A'), (15, NULL), (16, 'B'), (17, 'C'), (18, 'C'), (19, NULL), (20, 'B'), (21, 'default1'), (22, 'default2'), (23, 'C'), (24, 'B'), (25, 'A'), (26, 'C'), (27, NULL), (28, 'default2'), (29, 'B'), (30, 'default2'), (31, 'A'), (32, 'A'), (33, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 3, NULL), (1, 13, 'B'), (2, 18, 'default2'), (3, 15, 'default1'), (4, 27, 'default1'), (5, 28, 'B'), (6, 7, NULL), (7, 28, 'default1'), (8, 2, 'B'), (9, 17, 'B'), (10, 4, 'default2'), (11, 14, 'B'), (12, 15, 'B'), (13, 32, 'default2'), (14, 24, 'A'), (15, 32, 'default2'), (16, 22, 'A'), (17, 7, 'default2'), (18, 27, NULL), (19, 5, 'default2'), (20, 7, 'default2'), (21, 6, 'default1'), (22, 31, 'C'), (23, NULL, 'B'), (24, 6, 'default1'), (25, 25, 'default1'), (26, 30, NULL), (27, 16, 'default1'), (28, 17, NULL), (29, 3, 'default1'), (30, 0, 'default1'), (31, 19, 'default2'), (32, 5, 'C'), (33, 25, NULL), (34, 21, NULL), (35, 22, 'default2'), (36, 10, 'default2'), (37, 27, 'C'), (38, 3, 'A'), (39, 33, 'default2'), (40, 25, 'B'), (41, 27, 'B'), (42, 23, 'default2'), (43, 4, 'C'), (44, 33, NULL), (45, NULL, 'C'), (46, 18, 'default1'), (47, 14, 'default2'), (48, 1, 'C'), (49, 12, 'A'), (50, 32, NULL), (51, NULL, 'A'), (52, 14, 'B'), (53, 9, 'C'), (54, 25, 'default1'), (55, NULL, 'A'), (56, 16, 'A'), (57, 25, 'A'), (58, 16, NULL), (59, 17, 'C'), (60, 27, NULL), (61, 24, 'C'), (62, 33, 'default1'), (63, 0, NULL), (64, 7, 'default2'), (65, 24, 'C'), (66, 16, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT T.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C INNER JOIN (SELECT DISTINCT A.CUSTOMER_ID FROM (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AS A LEFT JOIN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID LEFT JOIN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') AS C ON A.CUSTOMER_ID = C.CUSTOMER_ID WHERE NOT B.CUSTOMER_ID IS NULL AND C.CUSTOMER_ID IS NULL) AS T ON C.CUSTOMER_ID = T.CUSTOMER_ID;

/*
Prediction Result:
(25, 'A')
*/