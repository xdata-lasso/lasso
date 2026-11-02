-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'C'), (1, 'A'), (2, 'B'), (-1, 'default1'), (3, 'C'), (4, 'B'), (5, 'A'), (6, 'default2'), (7, 'C'), (8, 'C'), (9, 'C'), (10, 'B'), (11, NULL), (12, 'B'), (13, 'default1'), (14, 'B'), (15, 'default2'), (16, 'C'), (17, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 9, 'B'), (0, 16, 'A'), (-1, 1, 'default2'), (2, 13, 'A'), (3, 16, NULL), (4, 0, 'B'), (5, NULL, 'default1'), (6, 0, 'A'), (7, 12, 'C'), (8, 3, 'default2'), (9, 15, 'B'), (10, 11, 'default2'), (11, 5, 'A'), (12, 15, 'A'), (13, 16, 'default2'), (14, 16, 'A'), (15, 1, 'default1'), (16, 8, 'default1'), (17, NULL, 'C'), (18, 0, 'B'), (19, 17, 'B'), (20, 6, 'default2'), (21, 12, NULL), (22, 14, 'C'), (23, 12, 'default2'), (24, -1, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM CTE WHERE A > 0 AND B > 0 AND C = 0) ORDER BY CUSTOMER_ID;

/*
Prediction Result:
(0, 'C')
(15, 'default2')
*/