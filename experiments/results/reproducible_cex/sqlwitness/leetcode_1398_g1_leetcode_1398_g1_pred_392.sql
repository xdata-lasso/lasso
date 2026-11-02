-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, NULL), (3, 'C'), (0, 'C'), (-1, 'A'), (1, 'B'), (4, NULL), (5, 'default1'), (6, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 0, NULL), (1, 2, 'A'), (3, -1, NULL), (-1, NULL, 'C'), (0, -1, 'default2'), (4, 1, 'C'), (5, 4, 'B'), (6, 1, 'B'), (7, 2, 'default2'), (8, 0, 'B'), (9, -1, NULL), (10, 0, 'A'), (11, 2, 'B'), (12, 4, 'default1'), (13, NULL, 'default1'), (14, 1, 'B'), (15, 4, 'default1'), (16, 6, 'C'), (17, 5, 'A'), (18, 2, 'default2'), (19, NULL, 'default1'), (20, 2, 'default1'), (21, 0, 'default1'), (22, 5, 'default2'), (23, -1, 'B'), (24, -1, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(-1, 'A')
(0, 'C')
(2, None)
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE PRODUCT_NAME = 'A' AND C.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT C.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') GROUP BY 1, 2;

/*
Prediction Result:
*/