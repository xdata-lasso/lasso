-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'A'), (1, 'A'), (2, NULL), (0, 'C'), (3, 'default2'), (4, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 4, 'default2'), (1, 4, NULL), (2, -1, 'default1'), (-1, 1, 'default1'), (3, 1, 'C'), (4, 2, 'B'), (5, 2, 'default1'), (6, 0, 'default1'), (7, 4, NULL), (8, -1, 'A'), (9, -1, NULL), (10, 4, 'B'), (11, 4, 'A'), (12, 2, 'C'), (13, 0, 'B'), (14, 2, 'default1'), (15, NULL, 'default1'), (16, 3, 'B'), (17, 4, NULL), (18, 1, 'A'), (19, 2, NULL), (20, 1, 'B'), (21, 3, 'C'), (22, NULL, NULL), (23, NULL, 'A'), (24, 3, NULL), (25, 0, NULL), (26, NULL, 'B'), (27, NULL, 'C'), (28, NULL, 'default2'), (29, 4, NULL), (30, -1, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(4, 'B')
*/

-- Prediction Query
SELECT CUSTOMERS.CUSTOMER_ID, CUSTOMERS.CUSTOMER_NAME FROM (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C')) AS A INNER JOIN CUSTOMERS ON A.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID;

/*
Prediction Result:
*/