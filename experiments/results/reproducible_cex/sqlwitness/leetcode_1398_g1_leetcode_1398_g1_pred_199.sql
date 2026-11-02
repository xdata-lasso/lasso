-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'default2'), (0, NULL), (-1, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, NULL, 'C'), (-1, 0, 'A'), (2, 2, NULL), (0, 2, 'default2'), (3, 0, 'A'), (4, 2, 'B'), (5, 2, NULL), (6, -1, 'default1'), (7, 0, 'default1'), (8, 2, 'A'), (9, 2, 'default2'), (10, 2, 'B'), (11, 0, 'B'), (12, -1, 'default2'), (13, 2, 'C'), (14, -1, 'default2'), (15, NULL, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(0, None)
*/

-- Prediction Query
WITH CTE AS (SELECT A.CID AS CUSTOMERID FROM (SELECT CUSTOMER_ID AS CID FROM ORDERS WHERE PRODUCT_NAME = 'A') AS A JOIN (SELECT CUSTOMER_ID AS CID FROM ORDERS WHERE PRODUCT_NAME = 'B') AS B ON A.CID = B.CID WHERE NOT A.CID IN (SELECT DISTINCT CUSTOMER_ID AS CID FROM ORDERS WHERE PRODUCT_NAME = 'C')) SELECT DISTINCT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C JOIN CTE ON C.CUSTOMER_ID = CTE.CUSTOMERID ORDER BY C.CUSTOMER_ID, C.CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
*/