-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'default2'), (-1, 'C'), (1, NULL), (0, 'C'), (3, NULL), (4, 'A'), (5, NULL), (6, 'C'), (7, 'A'), (8, 'C'), (9, 'default1'), (10, 'C'), (11, NULL), (12, 'default2'), (13, 'default2'), (14, 'A'), (15, 'B'), (16, NULL), (17, 'C'), (18, 'C'), (19, NULL), (20, NULL), (21, 'B'), (22, 'C'), (23, 'B'), (24, 'A'), (25, 'default1'), (26, 'default1'), (27, NULL), (28, 'default1'), (29, 'default1'), (30, 'C'), (31, 'default1'), (32, 'B'), (33, NULL), (34, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 23, 'default1'), (-1, 24, NULL), (1, 13, NULL), (0, -1, NULL), (3, 23, 'default1'), (4, 12, NULL), (5, 19, 'B'), (6, 20, 'default2'), (7, 17, 'A'), (8, 27, NULL), (9, 17, 'A'), (10, 32, NULL), (11, 20, NULL), (12, 3, 'default2'), (13, 20, 'default2'), (14, 1, 'default2'), (15, 30, 'B'), (16, 0, NULL), (17, 30, 'A'), (18, 2, NULL), (19, 3, 'C'), (20, NULL, 'C'), (21, -1, 'default2'), (22, 33, 'default1'), (23, 10, 'C'), (24, 19, NULL), (25, 34, 'B'), (26, 28, 'C'), (27, 34, 'A'), (28, 2, 'C'), (29, 20, 'A'), (30, 13, 'default2'), (31, 17, NULL), (32, 24, 'default2'), (33, 26, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(30, 'C')
(34, None)
*/

-- Prediction Query
SELECT DISTINCT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM ORDERS AS O CROSS JOIN CUSTOMERS AS C WHERE PRODUCT_NAME = 'A' AND O.CUSTOMER_ID = C.CUSTOMER_ID AND NOT C.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS AS INR WHERE INR.PRODUCT_NAME = 'C') AND C.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS AS INR WHERE INR.PRODUCT_NAME = 'B') ORDER BY C.CUSTOMER_ID, C.CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
*/