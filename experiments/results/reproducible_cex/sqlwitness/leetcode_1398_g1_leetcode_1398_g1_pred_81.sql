-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'A'), (1, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 0, 'C'), (0, 1, 'A'), (2, 1, 'default1'), (1, NULL, 'A'), (3, 1, 'A'), (4, NULL, 'default2'), (5, NULL, 'C'), (6, 0, 'default2'), (7, 0, 'B'), (8, NULL, 'A'), (9, 0, 'default2'), (10, 0, 'C'), (11, NULL, NULL), (12, NULL, NULL), (13, NULL, 'default1'), (14, 0, 'default2'), (15, NULL, 'C'), (16, 0, 'A'), (17, 0, 'default1'), (18, 1, 'A'), (19, 1, 'B'), (20, NULL, NULL), (21, NULL, 'A'), (22, 1, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'B')
*/

-- Prediction Query
WITH A AS (SELECT CUSTOMERS.CUSTOMER_ID, CUSTOMER_NAME, ORDER_ID FROM CUSTOMERS INNER JOIN ORDERS ON CUSTOMERS.CUSTOMER_ID = ORDERS.CUSTOMER_ID WHERE PRODUCT_NAME = 'A'), B AS (SELECT A.CUSTOMER_ID, CUSTOMER_NAME, A.ORDER_ID FROM A INNER JOIN ORDERS ON A.CUSTOMER_ID = ORDERS.CUSTOMER_ID WHERE PRODUCT_NAME = 'B') SELECT B.CUSTOMER_ID, CUSTOMER_NAME FROM B WHERE NOT B.CUSTOMER_ID IN (SELECT CUSTOMERS.CUSTOMER_ID FROM CUSTOMERS INNER JOIN ORDERS ON CUSTOMERS.CUSTOMER_ID = ORDERS.CUSTOMER_ID WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(1, 'B')
(1, 'B')
(1, 'B')
*/