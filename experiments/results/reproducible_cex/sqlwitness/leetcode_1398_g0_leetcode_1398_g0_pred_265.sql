-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, NULL), (2, 'B'), (1, NULL), (0, 'B'), (3, 'C'), (4, 'default2'), (5, 'B'), (6, 'C'), (7, 'default2'), (8, 'B'), (9, 'C'), (10, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 10, NULL), (2, 2, 'default2'), (0, 8, 'default1'), (1, -1, 'B'), (3, 2, 'A'), (4, 6, 'default1'), (5, 9, 'C'), (6, NULL, 'default1'), (7, 6, NULL), (8, 1, 'B'), (9, 6, NULL), (10, 8, 'default2'), (11, 10, 'B'), (12, 3, 'default1'), (13, 5, 'A'), (14, 3, NULL), (15, 5, 'A'), (16, 1, 'B'), (17, 0, 'default1'), (18, 5, NULL), (19, NULL, 'C'), (20, 5, 'default2'), (21, 7, 'B'), (22, 4, 'C'), (23, 3, 'C'), (24, 1, 'A'), (25, 5, 'A'), (26, 4, NULL), (27, 0, 'A'), (28, 1, 'A'), (29, 9, 'A'), (30, NULL, 'default1'), (31, 9, 'default2'), (32, 9, 'default1'), (33, 5, 'A'), (34, 10, 'A'), (35, -1, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH C1 AS (SELECT CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) AS A_COUNT, SUM(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) AS B_COUNT, SUM(CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) AS C_COUNT FROM ORDERS GROUP BY 1) SELECT C1.CUSTOMER_ID, C.CUSTOMER_NAME FROM C1 JOIN CUSTOMERS AS C ON C1.CUSTOMER_ID = C.CUSTOMER_ID WHERE (A_COUNT > 0 AND B_COUNT > 0 AND C_COUNT = 0) ORDER BY 1, C.customer_id NULLS LAST;

/*
Prediction Result:
(-1, None)
(1, None)
(10, 'C')
*/