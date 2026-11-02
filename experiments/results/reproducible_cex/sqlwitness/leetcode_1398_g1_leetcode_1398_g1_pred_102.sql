-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'B'), (1, NULL), (-1, NULL), (2, 'C'), (3, NULL), (4, 'default1'), (5, 'A'), (6, 'A'), (7, 'A'), (8, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 7, 'default2'), (-1, 5, 'B'), (1, 5, 'C'), (2, 0, 'B'), (3, 4, NULL), (4, 8, 'B'), (5, -1, NULL), (6, 6, 'A'), (7, 4, 'C'), (8, -1, 'C'), (9, -1, NULL), (10, 2, 'default1'), (11, -1, 'B'), (12, NULL, 'C'), (13, 6, 'default2'), (14, 0, 'B'), (15, -1, 'C'), (16, 8, 'B'), (17, 1, 'B'), (18, 0, 'B'), (19, 8, 'default2'), (20, 3, 'B'), (21, 3, 'default1'), (22, 1, 'default2'), (23, 8, NULL), (24, 8, 'A'), (25, 1, 'A'), (26, NULL, NULL), (27, 7, 'C'), (28, NULL, 'B'), (29, 8, 'A'), (30, NULL, 'default2'), (31, 0, 'default1'), (32, 4, NULL), (33, 1, 'B'), (34, 8, NULL), (35, 7, NULL), (36, 0, 'A'), (37, 3, 'default2'), (38, 0, 'A'), (39, 8, NULL), (40, NULL, 'default2'), (41, 5, NULL), (42, 1, 'B'), (43, 4, 'default1'), (44, 4, 'default1'), (45, -1, 'C'), (46, 0, 'A'), (47, 2, 'B'), (48, NULL, NULL), (49, 4, 'B'), (50, 0, 'C'), (51, 0, 'B'), (52, 6, 'C'), (53, 8, 'default1'), (54, NULL, 'A'), (55, 4, NULL), (56, 6, 'B'), (57, 1, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, None)
(8, 'C')
*/

-- Prediction Query
SELECT A.CUSTOMER_ID, A.CUSTOMER_NAME FROM CUSTOMERS AS A JOIN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME IN ('A')) AS AB ON A.CUSTOMER_ID = AB.CUSTOMER_ID JOIN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME IN ('B')) AS AB2 ON A.CUSTOMER_ID = AB2.CUSTOMER_ID LEFT JOIN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') AS C ON AB.CUSTOMER_ID = C.CUSTOMER_ID WHERE C.CUSTOMER_ID IS NULL;

/*
Prediction Result:
(8, 'C')
(1, None)
*/