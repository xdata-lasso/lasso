-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default2'), (1, 'B'), (-1, 'A'), (2, 'C'), (3, 'default1'), (4, 'A'), (5, 'default2'), (6, 'default2'), (7, 'default2'), (8, 'A'), (9, NULL), (10, 'C'), (11, 'default1'), (12, 'C'), (13, 'B'), (14, 'default2'), (15, 'default1'), (16, 'B'), (17, 'default2'), (18, 'default1'), (19, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 19, 'A'), (1, 14, 'default1'), (-1, 6, 'C'), (0, 7, 'C'), (3, 6, 'default1'), (4, NULL, 'default1'), (5, NULL, 'B'), (6, 4, 'default1'), (7, 3, 'B'), (8, 13, 'default2'), (9, 2, 'default2'), (10, NULL, 'A'), (11, 10, 'C'), (12, NULL, 'default2'), (13, 3, 'B'), (14, 17, 'default1'), (15, 1, 'C'), (16, 12, 'default2'), (17, 13, 'default2'), (18, 5, 'B'), (19, 18, 'default2'), (20, 15, NULL), (21, 3, NULL), (22, 2, 'A'), (23, 15, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT TMP.CUSTOMER_ID, C.CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, CASE WHEN SUM(BOUGHT_A) >= 1 AND SUM(BOUGHT_B) >= 1 AND SUM(BOUGHT_C) = 0 THEN 1 ELSE 0 END AS BOUGHT_AB_NOT_C FROM (SELECT CUSTOMER_ID, CASE WHEN PRODUCT_NAME IN ('A') THEN 1 ELSE 0 END AS BOUGHT_A, CASE WHEN PRODUCT_NAME IN ('B') THEN 1 ELSE 0 END AS BOUGHT_B, CASE WHEN PRODUCT_NAME IN ('C') THEN 1 ELSE 0 END AS BOUGHT_C FROM ORDERS) AS A GROUP BY 1) AS TMP LEFT JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = TMP.CUSTOMER_ID WHERE BOUGHT_AB_NOT_C = 1;

/*
Prediction Result:
(None, None)
*/