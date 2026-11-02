-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, NULL), (-1, 'default2'), (2, 'B'), (0, 'default1'), (3, 'C'), (4, 'default2'), (5, 'default2'), (6, 'B'), (7, NULL), (8, 'C'), (9, 'default1'), (10, 'default2'), (11, 'default2'), (12, 'default2'), (13, 'default2'), (14, 'C'), (15, 'B'), (16, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 10, 'C'), (-1, 16, 'A'), (0, 16, 'A'), (1, 11, 'A'), (3, 5, 'default1'), (4, 1, 'A'), (5, NULL, 'C'), (6, 7, 'A'), (7, 8, NULL), (8, 16, NULL), (9, 15, 'A'), (10, 12, 'default2'), (11, 9, 'default1'), (12, 1, 'default2'), (13, 14, 'default2'), (14, 16, 'C'), (15, 1, NULL), (16, 13, 'default2'), (17, 6, 'A'), (18, 10, 'B'), (19, NULL, 'default1'), (20, 2, 'C'), (21, 11, 'default2'), (22, 12, 'default1'), (23, 6, 'B'), (24, 12, 'default1'), (25, 4, 'C'), (26, 0, 'A'), (27, 15, NULL), (28, 9, 'C'), (29, 5, NULL), (30, 11, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(6, 'B')
*/

-- Prediction Query
SELECT * FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
*/