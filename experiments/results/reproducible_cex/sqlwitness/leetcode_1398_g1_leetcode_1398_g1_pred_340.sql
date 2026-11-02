-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'C'), (1, 'A'), (0, 'C'), (2, 'A'), (3, 'A'), (4, 'C'), (5, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, -1, 'C'), (-1, 1, 'B'), (0, 4, 'A'), (2, 1, 'default1'), (3, 3, NULL), (4, 1, 'default2'), (5, 4, 'default2'), (6, 2, NULL), (7, NULL, 'C'), (8, 2, 'default1'), (9, -1, 'C'), (10, NULL, 'default2'), (11, 1, 'C'), (12, 3, NULL), (13, 2, 'default2'), (14, NULL, 'default1'), (15, 4, 'default1'), (16, -1, 'A'), (17, 2, 'C'), (18, 5, NULL), (19, 5, 'B'), (20, 3, 'A'), (21, 5, 'B'), (22, 0, 'default2'), (23, 1, 'default2'), (24, -1, 'C'), (25, 4, 'A'), (26, 5, 'A'), (27, NULL, 'default2'), (28, 0, 'C'), (29, 5, 'default2'), (30, 4, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(4, 'C')
(5, 'A')
*/

-- Prediction Query
SELECT DISTINCT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE C.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND O.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT O.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
*/