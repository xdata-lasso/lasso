-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'C'), (0, '%B%'), (2, '%C%'), (1, 'B'), (3, '%A%'), (4, 'C'), (5, '%A%'), (6, NULL), (7, 'default1'), (8, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 2, '%A%'), (0, NULL, NULL), (-1, 0, '%B%'), (2, 3, '%B%'), (3, NULL, 'A'), (4, 2, 'default1'), (5, 8, '%A%'), (6, NULL, 'C'), (7, -1, 'C'), (8, 0, 'default2'), (9, 7, '%B%'), (10, 6, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE1 AS (SELECT CUSTOMER_ID, GROUP_CONCAT(DISTINCT PRODUCT_NAME) AS CT FROM ORDERS GROUP BY 1), CTE2 AS (SELECT CUSTOMER_ID FROM CTE1 WHERE CT NOT LIKE '%C%' AND CT LIKE '%A%' AND CT LIKE '%B%') SELECT C.CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS AS C JOIN CTE2 ON C.CUSTOMER_ID = CTE2.CUSTOMER_ID;

/*
Prediction Result:
(0, '%B%')
*/