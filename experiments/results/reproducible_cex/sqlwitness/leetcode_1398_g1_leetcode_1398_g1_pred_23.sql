-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, NULL), (0, 'B'), (1, NULL), (2, 'default1'), (3, 'C'), (4, 'default2'), (5, 'default1'), (6, 'B'), (7, 'default2'), (8, 'B'), (9, NULL), (10, 'B'), (11, 'default2'), (12, 'B'), (13, 'A'), (14, 'A'), (15, NULL), (16, 'default1'), (17, NULL), (18, 'C'), (19, 'A'), (20, 'default2'), (21, 'B'), (22, 'default2'), (23, 'default2'), (24, 'A'), (25, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 25, 'default2'), (2, 7, 'A'), (1, 22, 'C'), (-1, 16, NULL), (3, 4, NULL), (4, 12, 'default1'), (5, 1, 'B'), (6, 13, NULL), (7, 17, 'C'), (8, 23, NULL), (9, 9, 'B'), (10, 21, 'C'), (11, NULL, NULL), (12, 7, 'default2'), (13, 19, NULL), (14, 12, 'default2'), (15, 17, 'default2'), (16, 2, 'default1'), (17, 0, 'default2'), (18, 2, 'A'), (19, 2, 'B'), (20, 18, 'default2'), (21, 5, 'C'), (22, 25, NULL), (23, 10, 'default2'), (24, 0, 'B'), (25, 13, 'default2'), (26, 9, 'A'), (27, 10, 'default2'), (28, 8, 'A'), (29, 9, NULL), (30, 9, 'C'), (31, 6, 'default1'), (32, 7, 'B'), (33, 20, 'C'), (34, 1, 'B'), (35, 12, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(2, 'default1')
(7, 'default2')
*/

-- Prediction Query
SELECT ORDERS.CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS LEFT JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = ORDERS.CUSTOMER_ID WHERE PRODUCT_NAME = 'A' AND ORDERS.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT ORDERS.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(7, 'default2')
(2, 'default1')
*/