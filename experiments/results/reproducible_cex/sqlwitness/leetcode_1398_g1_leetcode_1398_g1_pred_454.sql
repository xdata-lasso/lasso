-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'A'), (1, 'B'), (-1, 'C'), (2, 'B'), (3, 'default1'), (4, 'default1'), (5, NULL), (6, NULL), (7, 'B'), (8, 'default2'), (9, 'A'), (10, NULL), (11, 'default2'), (12, 'B'), (13, 'default2'), (14, 'default2'), (15, 'B'), (16, 'default1'), (17, 'B'), (18, 'A'), (19, 'C'), (20, 'default1'), (21, 'C'), (22, 'default1'), (23, 'A'), (24, 'default2'), (25, 'A'), (26, 'C'), (27, 'default2'), (28, 'C'), (29, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 12, 'C'), (-1, 21, 'A'), (1, 22, 'B'), (0, 6, 'B'), (3, 13, NULL), (4, 26, NULL), (5, 8, 'A'), (6, 2, 'C'), (7, NULL, 'default1'), (8, 21, 'B'), (9, 4, 'default2'), (10, 17, 'B'), (11, 5, 'A'), (12, 25, 'A'), (13, 23, 'default2'), (14, 19, 'default1'), (15, 21, NULL), (16, 27, NULL), (17, 9, 'A'), (18, 1, 'B'), (19, 28, 'default2'), (20, 9, 'default2'), (21, 19, 'default2'), (22, 21, 'B'), (23, 15, 'default2'), (24, 15, NULL), (25, 20, NULL), (26, 15, 'B'), (27, 18, 'default1'), (28, 25, 'A'), (29, 17, NULL), (30, 24, 'B'), (31, 6, 'A'), (32, 13, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(6, None)
(21, 'C')
*/

-- Prediction Query
WITH AB_C AS (SELECT DISTINCT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS WHERE PRODUCT_NAME IN ('A', 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C')) SELECT DISTINCT AB1.CUSTOMER_ID, C.CUSTOMER_NAME FROM AB_C AS AB1 CROSS JOIN AB_C AS AB2 CROSS JOIN CUSTOMERS AS C WHERE AB1.CUSTOMER_ID = AB2.CUSTOMER_ID AND AB1.CUSTOMER_ID = C.CUSTOMER_ID AND AB1.PRODUCT_NAME = 'A' AND AB2.PRODUCT_NAME = 'B';

/*
Prediction Result:
(21, 'C')
(6, None)
*/