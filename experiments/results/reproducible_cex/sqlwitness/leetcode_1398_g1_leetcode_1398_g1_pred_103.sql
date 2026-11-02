-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default2'), (1, 'default2'), (2, 'B'), (-1, 'A'), (3, 'B'), (4, 'C'), (5, 'B'), (6, 'default1'), (7, NULL), (8, NULL), (9, 'C'), (10, 'A'), (11, 'A'), (12, 'C'), (13, 'default1'), (14, 'A'), (15, 'C'), (16, NULL), (17, 'default1'), (18, 'default2'), (19, 'B'), (20, 'A'), (21, 'A'), (22, 'B'), (23, NULL), (24, NULL), (25, NULL), (26, 'C'), (27, 'B'), (28, 'default2'), (29, 'default1'), (30, 'default1'), (31, 'default2'), (32, 'A'), (33, 'C'), (34, 'B'), (35, 'A'), (36, NULL), (37, 'C'), (38, 'B'), (39, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 38, 'default1'), (0, 4, NULL), (2, -1, 'default2'), (-1, 26, 'C'), (3, 27, 'default2'), (4, -1, 'default2'), (5, 6, 'A'), (6, 19, 'A'), (7, 29, 'B'), (8, 18, 'C'), (9, 39, 'default2'), (10, 17, NULL), (11, 13, 'default1'), (12, 3, 'B'), (13, 0, 'default1'), (14, 26, 'default1'), (15, 20, 'A'), (16, 8, 'default1'), (17, 10, 'A'), (18, 13, 'default1'), (19, 14, 'default2'), (20, 34, 'default2'), (21, 32, 'C'), (22, 9, 'B'), (23, 20, 'C'), (24, NULL, 'A'), (25, 23, 'B'), (26, 16, 'A'), (27, 23, 'A'), (28, 26, 'default2'), (29, 17, 'B'), (30, 3, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(3, 'B')
(23, None)
*/

-- Prediction Query
SELECT A.CUSTOMER_ID, CUSTOMERS.CUSTOMER_NAME FROM (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AS A JOIN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID LEFT JOIN CUSTOMERS ON A.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID WHERE NOT A.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(23, None)
(3, 'B')
*/