-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'default1'), (0, 'default1'), (2, 'default1'), (1, 'default1'), (3, NULL), (4, 'default1'), (5, 'C'), (6, 'C'), (7, 'B'), (8, 'B'), (9, 'B'), (10, NULL), (11, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 11, 'A'), (-1, NULL, NULL), (3, 5, 'C'), (2, 5, 'default1'), (1, -1, 'A'), (4, 6, 'A'), (5, 7, 'B'), (6, 1, 'B'), (7, 8, NULL), (8, 7, 'A'), (9, 7, 'B'), (10, 7, 'default1'), (11, 5, 'default2'), (12, 10, 'A'), (13, 8, 'default2'), (14, 2, 'B'), (15, NULL, 'C'), (16, 4, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(7, 'B')
*/

-- Prediction Query
WITH BOUGHTAB AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME IN ('A', 'B') GROUP BY CUSTOMER_ID HAVING COUNT(DISTINCT PRODUCT_NAME) = 2), BOUGHTC AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME IN ('C')) SELECT * FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT * FROM BOUGHTAB) AND NOT CUSTOMER_ID IN (SELECT * FROM BOUGHTC);

/*
Prediction Result:
*/