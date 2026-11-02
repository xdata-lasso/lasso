-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'A'), (1, 'A'), (-1, 'default1'), (2, 'default1'), (3, 'B'), (4, NULL), (5, 'A'), (6, 'C'), (7, 'default1'), (8, 'B'), (9, 'default2'), (10, 'default2'), (11, 'default1'), (12, 'default2'), (13, 'default2'), (14, NULL), (15, 'default2'), (16, 'default2'), (17, 'default1'), (18, 'A'), (19, 'A'), (20, 'A'), (21, 'C'), (22, 'A'), (23, NULL), (24, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 10, 'B'), (2, 15, 'default2'), (0, NULL, 'C'), (1, 16, 'B'), (3, 6, 'A'), (4, 8, 'default1'), (5, 22, 'default2'), (6, 10, 'A'), (7, 16, 'B'), (8, 19, 'B'), (9, 24, 'default1'), (10, 3, NULL), (11, 9, 'A'), (12, 22, 'default2'), (13, -1, 'A'), (14, 13, NULL), (15, 11, 'C'), (16, 16, 'C'), (17, 20, 'B'), (18, 19, 'B'), (19, 15, 'A'), (20, 10, 'A'), (21, 23, 'A'), (22, 14, NULL), (23, 5, 'default1'), (24, 4, 'C'), (25, 7, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(10, 'default2')
*/

-- Prediction Query
SELECT DISTINCT B.CUSTOMER_ID, B.CUSTOMER_NAME FROM ORDERS AS A JOIN CUSTOMERS AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID WHERE NOT A.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') AND A.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND A.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B');

/*
Prediction Result:
*/