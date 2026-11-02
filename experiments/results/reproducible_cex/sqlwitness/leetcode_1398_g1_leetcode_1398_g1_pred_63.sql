-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'default2'), (-1, 'A'), (1, NULL), (0, 'default1'), (3, 'B'), (4, 'A'), (5, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 1, 'B'), (1, 4, 'B'), (2, 5, 'default1'), (-1, 4, 'B'), (3, 0, 'B'), (4, 3, NULL), (5, 4, 'B'), (6, 2, 'B'), (7, 3, 'C'), (8, 5, 'B'), (9, 1, 'default2'), (10, 1, 'default1'), (11, 1, 'C'), (12, 0, 'default1'), (13, 5, 'A'), (14, 2, 'A'), (15, NULL, NULL), (16, 1, NULL), (17, 1, 'B'), (18, 3, 'default2'), (19, 1, 'default1'), (20, 4, 'A'), (21, 0, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(2, 'default2')
(4, 'A')
(5, 'A')
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS JOIN CUSTOMERS USING (CUSTOMER_ID) GROUP BY CUSTOMER_ID HAVING SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) = 1 AND SUM(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) = 1 AND SUM(CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) = 0;

/*
Prediction Result:
(2, 'default2')
(5, 'A')
*/