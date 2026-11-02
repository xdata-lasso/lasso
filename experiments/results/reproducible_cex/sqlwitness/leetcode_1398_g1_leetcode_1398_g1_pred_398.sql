-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'B'), (1, 'B'), (0, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 2, 'B'), (0, 2, 'C'), (-1, 0, 'default2'), (2, 1, NULL), (3, NULL, 'C'), (4, 1, 'B'), (5, 0, NULL), (6, 2, 'B'), (7, 2, 'A'), (8, 2, 'A'), (9, 0, 'C'), (10, 2, NULL), (11, 1, NULL), (12, 2, 'default1'), (13, NULL, 'C'), (14, 0, 'A'), (15, NULL, 'default2'), (16, 0, NULL), (17, 2, NULL), (18, 1, 'A'), (19, 0, 'default2'), (20, 1, 'default1'), (21, 0, 'default1'), (22, 1, 'A'), (23, NULL, NULL), (24, NULL, 'C'), (25, NULL, 'B'), (26, 0, 'A'), (27, NULL, 'C'), (28, 2, 'default1'), (29, 1, 'A'), (30, 0, 'default1'), (31, 1, 'default2'), (32, NULL, NULL), (33, 2, 'C'), (34, 1, 'default2'), (35, NULL, 'default2'), (36, 2, 'A'), (37, NULL, 'default1'), (38, 1, 'A'), (39, 1, 'B'), (40, 0, 'default1'), (41, 2, 'B'), (42, 0, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'B')
*/

-- Prediction Query
WITH T1 AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B' AND CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A')), T2 AS (SELECT DISTINCT T1.CUSTOMER_ID, PRODUCT_NAME FROM T1 JOIN ORDERS ON ORDERS.CUSTOMER_ID = T1.CUSTOMER_ID AND PRODUCT_NAME = 'C') SELECT T1.CUSTOMER_ID, CUSTOMER_NAME FROM T1 JOIN CUSTOMERS ON T1.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID WHERE NOT T1.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM T2) ORDER BY T1.CUSTOMER_ID, CUSTOMERS.customer_id NULLS LAST;

/*
Prediction Result:
(1, 'B')
(1, 'B')
*/