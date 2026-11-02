-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, NULL), (1, 'A'), (0, NULL), (-1, 'A'), (3, 'C'), (4, 'default1'), (5, 'default2'), (6, 'C'), (7, 'A'), (8, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 0, 'default1'), (0, 6, 'default2'), (-1, 8, 'B'), (1, 2, 'C'), (3, 0, NULL), (4, 2, NULL), (5, NULL, 'B'), (6, -1, 'default1'), (7, 1, 'A'), (8, 4, 'default1'), (9, 1, 'A'), (10, 4, 'C'), (11, -1, NULL), (12, 3, 'default2'), (13, 7, 'default2'), (14, 5, 'B'), (15, 6, 'A'), (16, 8, 'A'), (17, 5, 'A'), (18, 4, 'default2'), (19, 7, 'default2'), (20, -1, 'A'), (21, 2, NULL), (22, 2, 'default1'), (23, 5, 'B'), (24, 2, NULL), (25, -1, 'default1'), (26, 1, 'default2'), (27, 1, 'default1'), (28, 1, 'B'), (29, 8, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'A')
(5, 'default2')
(8, 'default1')
*/

-- Prediction Query
SELECT DISTINCT A.CUSTOMER_ID, C.CUSTOMER_NAME FROM ORDERS AS A JOIN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = A.CUSTOMER_ID WHERE PRODUCT_NAME = 'A' AND NOT A.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(1, 'A')
(8, 'default1')
(5, 'default2')
*/