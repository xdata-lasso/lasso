-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'default2'), (0, 'default2'), (2, 'A'), (-1, 'C'), (3, 'A'), (4, 'A'), (5, 'C'), (6, 'A'), (7, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, -1, 'default2'), (0, -1, NULL), (-1, 5, 'C'), (2, 3, 'default1'), (3, NULL, 'default2'), (4, -1, 'default1'), (5, 2, 'B'), (6, 7, 'C'), (7, 7, 'default1'), (8, -1, 'default1'), (9, 7, NULL), (10, 2, 'default2'), (11, 2, NULL), (12, 0, 'default2'), (13, 7, 'default2'), (14, 6, 'default2'), (15, 0, 'A'), (16, NULL, 'C'), (17, -1, 'B'), (18, NULL, 'default2'), (19, 1, 'A'), (20, -1, NULL), (21, 2, 'default2'), (22, 6, 'B'), (23, 1, 'B'), (24, -1, 'default1'), (25, 0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'default2')
*/

-- Prediction Query
SELECT * FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
*/