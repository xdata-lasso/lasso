-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'A'), (0, 'A'), (2, NULL), (3, 'B'), (4, 'A'), (5, 'A'), (6, 'default1'), (7, 'A'), (8, 'C'), (9, NULL), (10, 'B'), (11, 'C'), (12, 'default1'), (13, 'default1'), (14, 'default2'), (15, NULL), (16, 'default2'), (17, NULL), (18, 'B'), (19, NULL), (20, 'default1'), (21, 'default2'), (22, 'C'), (23, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, NULL, NULL), (1, 1, NULL), (2, 4, NULL), (3, 7, NULL), (4, 6, NULL), (5, 16, 'A'), (6, 14, 'default1'), (7, 7, 'default2'), (8, 16, 'default2'), (9, 17, NULL), (10, 17, 'default1'), (11, 2, 'A'), (12, 11, NULL), (13, 11, 'B'), (14, 15, NULL), (15, 9, 'C'), (16, 12, 'B'), (17, 20, 'A'), (18, 12, 'C'), (19, 1, 'B'), (20, 17, 'A'), (21, 1, 'A'), (22, 17, NULL), (23, 14, 'default1'), (24, 0, 'default2'), (25, 4, 'A'), (26, NULL, 'C'), (27, 4, 'A'), (28, 16, 'A'), (29, 13, NULL), (30, 11, 'B'), (31, 23, 'C'), (32, 0, 'default2'), (33, 2, 'A'), (34, 12, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT O.CUSTOMER_ID, CUSTOMER_NAME, PRODUCT_NAME FROM CUSTOMERS AS C LEFT JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID) SELECT DISTINCT CUSTOMER_ID, CUSTOMER_NAME FROM CTE WHERE PRODUCT_NAME IN ('A') AND NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM CTE WHERE PRODUCT_NAME = 'C') AND CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM CTE WHERE PRODUCT_NAME = 'B');

/*
Prediction Result:
(1, 'A')
*/