-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (3, 'B'), (1, 'C'), (-1, 'B'), (2, 'default2'), (0, 'C'), (4, 'default1'), (5, 'default2'), (6, 'default2'), (7, 'A'), (8, 'B'), (9, 'B'), (10, 'C'), (11, NULL), (12, 'default1'), (13, 'default2'), (14, 'B'), (15, 'default2'), (16, 'B'), (17, 'default1'), (18, 'C'), (19, 'default2'), (20, 'default1'), (21, 'C'), (22, 'C'), (23, 'default1'), (24, NULL), (25, 'default1'), (26, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (3, 12, 'C'), (-1, 24, NULL), (0, 6, NULL), (2, 10, 'A'), (1, 20, 'default1'), (4, 24, 'B'), (5, 22, NULL), (6, 18, 'A'), (7, 15, 'A'), (8, -1, 'default1'), (9, 22, 'C'), (10, 16, 'default1'), (11, 0, NULL), (12, 0, 'default1'), (13, 21, 'A'), (14, 9, NULL), (15, 4, 'B'), (16, 11, 'A'), (17, 21, NULL), (18, 18, 'C'), (19, 24, 'B'), (20, 19, 'B'), (21, 6, 'default1'), (22, 18, 'default1'), (23, 20, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT A.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME = 'A' OR PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) AS ABCNT, COALESCE(SUM(CASE WHEN PRODUCT_NAME = 'C' THEN 1 END), 0) AS CCNT FROM ORDERS AS ORDERS GROUP BY CUSTOMER_ID) AS A JOIN CUSTOMERS AS CUSTOMERS ON A.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID WHERE ABCNT = 2 AND CCNT = 0;

/*
Prediction Result:
(24, None)
*/