-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'default1'), (-1, 'default2'), (0, 'C'), (2, 'default2'), (3, 'default2'), (4, 'B'), (5, 'B'), (6, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 0, NULL), (0, 6, 'B'), (-1, 5, 'B'), (1, 0, 'A'), (3, 3, 'B'), (4, 0, 'default2'), (5, 6, 'A'), (6, 0, 'default1'), (7, 0, NULL), (8, 0, 'C'), (9, 1, 'default1'), (10, NULL, NULL), (11, 5, 'A'), (12, 3, 'default2'), (13, 2, 'A'), (14, 0, 'A'), (15, 0, 'A'), (16, 1, 'B'), (17, -1, NULL), (18, -1, 'default1'), (19, 6, 'B'), (20, 2, 'B'), (21, NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(2, 'default2')
(5, 'B')
(6, 'default2')
*/

-- Prediction Query
SELECT X.CUSTOMER_ID, X.CUSTOMER_NAME FROM (SELECT ORDERS.CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS LEFT JOIN CUSTOMERS ON ORDERS.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID WHERE PRODUCT_NAME = 'A' AND ORDERS.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B')) AS X LEFT JOIN (SELECT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS WHERE PRODUCT_NAME = 'C') AS Y ON X.CUSTOMER_ID = Y.CUSTOMER_ID WHERE Y.PRODUCT_NAME IS NULL;

/*
Prediction Result:
(6, 'default2')
(5, 'B')
(2, 'default2')
*/