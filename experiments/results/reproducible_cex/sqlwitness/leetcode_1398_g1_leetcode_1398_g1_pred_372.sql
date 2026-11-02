-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'B'), (-1, 'A'), (0, 'C'), (2, 'A'), (3, 'default1'), (4, 'A'), (5, 'C'), (6, 'default1'), (7, 'default2'), (8, 'C'), (9, 'C'), (10, 'default2'), (11, 'B'), (12, NULL), (13, 'C'), (14, 'default1'), (15, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 6, NULL), (-1, 12, 'A'), (2, 10, 'default1'), (1, 2, 'A'), (3, 12, 'A'), (4, 14, 'A'), (5, 2, 'B'), (6, 10, NULL), (7, 12, 'B'), (8, 13, 'B'), (9, 0, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(2, 'A')
(12, None)
*/

-- Prediction Query
WITH CUSTOMER_TO_MATCH AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C')) SELECT M.CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS AS C JOIN CUSTOMER_TO_MATCH AS M ON C.CUSTOMER_ID = M.CUSTOMER_ID;

/*
Prediction Result:
(12, None)
(2, 'A')
*/