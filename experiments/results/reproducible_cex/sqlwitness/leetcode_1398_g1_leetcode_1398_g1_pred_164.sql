-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, NULL), (1, 'default2'), (0, 'A'), (-1, 'C'), (3, 'C'), (4, 'B'), (5, 'A'), (6, 'B'), (7, 'B'), (8, 'default2'), (9, 'B'), (10, NULL), (11, 'C'), (12, 'C'), (13, 'B'), (14, 'C'), (15, 'default1'), (16, 'B'), (17, 'default1'), (18, 'default1'), (19, NULL), (20, 'C'), (21, 'default1'), (22, 'C'), (23, 'default1'), (24, NULL), (25, 'A'), (26, 'default1'), (27, NULL), (28, 'A'), (29, 'B'), (30, NULL), (31, NULL), (32, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 17, 'default1'), (-1, 11, 'default2'), (0, 24, 'A'), (1, 27, NULL), (3, 26, NULL), (4, 19, 'A'), (5, 19, 'A'), (6, 21, 'default2'), (7, 20, NULL), (8, 4, 'default2'), (9, 18, 'default1'), (10, 24, 'B'), (11, 0, 'default2'), (12, 32, 'A'), (13, 27, 'default2'), (14, NULL, 'C'), (15, 17, 'B'), (16, 11, 'C'), (17, 16, 'default2'), (18, 32, 'A'), (19, 17, 'default1'), (20, 22, NULL), (21, NULL, NULL), (22, 2, 'default2'), (23, -1, 'default1'), (24, 13, 'default1'), (25, 12, 'B'), (26, 5, 'C'), (27, -1, 'default2'), (28, 26, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(24, None)
*/

-- Prediction Query
SELECT DISTINCT O.CUSTOMER_ID, C.CUSTOMER_NAME FROM ORDERS AS O JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE O.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND O.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT O.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
*/