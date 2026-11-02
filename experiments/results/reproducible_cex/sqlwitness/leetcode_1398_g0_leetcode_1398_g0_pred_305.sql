-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, NULL), (0, 'default2'), (1, 'C'), (-1, 'default2'), (3, 'default2'), (4, 'C'), (5, 'A'), (6, 'A'), (7, 'B'), (8, 'default1'), (9, 'default1'), (10, 'default2'), (11, 'C'), (12, 'default1'), (13, 'default2'), (14, NULL), (15, 'A'), (16, NULL), (17, 'C'), (18, NULL), (19, NULL), (20, 'B'), (21, 'C'), (22, 'default2'), (23, 'default2'), (24, 'A'), (25, 'C'), (26, 'default2'), (27, 'B'), (28, 'C'), (29, 'B'), (30, 'default1'), (31, 'B'), (32, NULL), (33, NULL), (34, 'C'), (35, 'default2'), (36, 'default1'), (37, 'A'), (38, 'A'), (39, 'A'), (40, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, NULL, 'C'), (1, 26, 'C'), (0, 40, 'A'), (2, 16, NULL), (3, 26, 'B'), (4, 37, 'A'), (5, 13, 'default1'), (6, 22, 'A'), (7, 23, 'default2'), (8, 37, 'default1'), (9, 13, 'default2'), (10, 26, NULL), (11, 16, 'default1'), (12, 10, 'A'), (13, 3, NULL), (14, 16, 'default2'), (15, 15, 'default1'), (16, 18, 'B'), (17, 23, 'default2'), (18, 14, 'C'), (19, 7, 'default1'), (20, 20, NULL), (21, 39, 'A'), (22, NULL, 'B'), (23, 36, 'C'), (24, 29, NULL), (25, 10, 'default1'), (26, 3, 'default2'), (27, 17, 'A'), (28, 37, NULL), (29, 17, 'A'), (30, 37, 'default1'), (31, 10, 'B'), (32, 25, 'B'), (33, 30, 'B'), (34, 25, 'default1'), (35, 32, 'C'), (36, 15, 'A'), (37, 33, 'A'), (38, 5, 'default1'), (39, 8, NULL), (40, 6, 'A'), (41, 6, 'A'), (42, NULL, 'default2'), (43, 12, 'A'), (44, 31, 'B'), (45, 12, 'default2'), (46, 25, 'C'), (47, 14, 'B'), (48, 38, 'B'), (49, 21, 'default1'), (50, 2, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT O.CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS AS O JOIN CUSTOMERS AS C USING (CUSTOMER_ID) GROUP BY 1 HAVING MAX(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) = 1 AND MAX(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) = 1 AND MAX(CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) = 0;

/*
Prediction Result:
(10, 'default2')
*/