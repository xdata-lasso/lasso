-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'A'), (-1, 'default1'), (0, 'A'), (2, 'A'), (3, 'A'), (4, 'A'), (5, NULL), (6, 'C'), (7, NULL), (8, NULL), (9, 'default1'), (10, 'B'), (11, 'B'), (12, 'B'), (13, 'C'), (14, NULL), (15, 'default2'), (16, 'A'), (17, 'C'), (18, 'default1'), (19, 'C'), (20, 'C'), (21, 'C'), (22, 'B'), (23, 'A'), (24, 'default2'), (25, 'C'), (26, NULL), (27, NULL), (28, 'A'), (29, 'A'), (30, 'default2'), (31, 'B'), (32, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 18, 'default2'), (-1, NULL, 'default1'), (1, 7, 'A'), (0, 17, 'B'), (3, 18, 'default2'), (4, 21, 'C'), (5, 24, 'B'), (6, -1, 'default1'), (7, 18, 'B'), (8, 6, 'C'), (9, 11, 'B'), (10, 28, 'B'), (11, 23, 'B'), (12, 30, 'A'), (13, 16, 'default2'), (14, 0, 'A'), (15, 28, 'default2'), (16, NULL, 'C'), (17, 25, 'C'), (18, 13, 'A'), (19, 26, 'C'), (20, 9, 'A'), (21, 12, 'A'), (22, 30, 'B'), (23, 19, 'B'), (24, 21, 'default2'), (25, 3, 'default2'), (26, 19, NULL), (27, 26, 'default2'), (28, 16, 'B'), (29, 12, 'default1'), (30, 31, 'C'), (31, 5, 'A'), (32, 4, 'A'), (33, 20, 'A'), (34, 15, NULL), (35, 21, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(30, 'default2')
*/

-- Prediction Query
WITH CTE AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') SELECT DISTINCT A.CUSTOMER_ID, D.CUSTOMER_NAME FROM CTE AS A LEFT JOIN CUSTOMERS AS D ON A.CUSTOMER_ID = D.CUSTOMER_ID WHERE A.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT A.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY A.CUSTOMER_ID, D.CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
*/