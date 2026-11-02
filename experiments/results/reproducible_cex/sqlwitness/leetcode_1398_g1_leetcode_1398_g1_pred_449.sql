-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'default2'), (-1, 'default2'), (0, NULL), (1, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 0, 'default2'), (0, -1, 'default1'), (1, -1, 'B'), (-1, 1, 'B'), (3, 2, 'C'), (4, 2, 'B'), (5, -1, NULL), (6, 1, NULL), (7, 2, 'B'), (8, 0, 'default1'), (9, NULL, 'C'), (10, 0, NULL), (11, -1, 'A'), (12, -1, 'C'), (13, NULL, NULL), (14, 0, 'C'), (15, 1, 'default2'), (16, 0, 'default1'), (17, NULL, 'A'), (18, 1, 'default2'), (19, 0, 'B'), (20, 2, NULL), (21, -1, 'default1'), (22, -1, 'B'), (23, 1, 'B'), (24, 2, 'A'), (25, -1, 'default2'), (26, 0, 'C'), (27, -1, 'default2'), (28, 1, 'A'), (29, 2, 'default1'), (30, 0, NULL), (31, 0, 'A'), (32, 1, 'default1'), (33, 2, 'A'), (34, 2, 'default1'), (35, -1, NULL), (36, -1, 'A'), (37, 0, NULL), (38, 2, 'default2'), (39, -1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'default2')
*/

-- Prediction Query
SELECT O.CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS AS O JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID WHERE PRODUCT_NAME = 'B' AND O.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND NOT O.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
*/