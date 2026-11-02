-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'B'), (-1, 'default2'), (2, 'A'), (0, 'default1'), (3, 'B'), (4, NULL), (5, NULL), (6, NULL), (7, 'C'), (8, 'A'), (9, 'default2'), (10, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 7, 'B'), (2, 1, NULL), (-1, 1, 'C'), (0, 2, 'B'), (3, 4, 'C'), (4, 8, NULL), (5, NULL, 'C'), (6, NULL, 'default1'), (7, 10, 'default1'), (8, 5, 'default1'), (9, 8, 'default1'), (10, 2, 'A'), (11, 10, 'default2'), (12, 9, 'B'), (13, 2, NULL), (14, 5, NULL), (15, 4, 'default1'), (16, 7, 'C'), (17, 6, 'A'), (18, 2, 'default1'), (19, 7, 'A'), (20, -1, 'B'), (21, 2, 'default2'), (22, 1, 'C'), (23, -1, 'C'), (24, 8, 'default2'), (25, 6, 'default2'), (26, 0, 'B'), (27, 1, 'A'), (28, 7, NULL), (29, 5, 'B'), (30, 3, NULL), (31, -1, 'default2'), (32, 1, NULL), (33, 5, 'A'), (34, 1, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT TMP.CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) AS BOUGHT_A, SUM(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) AS BOUGHT_B, SUM(CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) AS BOUGHT_C FROM ORDERS GROUP BY 1 HAVING BOUGHT_A > 0 AND BOUGHT_B > 0 AND BOUGHT_C = 0) AS TMP JOIN CUSTOMERS AS C ON TMP.CUSTOMER_ID = C.CUSTOMER_ID;

/*
Prediction Result:
(2, 'A')
(5, None)
*/