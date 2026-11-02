-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'B'), (2, 'default1'), (1, NULL), (0, NULL), (3, 'A'), (4, 'default1'), (5, 'A'), (6, NULL), (7, 'A'), (8, 'default1'), (9, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 7, 'C'), (-1, 3, 'C'), (1, -1, 'default2'), (0, 1, 'default2'), (3, -1, NULL), (4, 8, 'default2'), (5, -1, 'B'), (6, 1, 'C'), (7, 6, 'C'), (8, 7, 'C'), (9, 0, NULL), (10, 4, NULL), (11, 1, 'A'), (12, 4, 'default2'), (13, 1, 'B'), (14, 5, NULL), (15, NULL, NULL), (16, 4, 'default2'), (17, 8, 'default1'), (18, 9, 'default2'), (19, 2, 'B'), (20, 8, 'A'), (21, 1, 'C'), (22, 9, 'C'), (23, 8, 'B'), (24, -1, 'A'), (25, 0, 'default1'), (26, 5, 'B'), (27, NULL, 'C'), (28, 5, 'A'), (29, 2, 'A'), (30, 7, 'default2'), (31, 5, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(-1, 'B')
(2, 'default1')
(5, 'A')
(8, 'default1')
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS AS C CROSS JOIN ORDERS AS O WHERE C.CUSTOMER_ID = O.CUSTOMER_ID AND C.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND C.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT C.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') GROUP BY 1 ORDER BY 1, C.CUSTOMER_ID NULLS LAST, CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
*/