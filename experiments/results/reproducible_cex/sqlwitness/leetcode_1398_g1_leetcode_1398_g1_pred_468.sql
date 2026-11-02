-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'default1'), (3, 'B'), (1, 'B'), (2, NULL), (0, NULL), (4, 'default2'), (5, NULL), (6, 'default1'), (7, 'C'), (8, 'C'), (9, 'B'), (10, 'default2'), (11, 'C'), (12, 'B'), (13, NULL), (14, 'default1'), (15, 'default1'), (16, 'default1'), (17, NULL), (18, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 4, 'B'), (-1, 7, 'A'), (3, 15, 'C'), (2, NULL, 'default1'), (1, 7, 'B'), (4, 6, NULL), (5, 3, NULL), (6, 15, 'default1'), (7, 0, NULL), (8, NULL, 'C'), (9, 16, 'C'), (10, 6, 'B'), (11, 0, 'default1'), (12, 12, 'B'), (13, 11, 'default2'), (14, 13, NULL), (15, NULL, 'C'), (16, 1, 'default1'), (17, 17, 'A'), (18, 4, 'C'), (19, 18, 'A'), (20, 16, NULL), (21, 14, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(7, 'C')
*/

-- Prediction Query
WITH CUST AS (SELECT CUSTOMER_ID, COUNT(DISTINCT (PRODUCT_NAME)) AS NUM_PROD FROM ORDERS WHERE PRODUCT_NAME = 'A' OR PRODUCT_NAME = 'B' GROUP BY 1 HAVING NUM_PROD = 2) SELECT A.CUSTOMER_ID, CUSTOMER_NAME FROM CUST AS A JOIN CUSTOMERS AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID WHERE NOT A.CUSTOMER_ID IN (SELECT DISTINCT (CUSTOMER_ID) FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
*/