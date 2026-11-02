-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'C'), (1, 'C'), (2, 'B'), (0, 'B'), (3, NULL), (4, 'C'), (5, 'B'), (6, NULL), (7, 'default1'), (8, 'A'), (9, 'default1'), (10, 'B'), (11, 'B'), (12, 'default2'), (13, NULL), (14, 'A'), (15, 'A'), (16, NULL), (17, 'B'), (18, 'default2'), (19, 'C'), (20, 'B'), (21, 'C'), (22, NULL), (23, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 10, 'C'), (0, 8, 'default2'), (-1, 1, 'B'), (2, 14, 'default1'), (3, 6, 'default1'), (4, 0, 'A'), (5, 23, 'default2'), (6, NULL, NULL), (7, 17, 'B'), (8, 22, 'default2'), (9, 5, 'B'), (10, 15, 'C'), (11, 2, 'B'), (12, 6, 'A'), (13, 19, 'A'), (14, 5, 'default1'), (15, NULL, 'default1'), (16, 5, 'default2'), (17, 12, 'default1'), (18, 20, 'default2'), (19, 16, 'B'), (20, 21, 'default1'), (21, 17, 'default1'), (22, 2, 'A'), (23, 16, 'A'), (24, 14, 'A'), (25, 0, 'default1'), (26, 15, 'B'), (27, 3, 'A'), (28, 16, 'default2'), (29, 22, 'default1'), (30, 18, NULL), (31, NULL, 'C'), (32, 21, 'B'), (33, 16, 'A'), (34, 20, NULL), (35, 21, 'C'), (36, 21, 'A'), (37, 8, 'C'), (38, 17, NULL), (39, 14, 'B'), (40, 2, NULL), (41, 15, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(2, 'B')
(14, 'A')
(16, None)
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY 1, CUSTOMERS.customer_id NULLS LAST;

/*
Prediction Result:
*/