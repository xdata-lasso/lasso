-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default1'), (-1, 'default1'), (2, 'default1'), (1, 'default2'), (3, 'B'), (4, 'A'), (5, NULL), (6, 'C'), (7, 'C'), (8, 'default1'), (9, NULL), (10, 'A'), (11, 'A'), (12, 'A'), (13, 'C'), (14, 'A'), (15, 'C'), (16, 'default2'), (17, 'B'), (18, NULL), (19, 'C'), (20, 'default2'), (21, 'A'), (22, 'B'), (23, 'C'), (24, 'default1'), (25, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 15, 'default1'), (2, 11, 'B'), (0, NULL, NULL), (-1, 0, NULL), (3, 25, 'B'), (4, 0, 'A'), (5, 3, 'C'), (6, 15, 'A'), (7, 20, 'default2'), (8, 16, NULL), (9, NULL, 'A'), (10, 9, 'default2'), (11, NULL, 'C'), (12, 1, 'B'), (13, 8, NULL), (14, 14, 'default1'), (15, NULL, NULL), (16, 16, 'default1'), (17, 2, 'B'), (18, 16, 'default1'), (19, 22, 'default2'), (20, 4, 'B'), (21, 1, 'default2'), (22, 24, 'A'), (23, 22, NULL), (24, 12, 'C'), (25, 24, NULL), (26, 11, 'C'), (27, 15, 'B'), (28, 23, NULL), (29, 9, NULL), (30, 1, 'default2'), (31, 4, 'B'), (32, 0, 'default1'), (33, 0, 'C'), (34, 5, 'default1'), (35, 20, 'default2'), (36, 21, 'A'), (37, 12, 'B'), (38, 7, 'default2'), (39, 1, 'default2'), (40, 15, 'B'), (41, 9, 'default2'), (42, 21, 'B'), (43, 5, 'C'), (44, 22, 'A'), (45, 0, 'default2'), (46, 20, 'B'), (47, 17, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(15, 'C')
(21, 'A')
*/

-- Prediction Query
WITH BOUGHT_A AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A'), BOUGHT_B AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B'), BOUGHT_C AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') SELECT BOUGHT_A.CUSTOMER_ID, CUSTOMERS.CUSTOMER_NAME FROM BOUGHT_A INNER JOIN BOUGHT_B USING (CUSTOMER_ID) INNER JOIN CUSTOMERS USING (CUSTOMER_ID) WHERE NOT BOUGHT_A.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM BOUGHT_C);

/*
Prediction Result:
*/