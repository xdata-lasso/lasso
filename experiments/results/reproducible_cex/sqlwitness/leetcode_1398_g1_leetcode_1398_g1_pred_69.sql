-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'default2'), (1, 'default1'), (0, 'default2'), (-1, 'default1'), (3, NULL), (4, 'A'), (5, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, NULL, 'default1'), (-1, 0, 'B'), (0, NULL, NULL), (1, 1, 'A'), (3, 1, NULL), (4, 1, 'A'), (5, 0, NULL), (6, -1, NULL), (7, 5, 'C'), (8, 0, 'default1'), (9, 4, 'default1'), (10, 2, 'A'), (11, 2, NULL), (12, NULL, 'C'), (13, 1, 'B'), (14, 4, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'default1')
*/

-- Prediction Query
WITH CTE AS (SELECT DISTINCT O1.CUSTOMER_ID FROM ORDERS AS O1 LEFT JOIN ORDERS AS O2 ON O1.CUSTOMER_ID = O2.CUSTOMER_ID WHERE O1.PRODUCT_NAME = 'A' AND O2.PRODUCT_NAME = 'B') SELECT C2.CUSTOMER_ID, C2.CUSTOMER_NAME FROM CTE AS C1 JOIN CUSTOMERS AS C2 ON C1.CUSTOMER_ID = C2.CUSTOMER_ID AND NOT C1.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
*/