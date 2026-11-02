-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'A'), (2, 'default1'), (-1, 'B'), (0, 'B'), (3, 'default2'), (4, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 1, NULL), (0, 4, NULL), (2, 1, NULL), (1, 1, 'B'), (3, NULL, 'C'), (4, -1, 'C'), (5, 4, 'B'), (6, 2, 'default2'), (7, NULL, NULL), (8, 3, 'B'), (9, 2, 'B'), (10, 4, 'A'), (11, 1, 'default1'), (12, 2, 'default1'), (13, 2, 'default2'), (14, 3, NULL), (15, 2, 'C'), (16, 0, NULL), (17, 3, 'A'), (18, 1, 'default1'), (19, 0, 'B'), (20, -1, 'A'), (21, 1, 'A'), (22, NULL, 'B'), (23, 0, 'C'), (24, 2, 'C'), (25, 1, 'B'), (26, -1, 'B'), (27, 2, 'B'), (28, -1, 'default1'), (29, NULL, 'B'), (30, 1, 'default2'), (31, 0, 'A'), (32, 3, 'B'), (33, 0, 'B'), (34, NULL, 'default1'), (35, 4, 'B'), (36, -1, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH TEMP AS (SELECT CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) AS A_CNT, SUM(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) AS B_CNT, SUM(CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) AS C_CNT FROM ORDERS GROUP BY CUSTOMER_ID) SELECT C.* FROM CUSTOMERS AS C JOIN TEMP AS T ON C.CUSTOMER_ID = T.CUSTOMER_ID WHERE A_CNT > 0 AND B_CNT > 0 AND C_CNT = 0 ORDER BY C.CUSTOMER_ID;

/*
Prediction Result:
(1, 'A')
(3, 'default2')
(4, 'B')
*/