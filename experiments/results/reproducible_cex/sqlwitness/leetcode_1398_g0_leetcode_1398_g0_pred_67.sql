-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'A'), (1, 'A'), (0, 'default2'), (-1, NULL), (3, 'default2'), (4, 'C'), (5, 'C'), (6, 'default1'), (7, 'C'), (8, 'A'), (9, 'default2'), (10, 'A'), (11, NULL), (12, 'default1'), (13, 'B'), (14, 'A'), (15, 'C'), (16, NULL), (17, NULL), (18, 'default1'), (19, NULL), (20, 'B'), (21, 'default2'), (22, 'C'), (23, 'C'), (24, 'B'), (25, NULL), (26, 'default2'), (27, 'default1'), (28, NULL), (29, 'C'), (30, 'default2'), (31, 'default2'), (32, 'B'), (33, 'B'), (34, NULL), (35, 'C'), (36, 'default1'), (37, 'default2'), (38, 'default2'), (39, 'C'), (40, 'B'), (41, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 25, 'default2'), (0, 40, 'A'), (2, 24, 'default2'), (1, 25, 'C'), (3, 23, 'C'), (4, 8, 'A'), (5, 30, 'C'), (6, 20, 'default1'), (7, 15, 'default2'), (8, 29, 'A'), (9, 13, NULL), (10, 11, 'default1'), (11, 39, 'C'), (12, 37, 'default2'), (13, 38, 'A'), (14, 24, 'B'), (15, 9, 'default1'), (16, 34, 'B'), (17, 30, 'default2'), (18, 29, 'C'), (19, 38, 'B'), (20, 34, 'C'), (21, 11, 'A'), (22, NULL, 'C'), (23, 19, 'B'), (24, 1, 'C'), (25, 32, 'default1'), (26, 24, 'A'), (27, 39, NULL), (28, 4, 'default2'), (29, 13, NULL), (30, 5, 'C'), (31, 15, 'default2'), (32, 20, 'default1'), (33, 33, 'default1'), (34, 40, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH A AS (SELECT CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) AS BUYA, SUM(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) AS BUYB, SUM(CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) AS BUYC FROM ORDERS GROUP BY CUSTOMER_ID HAVING BUYA > 0 AND BUYB > 0 AND BUYC = 0) SELECT * FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM A) ORDER BY CUSTOMER_ID;

/*
Prediction Result:
(24, 'B')
(38, 'default2')
(40, 'B')
*/