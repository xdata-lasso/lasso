-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default1'), (-1, 'default1'), (3, 'A'), (2, 'B'), (1, 'default2'), (4, 'A'), (5, 'C'), (6, 'C'), (7, 'A'), (8, 'C'), (9, 'A'), (10, NULL), (11, 'B'), (12, NULL), (13, 'default2'), (14, 'default1'), (15, 'B'), (16, 'default2'), (17, 'B'), (18, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, NULL, 'C'), (2, 15, 'B'), (1, 10, 'C'), (3, 12, 'default2'), (0, 3, NULL), (4, 0, 'B'), (5, -1, 'C'), (6, NULL, 'default2'), (7, 17, 'B'), (8, 5, 'A'), (9, 17, 'default2'), (10, 5, 'B'), (11, 17, 'B'), (12, 2, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(5, 'C')
*/

-- Prediction Query
WITH BOUGHT_AB AS (SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C LEFT JOIN ORDERS AS O USING (CUSTOMER_ID) WHERE PRODUCT_NAME = 'A' OR PRODUCT_NAME = 'B' GROUP BY 1, 2 HAVING COUNT(PRODUCT_NAME) >= 2) SELECT CUSTOMER_ID, CUSTOMER_NAME FROM BOUGHT_AB WHERE NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
*/