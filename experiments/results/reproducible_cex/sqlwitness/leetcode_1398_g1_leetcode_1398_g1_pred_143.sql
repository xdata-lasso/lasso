-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'A'), (-1, 'C'), (0, 'default2'), (2, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 0, 'A'), (0, 0, 'A'), (2, 2, 'B'), (1, -1, 'C'), (3, 2, 'B'), (4, -1, 'C'), (5, 1, 'B'), (6, NULL, 'B'), (7, 1, 'C'), (8, 2, NULL), (9, NULL, 'B'), (10, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS AS C WHERE (SELECT COUNT(PRODUCT_NAME) FROM ORDERS WHERE CUSTOMER_ID = C.CUSTOMER_ID AND PRODUCT_NAME IN ('A', 'B')) = 2 AND (SELECT COUNT(PRODUCT_NAME) FROM ORDERS WHERE CUSTOMER_ID = C.CUSTOMER_ID AND PRODUCT_NAME = 'C') = 0;

/*
Prediction Result:
(0, 'default2')
(2, 'default1')
*/