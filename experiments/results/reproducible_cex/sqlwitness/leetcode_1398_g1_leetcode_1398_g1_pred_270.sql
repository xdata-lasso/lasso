-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default1'), (2, 'B'), (-1, 'default1'), (1, 'default1'), (3, 'A'), (4, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 4, 'default1'), (-1, 3, 'C'), (0, 0, 'default2'), (1, 4, NULL), (3, -1, 'default2'), (4, -1, 'C'), (5, 1, NULL), (6, 4, 'default1'), (7, 0, 'default2'), (8, 2, 'default2'), (9, -1, 'C'), (10, -1, NULL), (11, 4, NULL), (12, 4, 'C'), (13, 2, 'B'), (14, 3, 'C'), (15, NULL, 'A'), (16, 4, 'default2'), (17, -1, 'default1'), (18, NULL, 'B'), (19, 1, 'A'), (20, NULL, 'C'), (21, 1, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'default1')
*/

-- Prediction Query
SELECT DISTINCT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM ORDERS AS O LEFT OUTER JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE C.CUSTOMER_ID IN (SELECT A.CUSTOMER_ID FROM ORDERS AS A WHERE A.PRODUCT_NAME = 'A') AND C.CUSTOMER_ID IN (SELECT B.CUSTOMER_ID FROM ORDERS AS B WHERE B.PRODUCT_NAME = 'B') AND NOT C.CUSTOMER_ID IN (SELECT C.CUSTOMER_ID FROM ORDERS AS C WHERE C.PRODUCT_NAME = 'C') ORDER BY 1, C.CUSTOMER_ID NULLS LAST, C.CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
*/