-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'A'), (1, 'default2'), (-1, NULL), (0, 'B'), (3, 'C'), (4, 'default1'), (5, 'default1'), (6, NULL), (7, 'C'), (8, 'default1'), (9, 'B'), (10, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, NULL, 'C'), (0, 2, NULL), (2, 8, 'default2'), (1, 0, NULL), (3, 2, 'A'), (4, -1, NULL), (5, 3, NULL), (6, 1, 'default1'), (7, 9, 'default1'), (8, 2, 'B'), (9, 10, NULL), (10, NULL, 'default1'), (11, NULL, 'A'), (12, 7, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(2, 'A')
*/

-- Prediction Query
SELECT A.CUSTOMER_ID, A.CUSTOMER_NAME FROM CUSTOMERS AS A CROSS JOIN ORDERS AS B WHERE A.CUSTOMER_ID = B.CUSTOMER_ID AND A.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND A.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT A.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') GROUP BY A.CUSTOMER_ID;

/*
Prediction Result:
*/