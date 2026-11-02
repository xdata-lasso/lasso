-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'C'), (1, 'B'), (-1, NULL), (2, 'default1'), (3, 'default2'), (4, 'A'), (5, 'default1'), (6, 'C'), (7, 'default2'), (8, 'A'), (9, 'default1'), (10, 'B'), (11, 'default1'), (12, NULL), (13, 'default2'), (14, 'default2'), (15, NULL), (16, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 0, NULL), (0, 10, 'default1'), (1, 15, 'B'), (-1, 12, 'B'), (3, 1, 'A'), (4, 12, 'A'), (5, 10, 'B'), (6, 7, NULL), (7, 16, 'A'), (8, 2, 'A'), (9, 12, 'default2'), (10, 1, 'default2'), (11, 13, NULL), (12, NULL, 'C'), (13, 15, 'default1'), (14, 0, 'A'), (15, 15, NULL), (16, 2, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(2, 'default1')
(12, None)
*/

-- Prediction Query
WITH T1 AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A' AND CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C')) SELECT T1.CUSTOMER_ID, C.CUSTOMER_NAME FROM T1 LEFT JOIN CUSTOMERS AS C ON T1.CUSTOMER_ID = C.CUSTOMER_ID;

/*
Prediction Result:
*/