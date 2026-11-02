-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'C'), (0, 'default2'), (-1, 'A'), (2, 'default1'), (3, NULL), (4, 'B'), (5, 'B'), (6, NULL), (7, 'default2'), (8, 'A'), (9, 'default1'), (10, 'C'), (11, 'A'), (12, 'C'), (13, NULL), (14, NULL), (15, 'C'), (16, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 1, 'default2'), (0, 15, 'A'), (2, 12, NULL), (-1, 11, 'A'), (3, 6, 'B'), (4, 8, 'C'), (5, 2, 'B'), (6, 1, 'B'), (7, 2, 'B'), (8, 6, 'B'), (9, 14, 'C'), (10, 0, 'A'), (11, 6, 'A'), (12, 16, NULL), (13, 2, 'default2'), (14, 13, 'C'), (15, 9, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(6, None)
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, CU.CUSTOMER_NAME FROM (SELECT O1.CUSTOMER_ID, O3.PRODUCT_NAME FROM ORDERS AS O1 LEFT JOIN ORDERS AS O2 ON O1.CUSTOMER_ID = O2.CUSTOMER_ID LEFT JOIN (SELECT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS WHERE PRODUCT_NAME = 'C') AS O3 ON O3.CUSTOMER_ID = O1.CUSTOMER_ID WHERE O1.PRODUCT_NAME = 'A' AND O2.PRODUCT_NAME = 'B') AS C LEFT JOIN CUSTOMERS AS CU ON CU.CUSTOMER_ID = C.CUSTOMER_ID WHERE C.PRODUCT_NAME IS NULL;

/*
Prediction Result:
(6, None)
(6, None)
*/