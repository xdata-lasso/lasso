-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'default1'), (2, 'A'), (0, 'C'), (-1, 'default2'), (3, 'A'), (4, 'C'), (5, 'A'), (6, 'A'), (7, 'A'), (8, NULL), (9, 'default1'), (10, 'default1'), (11, NULL), (12, 'default2'), (13, 'B'), (14, 'B'), (15, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 1, 'default1'), (0, 7, 'default2'), (-1, 9, 'A'), (2, NULL, 'default1'), (3, 12, 'default1'), (4, 1, 'B'), (5, NULL, NULL), (6, 10, 'default2'), (7, 13, NULL), (8, 8, 'default2'), (9, 9, 'A'), (10, 7, NULL), (11, 11, 'default1'), (12, 15, 'A'), (13, 12, 'C'), (14, 14, 'default1'), (15, 13, 'B'), (16, 9, 'default2'), (17, 13, 'C'), (18, 1, 'B'), (19, 14, 'C'), (20, 8, 'default2'), (21, 15, 'C'), (22, 2, 'B'), (23, 7, 'B'), (24, 1, 'A'), (25, -1, 'B'), (26, 7, 'A'), (27, 2, 'A'), (28, 0, NULL), (29, 12, 'C'), (30, 0, 'default1'), (31, -1, 'default2'), (32, 10, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'default1')
(2, 'A')
(7, 'A')
*/

-- Prediction Query
SELECT DISTINCT ORDERS.CUSTOMER_ID, CUSTOMERS.CUSTOMER_NAME FROM ORDERS INNER JOIN CUSTOMERS ON ORDERS.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID WHERE ORDERS.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND ORDERS.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT ORDERS.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(7, 'A')
(1, 'default1')
(2, 'A')
*/