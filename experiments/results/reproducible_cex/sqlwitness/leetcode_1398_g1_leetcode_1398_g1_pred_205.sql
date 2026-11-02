-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'C'), (0, NULL), (-1, 'default2'), (1, 'B'), (3, NULL), (4, 'default2'), (5, NULL), (6, 'C'), (7, NULL), (8, 'A'), (9, 'C'), (10, 'C'), (11, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 11, 'C'), (1, NULL, 'C'), (0, 1, 'default2'), (-1, 4, 'A'), (3, -1, NULL), (4, 2, 'default2'), (5, 8, 'B'), (6, 8, 'A'), (7, 9, 'default1'), (8, 1, 'default2'), (9, 6, 'C'), (10, 10, 'C'), (11, 6, 'default2'), (12, 8, 'B'), (13, 9, 'default1'), (14, 6, 'default2'), (15, -1, NULL), (16, 2, 'C'), (17, 5, 'default2'), (18, 11, 'C'), (19, 7, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(8, 'A')
*/

-- Prediction Query
WITH CTE AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') AND PRODUCT_NAME = 'A') SELECT CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS JOIN CUSTOMERS USING (CUSTOMER_ID) WHERE CUSTOMER_ID IN (SELECT * FROM CTE) AND PRODUCT_NAME = 'B';

/*
Prediction Result:
*/