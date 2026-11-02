-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'B'), (1, 'default1'), (2, NULL), (3, 'A'), (4, 'default2'), (5, 'default1'), (6, 'default2'), (7, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 1, 'C'), (1, 0, 'A'), (2, 3, 'C'), (3, 0, NULL), (4, 3, 'default2'), (5, 3, 'B'), (6, 6, 'default2'), (7, 4, 'A'), (8, 7, NULL), (9, 2, 'default1'), (10, NULL, 'A'), (11, 1, 'default2'), (12, 1, 'C'), (13, 2, 'default2'), (14, 3, NULL), (15, 1, 'C'), (16, 0, 'A'), (17, 5, 'A'), (18, 1, 'C'), (19, 7, 'A'), (20, 5, 'default1'), (21, 5, 'default1'), (22, 7, 'default2'), (23, 7, 'default1'), (24, 7, 'default1'), (25, 0, 'default2'), (26, 1, 'A'), (27, NULL, 'default1'), (28, 1, 'default2'), (29, 2, NULL), (30, 3, 'A'), (31, 1, 'default2'), (32, 2, NULL), (33, 3, 'C'), (34, 5, 'B'), (35, 4, 'default2'), (36, 6, 'B'), (37, NULL, 'default1'), (38, 7, 'default2'), (39, 7, 'B'), (40, 6, 'default2'), (41, 2, NULL), (42, 1, 'A'), (43, 4, 'C'), (44, 4, NULL), (45, 4, NULL), (46, 7, 'default1'), (47, 5, 'B'), (48, 1, 'default1'), (49, 7, NULL), (50, 7, 'A'), (51, 0, 'default2'), (52, 5, NULL), (53, 6, 'A'), (54, 7, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(5, 'default1')
(6, 'default2')
(7, 'default2')
*/

-- Prediction Query
WITH T1 AS (SELECT T_A.CUSTOMER_ID FROM (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AS T_A JOIN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AS T_B ON T_A.CUSTOMER_ID = T_B.CUSTOMER_ID) SELECT DISTINCT T1.CUSTOMER_ID, CUSTOMER_NAME FROM T1 JOIN CUSTOMERS AS C ON T1.CUSTOMER_ID = C.CUSTOMER_ID AND NOT T1.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(5, 'default1')
(7, 'default2')
(6, 'default2')
*/