-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'B'), (1, 'default2'), (-1, NULL), (0, 'C'), (3, NULL), (4, 'default2'), (5, 'default2'), (6, 'default2'), (7, 'default2'), (8, 'default2'), (9, NULL), (10, 'default2'), (11, 'C'), (12, 'B'), (13, 'default1'), (14, 'default2'), (15, 'default2'), (16, 'default1'), (17, 'default2'), (18, 'B'), (19, NULL), (20, 'C'), (21, 'A'), (22, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 5, 'C'), (0, 2, 'default1'), (2, NULL, 'default1'), (1, 5, 'A'), (3, 7, 'default1'), (4, 4, 'B'), (5, 16, 'A'), (6, 0, 'default2'), (7, 7, NULL), (8, -1, NULL), (9, 15, 'B'), (10, 14, 'C'), (11, 16, 'B'), (12, -1, NULL), (13, 8, NULL), (14, 4, 'A'), (15, 18, 'A'), (16, 10, 'default2'), (17, NULL, 'C'), (18, 5, 'default2'), (19, 13, NULL), (20, 15, 'default1'), (21, 17, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(4, 'default2')
(16, 'default1')
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C WHERE NOT C.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME IN ('C')) AND C.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME IN ('B') AND CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME IN ('A')));

/*
Prediction Result:
*/