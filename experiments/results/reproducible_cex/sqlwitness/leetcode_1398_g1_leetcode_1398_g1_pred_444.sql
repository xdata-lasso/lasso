-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'A'), (0, 'default1'), (2, 'default2'), (-1, 'default1'), (3, 'C'), (4, NULL), (5, 'A'), (6, 'A'), (7, 'default2'), (8, 'C'), (9, 'C'), (10, 'B'), (11, 'C'), (12, 'C'), (13, 'default2'), (14, 'C'), (15, 'A'), (16, 'B'), (17, 'A'), (18, 'default1'), (19, 'default2'), (20, 'default2'), (21, 'default1'), (22, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, NULL, 'C'), (-1, 20, 'A'), (1, 5, NULL), (2, 21, 'A'), (3, 15, 'B'), (4, 4, 'default1'), (5, NULL, NULL), (6, 1, 'default1'), (7, 18, NULL), (8, 6, NULL), (9, 20, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(20, 'default2')
*/

-- Prediction Query
SELECT * FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT (CUSTOMER_ID) AS CID FROM ORDERS WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C'));

/*
Prediction Result:
*/