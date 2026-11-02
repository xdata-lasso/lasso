-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'B'), (0, 'default1'), (2, 'A'), (1, 'B'), (3, 'B'), (4, 'C'), (5, 'A'), (6, 'default2'), (7, 'B'), (8, 'A'), (9, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 0, 'default2'), (-1, 4, NULL), (2, 8, 'A'), (1, NULL, NULL), (3, 7, 'C'), (4, 6, 'default1'), (5, -1, 'A'), (6, 1, 'default1'), (7, 4, 'default2'), (8, 9, 'default1'), (9, 7, 'A'), (10, 6, 'A'), (11, 3, 'A'), (12, -1, 'B'), (13, 9, 'C'), (14, 4, 'default1'), (15, 4, NULL), (16, 1, NULL), (17, 7, 'B'), (18, 0, 'default1'), (19, NULL, 'C'), (20, 4, 'B'), (21, NULL, 'default2'), (22, 1, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(-1, 'B')
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS AS C WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A' AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B')) AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
*/