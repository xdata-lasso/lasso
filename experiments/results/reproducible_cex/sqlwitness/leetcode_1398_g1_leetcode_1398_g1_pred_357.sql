-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'C'), (2, 'C'), (-1, 'C'), (1, 'default2'), (3, 'default1'), (4, 'C'), (5, NULL), (6, 'A'), (7, NULL), (8, 'C'), (9, 'A'), (10, 'B'), (11, 'default1'), (12, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, -1, NULL), (2, 0, 'C'), (-1, 10, 'B'), (1, NULL, 'B'), (3, 9, 'B'), (4, 0, 'A'), (5, 11, 'default1'), (6, 11, 'default2'), (7, 3, 'B'), (8, 8, NULL), (9, 9, 'A'), (10, 8, 'default2'), (11, 6, 'default1'), (12, 7, NULL), (13, NULL, NULL), (14, 11, NULL), (15, 7, 'A'), (16, NULL, 'C'), (17, 3, NULL), (18, 10, 'default2'), (19, 0, 'A'), (20, -1, 'C'), (21, 3, 'B'), (22, 9, 'default1'), (23, 5, NULL), (24, -1, NULL), (25, 0, 'default1'), (26, 10, NULL), (27, 10, NULL), (28, 4, 'A'), (29, 4, 'default1'), (30, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(9, 'A')
*/

-- Prediction Query
SELECT DISTINCT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE C.CUSTOMER_ID IN (SELECT O1.CUSTOMER_ID FROM ORDERS AS O1 WHERE O1.PRODUCT_NAME = 'A') AND C.CUSTOMER_ID IN (SELECT O2.CUSTOMER_ID FROM ORDERS AS O2 WHERE O2.PRODUCT_NAME = 'B') AND NOT C.CUSTOMER_ID IN (SELECT O3.CUSTOMER_ID FROM ORDERS AS O3 WHERE O3.PRODUCT_NAME = 'C') ORDER BY C.CUSTOMER_ID, C.CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
*/