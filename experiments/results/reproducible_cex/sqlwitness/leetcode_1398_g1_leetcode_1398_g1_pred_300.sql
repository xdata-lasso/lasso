-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, NULL), (1, 'C'), (0, 'B'), (3, NULL), (2, 'B'), (4, NULL), (5, 'C'), (6, 'default1'), (7, 'default2'), (8, 'C'), (9, 'C'), (10, 'default1'), (11, 'default2'), (12, 'C'), (13, 'C'), (14, 'default2'), (15, 'A'), (16, 'C'), (17, 'default2'), (18, 'A'), (19, 'C'), (20, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 11, 'default2'), (3, 1, 'A'), (1, 5, 'C'), (-1, 7, 'C'), (0, 20, 'C'), (4, 10, NULL), (5, 1, 'A'), (6, NULL, 'A'), (7, 3, NULL), (8, 4, 'C'), (9, 18, 'default1'), (10, 4, 'A'), (11, 18, NULL), (12, 2, 'C'), (13, 10, 'B'), (14, 8, NULL), (15, 9, 'default1'), (16, 12, 'default1'), (17, 2, 'default2'), (18, 8, 'B'), (19, 15, 'default1'), (20, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH TEMP AS (SELECT DISTINCT A.CUSTOMER_ID, B.CUSTOMER_NAME, SUM(CASE WHEN A.PRODUCT_NAME IN ('A', 'B') THEN 1 ELSE 0 END) AS CT_AB, SUM(CASE WHEN A.PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) AS CT_C FROM ORDERS AS A JOIN CUSTOMERS AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID GROUP BY A.CUSTOMER_ID) SELECT CUSTOMER_ID, CUSTOMER_NAME FROM TEMP WHERE CT_AB >= 2 AND CT_C = 0;

/*
Prediction Result:
(1, 'C')
*/