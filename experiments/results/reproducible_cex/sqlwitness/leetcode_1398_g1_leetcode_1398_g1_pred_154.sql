-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, NULL), (-1, 'A'), (1, 'C'), (2, 'default1'), (3, 'default1'), (4, 'C'), (5, 'A'), (6, 'A'), (7, 'A'), (8, 'default1'), (9, 'default1'), (10, 'default1'), (11, 'default1'), (12, 'B'), (13, 'default2'), (14, 'A'), (15, 'B'), (16, NULL), (17, 'B'), (18, 'B'), (19, 'default2'), (20, NULL), (21, NULL), (22, 'A'), (23, 'default2'), (24, 'B'), (25, 'C'), (26, 'default2'), (27, 'default2'), (28, NULL), (29, 'default2'), (30, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 29, 'C'), (0, 18, 'default1'), (2, 8, 'C'), (1, 5, 'default2'), (3, 16, 'A'), (4, 2, NULL), (5, 6, 'A'), (6, 4, 'C'), (7, 8, 'default2'), (8, 27, 'default1'), (9, 16, 'default2'), (10, -1, 'default1'), (11, 30, 'A'), (12, 2, 'default1'), (13, 14, 'default1'), (14, 10, 'default2'), (15, 30, 'default1'), (16, 1, 'A'), (17, 28, 'default1'), (18, 9, 'default2'), (19, 28, 'A'), (20, 29, 'B'), (21, 14, NULL), (22, 11, 'B'), (23, 28, 'default1'), (24, 12, NULL), (25, 28, 'default2'), (26, 12, 'A'), (27, 1, 'B'), (28, 1, 'A'), (29, NULL, 'default2'), (30, 11, 'C'), (31, 28, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'C')
*/

-- Prediction Query
SELECT CUSTOMERS.CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS INNER JOIN ORDERS ON CUSTOMERS.CUSTOMER_ID = ORDERS.CUSTOMER_ID WHERE PRODUCT_NAME = 'A' AND CUSTOMERS.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMERS.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(1, 'C')
(1, 'C')
*/