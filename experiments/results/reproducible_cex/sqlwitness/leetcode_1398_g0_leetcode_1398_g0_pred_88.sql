-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default1'), (-1, 'default2'), (3, 'B'), (2, 'B'), (1, 'B'), (4, 'A'), (5, 'C'), (6, 'default2'), (7, 'default2'), (8, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 8, 'default1'), (1, 6, NULL), (3, 8, NULL), (-1, 1, 'default1'), (2, 8, 'C'), (4, 4, 'default2'), (5, 6, 'default2'), (6, 8, 'default1'), (7, 2, NULL), (8, -1, 'C'), (9, NULL, 'default2'), (10, 0, 'A'), (11, 5, 'default2'), (12, -1, 'C'), (13, NULL, 'C'), (14, 0, 'default2'), (15, 1, 'B'), (16, NULL, 'A'), (17, 3, 'C'), (18, 0, 'C'), (19, -1, 'C'), (20, NULL, 'default2'), (21, 1, 'A'), (22, -1, 'default2'), (23, 5, 'A'), (24, 0, NULL), (25, 5, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH ORDER_CNT AS (SELECT CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME IN ('A', 'B') THEN 1 WHEN PRODUCT_NAME = 'C' THEN -1 ELSE 0 END) AS CNT FROM ORDERS GROUP BY CUSTOMER_ID) SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM ORDER_CNT JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = ORDER_CNT.CUSTOMER_ID WHERE ORDER_CNT.CNT = 2;

/*
Prediction Result:
(1, 'B')
*/