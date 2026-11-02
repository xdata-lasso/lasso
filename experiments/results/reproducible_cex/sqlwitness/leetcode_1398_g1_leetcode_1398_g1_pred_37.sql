-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'B'), (2, 'A'), (-1, 'B'), (0, 'default2'), (3, 'C'), (4, 'default2'), (5, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 3, 'default2'), (-1, 4, 'default2'), (1, 2, 'B'), (2, 5, NULL), (3, 0, NULL), (4, -1, 'B'), (5, -1, NULL), (6, 5, 'A'), (7, NULL, 'B'), (8, 5, NULL), (9, 5, 'default2'), (10, 4, 'A'), (11, 2, 'C'), (12, 3, 'B'), (13, 1, 'A'), (14, 3, NULL), (15, 1, 'A'), (16, NULL, 'C'), (17, 3, 'C'), (18, 0, 'A'), (19, 5, 'default1'), (20, 4, 'default2'), (21, NULL, 'A'), (22, 1, 'A'), (23, 0, 'default2'), (24, 0, NULL), (25, 4, 'A'), (26, 5, 'default1'), (27, NULL, NULL), (28, 1, 'default2'), (29, 2, 'C'), (30, 1, 'B'), (31, 1, 'default1'), (32, -1, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'B')
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE NOT CUSTOMER_ID IN (SELECT DISTINCT (CUSTOMER_ID) FROM ORDERS WHERE PRODUCT_NAME = 'C') AND CUSTOMER_ID IN (SELECT DISTINCT (CUSTOMER_ID) FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT (CUSTOMER_ID) FROM ORDERS WHERE PRODUCT_NAME = 'B') ORDER BY CUSTOMER_ID;

/*
Prediction Result:
*/