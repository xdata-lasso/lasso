-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, NULL), (0, 'B'), (2, NULL), (-1, 'C'), (3, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 3, 'A'), (1, 1, 'default1'), (-1, 0, 'default1'), (0, 3, 'A'), (3, NULL, 'default2'), (4, 2, 'default1'), (5, NULL, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH ORDER_AB AS (SELECT CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME = 'C' THEN -1 WHEN PRODUCT_NAME = 'A' THEN 0.5 WHEN PRODUCT_NAME = 'B' THEN 0.5 ELSE 0 END) AS PRODUCT_COUNT FROM ORDERS GROUP BY CUSTOMER_ID HAVING PRODUCT_COUNT = 1) SELECT A.CUSTOMER_ID, B.CUSTOMER_NAME FROM ORDER_AB AS A LEFT JOIN CUSTOMERS AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID;

/*
Prediction Result:
(3, 'A')
*/