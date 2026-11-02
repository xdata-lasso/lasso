-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'C'), (0, 'default2'), (-1, 'A'), (2, 'default2'), (3, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, NULL, 'default1'), (2, 3, NULL), (1, NULL, NULL), (0, 3, 'default1'), (3, NULL, 'A'), (4, NULL, 'C'), (5, 1, 'default2'), (6, -1, 'B'), (7, 2, 'C'), (8, 3, 'default2'), (9, 2, 'C'), (10, -1, 'A'), (11, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(-1, 'A')
*/

-- Prediction Query
SELECT DISTINCT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C LEFT JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE NOT C.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') AND C.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND C.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B');

/*
Prediction Result:
*/