-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, NULL), (2, 'default1'), (1, 'default1'), (-1, 'default2'), (3, 'default1'), (4, 'A'), (5, 'C'), (6, 'default1'), (7, 'A'), (8, 'default2'), (9, 'B'), (10, 'default1'), (11, 'default1'), (12, 'C'), (13, NULL), (14, 'B'), (15, 'default2'), (16, 'A'), (17, 'C'), (18, 'C'), (19, 'B'), (20, 'C'), (21, NULL), (22, 'C'), (23, 'default1'), (24, 'A'), (25, 'default2'), (26, 'C'), (27, 'default1'), (28, 'A'), (29, 'C'), (30, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 27, 'A'), (2, 16, 'C'), (1, 17, 'default2'), (-1, 14, 'A'), (3, 14, 'default2'), (4, NULL, 'C'), (5, 22, 'default1'), (6, 9, 'default1'), (7, 21, 'A'), (8, 9, 'C'), (9, 6, 'default2'), (10, 6, NULL), (11, 19, 'B'), (12, 21, 'B'), (13, 6, NULL), (14, NULL, 'A'), (15, 3, 'default1'), (16, 25, NULL), (17, -1, 'default1'), (18, 10, 'default1'), (19, 21, NULL), (20, -1, 'default1'), (21, 10, 'C'), (22, 27, 'C'), (23, 0, NULL), (24, 13, 'default1'), (25, 11, NULL), (26, 23, 'default1'), (27, 19, 'C'), (28, 29, 'default2'), (29, 17, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(21, None)
*/

-- Prediction Query
WITH A AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A' AND CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C')) SELECT DISTINCT A.CUSTOMER_ID, C.CUSTOMER_NAME FROM A LEFT JOIN CUSTOMERS AS C ON A.CUSTOMER_ID = C.CUSTOMER_ID;

/*
Prediction Result:
*/