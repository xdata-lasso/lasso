-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'default2'), (0, 'default1'), (1, 'default1'), (-1, 'default1'), (3, 'A'), (4, 'A'), (5, 'C'), (6, 'B'), (7, 'B'), (8, 'default2'), (9, 'default1'), (10, 'A'), (11, NULL), (12, 'C'), (13, 'default1'), (14, 'default2'), (15, NULL), (16, 'B'), (17, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, NULL, 'C'), (1, 13, NULL), (-1, 3, 'B'), (2, 10, 'default1'), (3, 11, 'C'), (4, 0, 'default2'), (5, 1, 'C'), (6, 10, 'A'), (7, 7, 'default2'), (8, 0, 'B'), (9, 3, 'default2'), (10, 6, NULL), (11, 2, 'B'), (12, 1, NULL), (13, 14, 'C'), (14, 16, 'default1'), (15, 3, 'default2'), (16, 15, 'A'), (17, 2, 'A'), (18, 7, 'A'), (19, 9, 'B'), (20, 1, 'C'), (21, 15, 'C'), (22, 6, 'default2'), (23, 2, 'A'), (24, 7, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(2, 'default2')
*/

-- Prediction Query
WITH A AS (SELECT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS WHERE PRODUCT_NAME = 'A' GROUP BY CUSTOMER_ID), B AS (SELECT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS WHERE PRODUCT_NAME = 'B' GROUP BY CUSTOMER_ID), T AS (SELECT A.CUSTOMER_ID, A.PRODUCT_NAME FROM A JOIN B ON A.CUSTOMER_ID = B.CUSTOMER_ID WHERE NOT A.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C')) SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C JOIN T ON C.CUSTOMER_ID = T.CUSTOMER_ID;

/*
Prediction Result:
*/