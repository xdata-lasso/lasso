-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'C'), (0, 'default2'), (1, 'default1'), (-1, 'default2'), (3, 'default1'), (4, 'default2'), (5, 'B'), (6, 'A'), (7, NULL), (8, 'default2'), (9, 'A'), (10, NULL), (11, NULL), (12, 'B'), (13, 'default2'), (14, 'A'), (15, NULL), (16, NULL), (17, 'B'), (18, 'default1'), (19, 'default2'), (20, 'A'), (21, 'default2'), (22, 'default2'), (23, NULL), (24, 'default2'), (25, 'C'), (26, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 17, 'default1'), (0, 21, 'C'), (-1, 11, 'default1'), (2, -1, 'A'), (3, 19, NULL), (4, 7, NULL), (5, -1, NULL), (6, 1, 'default2'), (7, 20, 'B'), (8, 1, 'default2'), (9, 20, 'default2'), (10, 20, 'C'), (11, 6, 'default2'), (12, 1, 'C'), (13, 15, 'B'), (14, 0, 'default2'), (15, 15, 'C'), (16, 18, NULL), (17, 21, 'B'), (18, NULL, NULL), (19, 23, 'B'), (20, 8, 'default1'), (21, -1, 'B'), (22, 10, 'A'), (23, 10, 'default2'), (24, 22, NULL), (25, 14, 'default2'), (26, 6, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(-1, 'default2')
*/

-- Prediction Query
WITH DATA1 AS (SELECT C.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O USING (CUSTOMER_ID) WHERE PRODUCT_NAME IN ('A')), DATA2 AS (SELECT C.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O USING (CUSTOMER_ID) WHERE PRODUCT_NAME IN ('B')) SELECT DISTINCT DATA1.CUSTOMER_ID, DATA1.CUSTOMER_NAME FROM DATA1 JOIN DATA2 USING (CUSTOMER_ID) WHERE NOT DATA1.CUSTOMER_NAME IN (SELECT CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O USING (CUSTOMER_ID) WHERE PRODUCT_NAME IN ('C')) ORDER BY DATA1.CUSTOMER_ID ASC, DATA1.CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
*/