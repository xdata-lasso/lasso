-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'B'), (0, 'A'), (-1, 'C'), (1, 'A'), (3, 'default1'), (4, 'default1'), (5, 'default1'), (6, 'C'), (7, 'C'), (8, 'A'), (9, 'B'), (10, 'default2'), (11, 'A'), (12, NULL), (13, 'C'), (14, 'default1'), (15, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 6, 'B'), (2, 13, 'B'), (0, 15, 'default1'), (1, 6, 'C'), (3, 13, 'A'), (4, 14, 'default2'), (5, 15, 'default1'), (6, 4, 'default2'), (7, 0, 'B'), (8, 3, 'B'), (9, 5, NULL), (10, 4, 'C'), (11, 8, 'default2'), (12, 10, 'default2'), (13, 2, 'B'), (14, 8, 'C'), (15, 0, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(0, 'A')
(13, 'C')
*/

-- Prediction Query
SELECT DISTINCT (O.CUSTOMER_ID), C.CUSTOMER_NAME FROM ORDERS AS O JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID WHERE O.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND O.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT O.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(13, 'C')
(0, 'A')
*/