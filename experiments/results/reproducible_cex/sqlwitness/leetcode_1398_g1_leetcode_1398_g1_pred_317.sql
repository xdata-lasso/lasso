-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'B'), (1, 'C'), (-1, 'default1'), (2, 'A'), (3, 'default2'), (4, 'default2'), (5, 'B'), (6, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 0, 'A'), (-1, NULL, 'C'), (0, 2, 'A'), (2, 0, NULL), (3, -1, 'A'), (4, 0, 'default2'), (5, -1, 'B'), (6, 6, NULL), (7, 1, 'A'), (8, 2, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(-1, 'default1')
*/

-- Prediction Query
WITH AB AS (SELECT CUSTOMER_ID FROM ORDERS WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND PRODUCT_NAME = 'B') SELECT A.CUSTOMER_ID, CUSTOMER_NAME FROM AB AS A JOIN CUSTOMERS AS C USING (CUSTOMER_ID) WHERE NOT A.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Prediction Result:
*/