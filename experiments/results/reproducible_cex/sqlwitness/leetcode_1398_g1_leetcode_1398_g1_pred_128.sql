-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, NULL), (1, 'default1'), (-1, NULL), (0, 'default1'), (3, 'default2'), (4, 'default2'), (5, 'B'), (6, 'C'), (7, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, -1, 'default2'), (2, 7, NULL), (-1, 6, 'B'), (0, -1, 'default1'), (3, 3, 'B'), (4, 0, 'B'), (5, -1, 'default2'), (6, 6, 'A'), (7, 3, 'A'), (8, 3, 'B'), (9, 2, 'A'), (10, 3, 'default1'), (11, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(3, 'default2')
(6, 'C')
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE O.PRODUCT_NAME = 'A' AND C.CUSTOMER_ID IN (SELECT B.CUSTOMER_ID FROM ORDERS AS B WHERE B.PRODUCT_NAME = 'B') AND NOT C.CUSTOMER_ID IN (SELECT C1.CUSTOMER_ID FROM ORDERS AS C1 WHERE C1.PRODUCT_NAME = 'C');

/*
Prediction Result:
(6, 'C')
(3, 'default2')
*/