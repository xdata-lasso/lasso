-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, NULL), (2, 'A'), (-1, 'default1'), (1, 'B'), (3, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 3, 'default1'), (-1, NULL, NULL), (0, -1, 'A'), (2, 1, 'C'), (3, -1, 'B'), (4, 0, 'B'), (5, 3, 'default1'), (6, -1, 'A'), (7, 1, NULL), (8, NULL, 'B'), (9, -1, 'default2'), (10, 2, 'B'), (11, NULL, 'B'), (12, 3, 'default1'), (13, 3, 'B'), (14, 3, 'B'), (15, 2, 'default1'), (16, 0, 'A'), (17, NULL, 'A'), (18, 1, NULL), (19, 0, NULL), (20, NULL, 'default1'), (21, -1, 'default1'), (22, 3, NULL), (23, NULL, NULL), (24, NULL, 'B'), (25, 0, NULL), (26, -1, 'default2'), (27, 1, 'default1'), (28, NULL, 'C'), (29, 0, 'default1'), (30, 3, NULL), (31, 3, 'default2'), (32, 1, 'A'), (33, 2, 'B'), (34, 0, 'default1'), (35, 2, 'C'), (36, -1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0;

/*
Prediction Result:
(-1, 'default1')
(0, None)
*/