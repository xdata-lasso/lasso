-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default1'), (2, 'C'), (-1, 'B'), (1, 'default2'), (3, 'C'), (4, NULL), (5, 'default2'), (6, 'B'), (7, 'A'), (8, 'C'), (9, NULL), (10, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 4, 'C'), (1, 7, NULL), (2, 2, NULL), (-1, -1, 'default1'), (3, NULL, 'A'), (4, -1, NULL), (5, 7, 'default2'), (6, 5, 'B'), (7, 10, 'C'), (8, 5, 'B'), (9, 2, 'default2'), (10, 5, NULL), (11, 10, 'default1'), (12, 2, 'A'), (13, NULL, NULL), (14, 7, 'A'), (15, 8, 'default2'), (16, 4, 'B'), (17, 7, 'C'), (18, -1, NULL), (19, 7, 'C'), (20, -1, 'default2'), (21, 9, NULL), (22, NULL, 'default2'), (23, 5, 'C'), (24, 5, 'A'), (25, 8, 'B'), (26, 7, NULL), (27, NULL, 'C'), (28, 5, NULL), (29, 2, 'A'), (30, 8, 'default2'), (31, NULL, 'C'), (32, 8, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(8, 'C')
*/

-- Prediction Query
SELECT DISTINCT U.CUSTOMER_ID, U.CUSTOMER_NAME FROM (SELECT C.CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS AS O JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID WHERE PRODUCT_NAME = 'A') AS U JOIN (SELECT C.CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS AS O JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID WHERE PRODUCT_NAME = 'B') AS T ON T.CUSTOMER_ID = U.CUSTOMER_ID WHERE NOT U.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
*/