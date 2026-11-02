-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'A'), (2, 'default1'), (1, 'A'), (-1, 'default1'), (3, NULL), (4, 'A'), (5, NULL), (6, 'default1'), (7, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 6, NULL), (-1, 7, 'B'), (1, 3, 'B'), (2, 4, 'default2'), (3, 4, NULL), (4, 1, 'default2'), (5, -1, 'default2'), (6, 1, 'default1'), (7, 6, 'default2'), (8, 4, 'default1'), (9, 3, 'C'), (10, 2, 'default2'), (11, 0, 'A'), (12, 4, 'B'), (13, 0, 'B'), (14, NULL, 'B'), (15, 0, 'A'), (16, 2, 'B'), (17, 3, 'A'), (18, 6, 'B'), (19, 4, 'A'), (20, 6, 'C'), (21, 4, 'default2'), (22, 0, 'default2'), (23, 2, 'A'), (24, 7, 'default1'), (25, 6, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(0, 'A')
(2, 'default1')
(4, 'A')
*/

-- Prediction Query
SELECT DISTINCT TEMP.CUSTOMER_ID, C.CUSTOMER_NAME FROM (SELECT O.CUSTOMER_ID FROM ORDERS AS O WHERE O.PRODUCT_NAME = 'A' AND O.CUSTOMER_ID IN (SELECT O.CUSTOMER_ID FROM ORDERS AS O WHERE O.PRODUCT_NAME = 'B') AND NOT O.CUSTOMER_ID IN (SELECT O.CUSTOMER_ID FROM ORDERS AS O WHERE O.PRODUCT_NAME = 'C')) AS TEMP INNER JOIN CUSTOMERS AS C ON TEMP.CUSTOMER_ID = C.CUSTOMER_ID;

/*
Prediction Result:
(0, 'A')
(4, 'A')
(2, 'default1')
*/