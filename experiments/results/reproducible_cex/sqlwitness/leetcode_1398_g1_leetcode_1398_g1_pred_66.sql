-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'A'), (0, 'default2'), (2, 'default1'), (-1, 'C'), (3, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, -1, 'default2'), (-1, 3, NULL), (1, 2, 'default2'), (0, -1, 'default1'), (3, 0, NULL), (4, NULL, 'A'), (5, 3, NULL), (6, 1, NULL), (7, 1, 'B'), (8, 2, 'A'), (9, -1, 'default1'), (10, 2, NULL), (11, 1, 'A'), (12, 0, NULL), (13, 0, 'B'), (14, 0, 'default1'), (15, 3, NULL), (16, 1, 'A'), (17, 3, 'B'), (18, 2, NULL), (19, 3, 'default1'), (20, 0, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(0, 'default2')
(1, 'A')
*/

-- Prediction Query
WITH A AS (SELECT DISTINCT (CUSTOMER_ID) AS CUSTS_A FROM ORDERS WHERE PRODUCT_NAME = 'A'), B AS (SELECT DISTINCT (CUSTOMER_ID) AS CUSTS_B FROM ORDERS WHERE PRODUCT_NAME = 'B'), C AS (SELECT DISTINCT (CUSTOMER_ID) AS CUSTS_C FROM ORDERS WHERE PRODUCT_NAME = 'C') SELECT CUSTOMERS.CUSTOMER_ID, CUSTOMERS.CUSTOMER_NAME FROM (SELECT A.CUSTS_A FROM A JOIN B ON A.CUSTS_A = B.CUSTS_B LEFT JOIN C ON A.CUSTS_A = C.CUSTS_C WHERE C.CUSTS_C IS NULL) AS T JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = T.CUSTS_A;

/*
Prediction Result:
(1, 'A')
(0, 'default2')
*/