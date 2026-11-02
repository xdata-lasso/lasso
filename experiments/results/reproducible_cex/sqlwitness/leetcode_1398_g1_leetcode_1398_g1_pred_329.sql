-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'B'), (2, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, NULL, 'C'), (2, NULL, 'A'), (1, NULL, 'C'), (-1, NULL, NULL), (3, 1, 'default2'), (4, 2, 'A'), (5, NULL, NULL), (6, 2, 'B'), (7, NULL, 'A'), (8, 1, NULL), (9, 2, NULL), (10, 2, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(2, 'default1')
*/

-- Prediction Query
WITH T1 AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE (CUSTOMER_ID, 'A') IN (SELECT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS) AND (CUSTOMER_ID, 'B') IN (SELECT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS) AND NOT (CUSTOMER_ID, 'C') IN (SELECT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS)) SELECT * FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT * FROM T1);

/*
Prediction Result:
*/