-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'A'), (1, NULL), (-1, 'A'), (0, 'A'), (3, NULL), (4, 'C'), (5, 'B'), (6, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, -1, 'C'), (0, 4, 'default1'), (2, -1, 'default2'), (-1, -1, 'B'), (3, NULL, 'A'), (4, -1, 'default2'), (5, 0, 'A'), (6, 0, 'B'), (7, -1, 'B'), (8, 1, 'B'), (9, 6, 'default1'), (10, NULL, 'default1'), (11, 4, 'default2'), (12, 5, 'default2'), (13, 5, 'default1'), (14, 2, 'C'), (15, 0, 'default1'), (16, NULL, 'default2'), (17, 6, NULL), (18, -1, NULL), (19, 0, 'default2'), (20, 4, 'A'), (21, 6, 'A'), (22, -1, NULL), (23, 5, 'default2'), (24, 6, 'B'), (25, 2, 'A'), (26, NULL, 'B'), (27, 4, 'C'), (28, 6, 'C'), (29, 1, 'B'), (30, 3, NULL), (31, 3, NULL), (32, -1, 'C'), (33, 2, 'default2'), (34, NULL, 'A'), (35, 0, 'default1'), (36, NULL, NULL), (37, 4, 'C'), (38, 0, NULL), (39, NULL, 'default1'), (40, 3, NULL), (41, 1, 'B'), (42, 3, 'C'), (43, 5, NULL), (44, 1, 'default2'), (45, 0, 'default2'), (46, 5, 'default2'), (47, 5, 'C'), (48, -1, 'C'), (49, NULL, 'C'), (50, NULL, NULL), (51, 4, 'default1'), (52, NULL, 'default1'), (53, 0, 'default1'), (54, -1, 'C'), (55, 2, 'B'), (56, -1, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH NUM_PROD_ORDERS AS (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS NUM_A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS NUM_B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS NUM_C FROM ORDERS GROUP BY CUSTOMER_ID) SELECT * FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM NUM_PROD_ORDERS WHERE NUM_A > 0 AND NUM_B > 0 AND NUM_C = 0) ORDER BY CUSTOMER_ID;

/*
Prediction Result:
(0, 'A')
*/