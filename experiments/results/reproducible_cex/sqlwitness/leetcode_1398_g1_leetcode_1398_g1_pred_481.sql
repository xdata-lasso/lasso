-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'B'), (0, 'C'), (1, 'C'), (-1, 'C'), (3, 'C'), (4, 'C'), (5, 'A'), (6, 'A'), (7, 'B'), (8, 'default1'), (9, 'default1'), (10, 'C'), (11, NULL), (12, 'default1'), (13, 'C'), (14, 'default1'), (15, 'C'), (16, 'B'), (17, 'A'), (18, 'default2'), (19, 'default1'), (20, 'B'), (21, 'B'), (22, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 7, 'C'), (0, 16, 'B'), (1, 16, 'A'), (-1, 17, 'B'), (3, 3, 'C'), (4, 18, 'B'), (5, 6, NULL), (6, 7, 'default1'), (7, 5, NULL), (8, 17, 'C'), (9, 14, 'B'), (10, 17, NULL), (11, 9, NULL), (12, 22, 'default2'), (13, 12, 'B'), (14, 14, 'A'), (15, 21, 'default1'), (16, 15, 'default1'), (17, 18, NULL), (18, 4, NULL), (19, 17, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(14, 'default1')
(16, 'B')
*/

-- Prediction Query
SELECT DISTINCT C1.CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS AS C1 CROSS JOIN ORDERS AS C2 JOIN CUSTOMERS AS C ON C1.CUSTOMER_ID = C2.CUSTOMER_ID AND C.CUSTOMER_ID = C1.CUSTOMER_ID AND (C1.PRODUCT_NAME = 'A' AND C2.PRODUCT_NAME = 'B') WHERE NOT C1.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS AS O WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(16, 'B')
(14, 'default1')
*/