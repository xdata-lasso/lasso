-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'C'), (2, 'C'), (0, 'default2'), (1, 'B'), (3, 'A'), (4, 'default2'), (5, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 1, 'default1'), (2, -1, 'default2'), (0, NULL, 'default2'), (1, 2, NULL), (3, NULL, 'B'), (4, 2, 'B'), (5, -1, 'C'), (6, 4, NULL), (7, 1, NULL), (8, -1, 'default2'), (9, 5, NULL), (10, 5, 'A'), (11, 5, NULL), (12, 3, NULL), (13, 5, 'B'), (14, -1, 'default1'), (15, 0, 'A'), (16, 2, 'default2'), (17, 2, 'default2'), (18, 0, 'C'), (19, 0, 'B'), (20, 1, 'B'), (21, 2, 'C'), (22, -1, 'default2'), (23, 1, 'default2'), (24, 3, 'A'), (25, 3, NULL), (26, NULL, NULL), (27, 4, NULL), (28, 1, 'B'), (29, NULL, 'default2'), (30, 1, 'default2'), (31, 5, NULL), (32, 1, 'A'), (33, 4, NULL), (34, 0, 'default1'), (35, NULL, 'default2'), (36, NULL, 'C'), (37, 0, 'default1'), (38, 4, NULL), (39, 1, 'default2'), (40, 1, NULL), (41, 4, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'B')
(5, 'A')
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') AND CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS GROUP BY CUSTOMER_ID HAVING SUM(PRODUCT_NAME = 'A') > 0 AND SUM(PRODUCT_NAME = 'B') > 0) ORDER BY CUSTOMER_ID;

/*
Prediction Result:
*/