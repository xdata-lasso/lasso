-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'C'), (1, 'default1'), (-1, 'default2'), (0, 'A'), (3, 'default1'), (4, 'default2'), (5, NULL), (6, 'B'), (7, 'B'), (8, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 4, 'C'), (2, NULL, 'B'), (-1, 8, 'default1'), (0, 4, 'default2'), (3, NULL, NULL), (4, NULL, 'A'), (5, 8, 'default1'), (6, 6, 'B'), (7, 1, 'A'), (8, 5, NULL), (9, 4, 'B'), (10, 1, NULL), (11, NULL, 'A'), (12, 4, 'A'), (13, 4, 'A'), (14, 5, 'default2'), (15, 5, 'default2'), (16, 3, 'default1'), (17, 1, 'B'), (18, -1, NULL), (19, 4, 'default1'), (20, 8, NULL), (21, 1, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT O.CUSTOMER_ID AS CUSTOMER_ID, C.CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(PRODUCT_NAME = 'A') AS CA, SUM(PRODUCT_NAME = 'B') AS CB, SUM(PRODUCT_NAME = 'C') AS CC FROM ORDERS GROUP BY CUSTOMER_ID) AS O LEFT JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID WHERE CA > 0 AND CB > 0 AND CC = 0 ORDER BY CUSTOMER_ID;

/*
Prediction Result:
(None, None)
*/