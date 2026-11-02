-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, NULL), (2, 'C'), (0, 'A'), (1, 'C'), (3, 'C'), (4, 'B'), (5, 'default2'), (6, NULL), (7, 'C'), (8, 'default1'), (9, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 9, 'C'), (0, 9, 'C'), (-1, 2, 'default1'), (2, 2, NULL), (3, 5, 'C'), (4, 6, 'default1'), (5, 8, 'default2'), (6, 6, 'default2'), (7, 8, 'default2'), (8, 7, 'A'), (9, NULL, 'C'), (10, 8, 'A'), (11, 7, 'A'), (12, 4, NULL), (13, -1, NULL), (14, 7, 'B'), (15, 2, 'B'), (16, 9, NULL), (17, 2, 'default1'), (18, -1, 'default1'), (19, 4, 'default1'), (20, 0, NULL), (21, 6, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(7, 'C')
*/

-- Prediction Query
SELECT DISTINCT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS NATURAL JOIN ORDERS WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
*/