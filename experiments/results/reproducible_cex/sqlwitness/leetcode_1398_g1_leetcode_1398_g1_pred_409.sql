-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'C'), (0, 'default1'), (-1, 'C'), (1, 'default2'), (3, 'default1'), (4, 'A'), (5, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 4, 'default1'), (1, 4, 'default1'), (0, 0, 'default2'), (2, 2, 'C'), (3, NULL, 'default1'), (4, 0, 'default1'), (5, 4, 'default2'), (6, 5, 'C'), (7, 2, NULL), (8, 4, 'B'), (9, 2, 'A'), (10, -1, 'default1'), (11, 1, 'default1'), (12, 5, NULL), (13, 3, 'C'), (14, NULL, 'default1'), (15, 5, 'C'), (16, 2, 'A'), (17, 5, NULL), (18, 2, 'default1'), (19, NULL, 'C'), (20, 1, NULL), (21, 2, 'C'), (22, 3, 'C'), (23, NULL, 'default1'), (24, 2, 'default2'), (25, 0, 'B'), (26, NULL, 'A'), (27, 5, 'A'), (28, 2, 'C'), (29, 3, 'default1'), (30, 3, NULL), (31, 5, 'C'), (32, 5, 'C'), (33, 1, 'C'), (34, 5, 'C'), (35, 1, 'A'), (36, 4, 'B'), (37, 3, NULL), (38, 4, 'A'), (39, 1, 'default2'), (40, 2, 'C'), (41, 0, NULL), (42, 5, 'B'), (43, 5, 'default1'), (44, NULL, 'B'), (45, 4, 'B'), (46, 3, NULL), (47, 1, 'A'), (48, 1, 'default2'), (49, 2, NULL), (50, 2, 'A'), (51, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(4, 'A')
*/

-- Prediction Query
WITH CTE AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C'), CTE1 AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A' AND CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B')) SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM CTE1) AND NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM CTE);

/*
Prediction Result:
*/