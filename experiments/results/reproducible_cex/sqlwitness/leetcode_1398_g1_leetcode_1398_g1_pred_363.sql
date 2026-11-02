-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'B'), (1, 'A'), (-1, 'C'), (2, 'B'), (3, 'B'), (4, 'A'), (5, 'default1'), (6, 'A'), (7, 'B'), (8, 'default2'), (9, 'C'), (10, 'default1'), (11, NULL), (12, 'A'), (13, 'B'), (14, 'C'), (15, NULL), (16, NULL), (17, NULL), (18, 'B'), (19, 'A'), (20, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 8, 'A'), (2, 15, 'C'), (-1, 8, 'B'), (0, 20, NULL), (3, 17, 'C'), (4, 20, 'A'), (5, 10, NULL), (6, NULL, 'B'), (7, 17, 'C'), (8, 16, 'A'), (9, 7, 'B'), (10, -1, NULL), (11, 4, 'A'), (12, 3, 'default2'), (13, 2, 'C'), (14, 1, 'A'), (15, 16, 'B'), (16, 4, 'B'), (17, 18, NULL), (18, 17, 'default1'), (19, 13, 'A'), (20, -1, 'A'), (21, 0, 'default2'), (22, NULL, 'C'), (23, 16, 'C'), (24, 3, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(4, 'A')
(8, 'default2')
*/

-- Prediction Query
SELECT DISTINCT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE O.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND O.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT O.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
*/