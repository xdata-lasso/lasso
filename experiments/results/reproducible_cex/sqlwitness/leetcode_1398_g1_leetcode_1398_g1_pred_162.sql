-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'default1'), (0, 'B'), (2, NULL), (1, 'C'), (3, 'default1'), (4, 'B'), (5, 'A'), (6, 'C'), (7, NULL), (8, 'default1'), (9, 'A'), (10, 'C'), (11, 'B'), (12, 'default1'), (13, 'B'), (14, 'B'), (15, 'A'), (16, 'default1'), (17, 'A'), (18, 'default1'), (19, 'A'), (20, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 11, 'C'), (1, 1, NULL), (2, 8, 'default2'), (0, 15, 'C'), (3, 14, 'default1'), (4, 17, 'B'), (5, 2, 'B'), (6, NULL, 'C'), (7, 8, 'A'), (8, 1, 'default2'), (9, 4, 'default2'), (10, 7, 'C'), (11, 13, NULL), (12, 18, 'default2'), (13, 6, 'A'), (14, 8, 'B'), (15, 12, 'B'), (16, 6, NULL), (17, 14, 'C'), (18, 4, 'B'), (19, 14, 'default2'), (20, 18, 'B'), (21, 15, 'default2'), (22, 20, 'B'), (23, 13, NULL), (24, 8, 'default2'), (25, 6, 'B'), (26, 16, NULL), (27, 0, 'C'), (28, 6, 'default1'), (29, 18, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(6, 'C')
(8, 'default1')
*/

-- Prediction Query
SELECT DISTINCT CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME, O.PRODUCT_NAME FROM ORDERS AS O JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID) AS ITM WHERE (NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C')) GROUP BY CUSTOMER_ID, CUSTOMER_NAME HAVING SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) > 0 ORDER BY CUSTOMER_ID, CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
*/