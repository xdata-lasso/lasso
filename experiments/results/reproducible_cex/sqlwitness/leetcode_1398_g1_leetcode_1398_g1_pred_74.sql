-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'default2'), (-1, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 1, 'B'), (-1, 1, 'default1'), (2, NULL, 'B'), (1, 1, NULL), (3, 1, 'C'), (4, NULL, 'C'), (5, 1, 'B'), (6, -1, 'A'), (7, -1, 'A'), (8, NULL, 'A'), (9, NULL, 'C'), (10, -1, 'B'), (11, 1, 'A'), (12, NULL, 'default1'), (13, 1, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(-1, 'A')
*/

-- Prediction Query
WITH CTE1 AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B')) SELECT * FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT * FROM CTE1);

/*
Prediction Result:
*/