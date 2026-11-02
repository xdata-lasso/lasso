-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'A'), (2, 'B'), (1, 'B'), (-1, 'default2'), (3, 'A'), (4, 'default1'), (5, 'B'), (6, 'default2'), (7, 'default2'), (8, 'A'), (9, NULL), (10, 'default2'), (11, 'C'), (12, 'C'), (13, 'default2'), (14, 'C'), (15, 'A'), (16, 'B'), (17, 'default1'), (18, 'B'), (19, NULL), (20, 'A'), (21, 'C'), (22, 'default1'), (23, 'A'), (24, 'default2'), (25, 'B'), (26, 'C'), (27, NULL), (28, NULL), (29, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 20, 'default2'), (1, 9, 'C'), (-1, 8, 'A'), (0, 21, NULL), (3, 8, 'C'), (4, 27, NULL), (5, 13, NULL), (6, 5, 'default2'), (7, 28, 'default2'), (8, 14, 'default2'), (9, 16, NULL), (10, 13, 'default2'), (11, 10, 'B'), (12, -1, 'default1'), (13, 2, NULL), (14, 10, 'A'), (15, 14, 'default2'), (16, 11, 'default1'), (17, 8, 'default1'), (18, -1, 'B'), (19, 2, 'B'), (20, 16, 'default1'), (21, 28, 'B'), (22, 28, 'B'), (23, 4, 'B'), (24, 0, NULL), (25, 13, 'B'), (26, 16, 'default1'), (27, 11, 'C'), (28, 19, 'default1'), (29, 24, 'default1'), (30, 0, 'default1'), (31, -1, 'A'), (32, 25, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(-1, 'default2')
(10, 'default2')
*/

-- Prediction Query
WITH A AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A'), B AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') SELECT CUSTOMERS.CUSTOMER_ID, CUSTOMERS.CUSTOMER_NAME FROM A CROSS JOIN B CROSS JOIN CUSTOMERS WHERE A.CUSTOMER_ID = B.CUSTOMER_ID AND A.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID AND NOT CUSTOMERS.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(10, 'default2')
(-1, 'default2')
*/