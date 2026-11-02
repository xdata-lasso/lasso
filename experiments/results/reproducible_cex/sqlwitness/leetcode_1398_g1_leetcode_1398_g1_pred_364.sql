-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, NULL), (-1, 'B'), (1, 'default2'), (2, 'default1'), (3, 'B'), (4, 'default1'), (5, 'A'), (6, 'B'), (7, 'C'), (8, 'default1'), (9, 'B'), (10, 'C'), (11, 'default2'), (12, 'B'), (13, 'default1'), (14, 'B'), (15, 'default2'), (16, 'default2'), (17, 'default1'), (18, 'default1'), (19, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 14, 'default1'), (0, 19, 'default1'), (2, 19, NULL), (-1, 1, 'A'), (3, 7, NULL), (4, 1, 'C'), (5, 7, NULL), (6, 4, 'B'), (7, 1, 'A'), (8, 16, 'B'), (9, 16, 'default2'), (10, 18, 'A'), (11, 9, 'A'), (12, 1, NULL), (13, NULL, 'default2'), (14, 6, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID GROUP BY C.CUSTOMER_NAME HAVING SUM(PRODUCT_NAME = 'A') > 0 AND SUM(PRODUCT_NAME = 'B') > 0 AND SUM(PRODUCT_NAME = 'C') = 0;

/*
Prediction Result:
(4, 'default1')
*/