-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default2'), (2, 'C'), (1, 'default1'), (-1, NULL), (3, 'default1'), (4, 'default1'), (5, 'default2'), (6, 'default2'), (7, 'A'), (8, 'C'), (9, 'A'), (10, 'B'), (11, 'default2'), (12, 'B'), (13, 'B'), (14, 'default1'), (15, 'A'), (16, 'A'), (17, 'A'), (18, 'default2'), (19, 'B'), (20, 'default2'), (21, 'default2'), (22, NULL), (23, 'default1'), (24, NULL), (25, 'B'), (26, 'B'), (27, 'default1'), (28, NULL), (29, 'default2'), (30, 'C'), (31, 'C'), (32, 'A'), (33, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 13, 'B'), (1, 23, 'B'), (0, NULL, 'C'), (2, 7, 'A'), (3, 18, 'B'), (4, 2, 'C'), (5, 12, 'default2'), (6, 12, 'A'), (7, 11, 'A'), (8, 1, 'C'), (9, 25, 'B'), (10, 25, 'default1'), (11, 11, 'default1'), (12, 13, 'C'), (13, NULL, 'default1'), (14, 27, 'default2'), (15, 16, 'C'), (16, 22, NULL), (17, 14, 'B'), (18, 20, 'default2'), (19, 23, 'B'), (20, 7, 'B'), (21, 24, 'C'), (22, 20, 'default2'), (23, 3, 'A'), (24, 13, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT COMPILED_RESULT.CUSTOMER_ID, C1.CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) AS A, SUM(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) AS B, SUM(CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS COMPILED_RESULT INNER JOIN CUSTOMERS AS C1 ON COMPILED_RESULT.CUSTOMER_ID = C1.CUSTOMER_ID AND A >= 1 AND B >= 1 AND C = 0;

/*
Prediction Result:
(7, 'A')
*/