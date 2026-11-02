-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'default2'), (1, NULL), (-1, NULL), (0, 'A'), (3, 'B'), (4, 'A'), (5, NULL), (6, NULL), (7, 'default2'), (8, NULL), (9, 'default1'), (10, 'B'), (11, 'default1'), (12, 'default1'), (13, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 13, 'A'), (1, 11, 'B'), (0, 3, 'default1'), (-1, 11, 'default1'), (3, NULL, 'C'), (4, NULL, 'C'), (5, 9, 'default2'), (6, NULL, NULL), (7, 0, 'A'), (8, 10, 'C'), (9, 6, 'default1'), (10, 12, 'B'), (11, 12, 'B'), (12, 12, NULL), (13, 8, 'B'), (14, 1, 'default1'), (15, 7, 'C'), (16, 7, 'B'), (17, 6, 'default2'), (18, 3, 'B'), (19, 8, 'C'), (20, 11, 'B'), (21, 13, 'default2'), (22, 13, 'B'), (23, 2, 'default2'), (24, 7, NULL), (25, 5, 'default1'), (26, 2, 'default2'), (27, 6, 'default2'), (28, 6, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(13, 'C')
*/

-- Prediction Query
WITH T AS (SELECT CUSTOMER_ID FROM ORDERS AS O WHERE PRODUCT_NAME = 'B' AND CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C')) SELECT T.CUSTOMER_ID, C.CUSTOMER_NAME FROM T JOIN CUSTOMERS AS C ON T.CUSTOMER_ID = C.CUSTOMER_ID;

/*
Prediction Result:
*/