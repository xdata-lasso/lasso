-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'default2'), (1, 'default2'), (0, 'default2'), (2, 'B'), (3, 'A'), (4, NULL), (5, 'default1'), (6, NULL), (7, 'A'), (8, 'C'), (9, 'C'), (10, 'default1'), (11, 'B'), (12, 'A'), (13, 'default2'), (14, 'C'), (15, 'default2'), (16, NULL), (17, NULL), (18, 'A'), (19, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, -1, 'A'), (-1, 17, NULL), (2, 19, NULL), (1, 10, 'default2'), (3, 1, 'A'), (4, 12, 'default2'), (5, 16, 'A'), (6, 3, NULL), (7, 7, 'default1'), (8, 2, NULL), (9, 0, 'default1'), (10, 14, NULL), (11, 12, 'B'), (12, 4, 'default1'), (13, 18, 'default1'), (14, 6, 'default2'), (15, 7, 'C'), (16, 10, 'C'), (17, 5, 'B'), (18, 8, 'default2'), (19, 18, 'A'), (20, 5, 'A'), (21, 14, 'A'), (22, NULL, 'C'), (23, 13, NULL), (24, 17, 'A'), (25, 17, NULL), (26, 5, 'A'), (27, 2, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(5, 'default1')
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT T1.CUSTOMER_ID FROM (SELECT CUSTOMER_ID FROM ORDERS AS O WHERE PRODUCT_NAME = 'A') AS T1 CROSS JOIN (SELECT CUSTOMER_ID FROM ORDERS AS O WHERE PRODUCT_NAME = 'B') AS T2 WHERE T1.CUSTOMER_ID = T2.CUSTOMER_ID AND NOT T1.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS AS O WHERE PRODUCT_NAME = 'C'));

/*
Prediction Result:
*/