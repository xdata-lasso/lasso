-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'A'), (1, 'A'), (2, NULL), (-1, 'B'), (3, 'C'), (4, 'default1'), (5, 'A'), (6, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 5, NULL), (1, 0, 'default1'), (0, -1, 'A'), (-1, 5, 'B'), (3, 3, 'C'), (4, 3, NULL), (5, 2, 'default1'), (6, 4, 'C'), (7, 4, 'default1'), (8, 2, NULL), (9, 1, 'B'), (10, NULL, NULL), (11, NULL, 'C'), (12, 2, 'B'), (13, 6, 'default2'), (14, -1, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(-1, 'B')
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS AS O LEFT JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID WHERE PRODUCT_NAME = 'A' AND C.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT C.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
*/