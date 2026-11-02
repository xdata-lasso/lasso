-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default1'), (2, 'A'), (-1, 'A'), (1, 'A'), (3, 'B'), (4, 'default1'), (5, 'default2'), (6, NULL), (7, 'C'), (8, 'default2'), (9, 'C'), (10, 'default2'), (11, 'A'), (12, 'default2'), (13, 'A'), (14, NULL), (15, 'A'), (16, 'A'), (17, 'B'), (18, 'default2'), (19, 'default1'), (20, 'default1'), (21, 'B'), (22, NULL), (23, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 2, 'C'), (1, 10, 'default1'), (2, 0, 'default2'), (-1, -1, 'default1'), (3, 21, 'C'), (4, 3, 'default1'), (5, 17, 'default2'), (6, 15, 'C'), (7, 6, 'A'), (8, 12, 'default2'), (9, 3, 'B'), (10, 11, 'default2'), (11, 20, 'A'), (12, NULL, 'B'), (13, 10, 'A'), (14, 15, 'default1'), (15, 1, NULL), (16, 21, 'A'), (17, 6, NULL), (18, 13, 'default2'), (19, 19, 'default1'), (20, 5, 'B'), (21, 20, 'B'), (22, NULL, 'default1'), (23, 7, 'default1'), (24, 19, 'default2'), (25, 10, 'B'), (26, 16, 'C'), (27, 15, NULL), (28, 0, 'default2'), (29, -1, 'default1'), (30, 2, 'C'), (31, 5, NULL), (32, 10, 'A'), (33, 8, 'C'), (34, 16, NULL), (35, 2, NULL), (36, 7, 'A'), (37, 8, 'B'), (38, 3, NULL), (39, 2, 'C'), (40, 9, NULL), (41, 5, 'default1'), (42, 0, 'B'), (43, 12, 'C'), (44, 2, 'A'), (45, 18, 'default2'), (46, 6, NULL), (47, -1, 'default1'), (48, 15, 'B'), (49, 20, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(10, 'default2')
(20, 'default1')
*/

-- Prediction Query
WITH A AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A'), B AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B'), C AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') SELECT A.CUSTOMER_ID, T.CUSTOMER_NAME FROM A AS A JOIN B AS B USING (CUSTOMER_ID) JOIN CUSTOMERS AS T USING (CUSTOMER_ID) LEFT JOIN C AS C ON A.CUSTOMER_ID = C.CUSTOMER_ID WHERE C.CUSTOMER_ID IS NULL;

/*
Prediction Result:
(20, 'default1')
(10, 'default2')
*/