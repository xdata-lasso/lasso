-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'B'), (1, 'default1'), (-1, NULL), (0, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 0, 'default1'), (-1, 2, 'default2'), (0, NULL, 'C'), (2, 1, 'default1'), (3, 2, 'B'), (4, -1, 'C'), (5, 0, 'C'), (6, NULL, 'B'), (7, 0, 'C'), (8, 2, 'B'), (9, -1, 'default2'), (10, 0, 'default2'), (11, -1, 'B'), (12, 0, 'A'), (13, 0, NULL), (14, -1, 'default2'), (15, 2, 'A'), (16, 2, NULL), (17, NULL, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(2, 'B')
*/

-- Prediction Query
SELECT DISTINCT A.CUSTOMER_ID, C.CUSTOMER_NAME FROM (SELECT O1.CUSTOMER_ID FROM ORDERS AS O1 WHERE O1.PRODUCT_NAME = 'A') AS A JOIN (SELECT O2.CUSTOMER_ID FROM ORDERS AS O2 WHERE O2.PRODUCT_NAME = 'B') AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID JOIN CUSTOMERS AS C ON A.CUSTOMER_ID = C.CUSTOMER_ID WHERE NOT A.CUSTOMER_ID IN (SELECT O3.CUSTOMER_ID FROM ORDERS AS O3 WHERE O3.PRODUCT_NAME = 'C');

/*
Prediction Result:
*/