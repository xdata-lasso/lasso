-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (3, NULL), (1, 'B'), (-1, 'B'), (0, 'C'), (2, 'C'), (4, 'C'), (5, 'B'), (6, 'A'), (7, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (3, 7, 'A'), (1, 2, NULL), (-1, NULL, 'C'), (0, NULL, 'default2'), (2, 2, 'A'), (4, NULL, 'default2'), (5, 2, 'C'), (6, -1, 'default2'), (7, 3, NULL), (8, NULL, NULL), (9, 6, 'default2'), (10, 0, 'A'), (11, 2, NULL), (12, 4, 'default2'), (13, 0, 'default2'), (14, -1, 'B'), (15, 6, 'B'), (16, 6, 'A'), (17, 5, 'C'), (18, 0, NULL), (19, 6, 'default1'), (20, 6, 'default2'), (21, -1, NULL), (22, 1, NULL), (23, 2, 'C'), (24, 5, 'B'), (25, 0, 'C'), (26, 4, 'default1'), (27, -1, 'B'), (28, NULL, NULL), (29, 3, 'B'), (30, 6, 'default1'), (31, 2, 'A'), (32, 7, 'default2'), (33, 1, 'C'), (34, -1, 'B'), (35, 1, 'B'), (36, 2, 'B'), (37, 6, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(6, 'A')
*/

-- Prediction Query
WITH DATA AS (SELECT CUSTOMER_ID, COUNT(DISTINCT PRODUCT_NAME) AS CNT FROM ORDERS WHERE PRODUCT_NAME IN ('A', 'B') GROUP BY CUSTOMER_ID HAVING COUNT(DISTINCT PRODUCT_NAME) = 2) SELECT DISTINCT A.CUSTOMER_ID, C.CUSTOMER_NAME FROM ORDERS AS A JOIN DATA AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID JOIN CUSTOMERS AS C ON B.CUSTOMER_ID = C.CUSTOMER_ID WHERE NOT A.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY 1, A.CUSTOMER_ID NULLS LAST, C.CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
*/