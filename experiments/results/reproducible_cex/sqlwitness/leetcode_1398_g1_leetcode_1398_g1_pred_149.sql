-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, NULL), (-1, 'C'), (2, 'C'), (1, 'A'), (3, 'A'), (4, 'C'), (5, 'default2'), (6, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 3, 'default2'), (1, 0, NULL), (-1, 6, 'default1'), (2, 5, 'A'), (3, 1, 'default1'), (4, NULL, 'A'), (5, NULL, 'C'), (6, 3, 'default1'), (7, 0, 'B'), (8, 3, 'B'), (9, 5, 'B'), (10, 5, 'default2'), (11, 6, 'C'), (12, 1, NULL), (13, 3, 'default1'), (14, 5, NULL), (15, 3, 'default2'), (16, -1, NULL), (17, 4, 'B'), (18, -1, NULL), (19, -1, NULL), (20, 4, NULL), (21, NULL, NULL), (22, 1, NULL), (23, 5, 'B'), (24, 0, 'A'), (25, 4, 'C'), (26, 1, NULL), (27, 2, 'C'), (28, 1, 'B'), (29, 0, 'default2'), (30, 0, 'default2'), (31, 3, NULL), (32, 6, 'C'), (33, 6, NULL), (34, NULL, 'default2'), (35, 2, 'A'), (36, NULL, 'B'), (37, 3, 'B'), (38, 5, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(0, None)
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Prediction Result:
*/