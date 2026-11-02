-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'C'), (0, 'default1'), (1, 'B'), (-1, 'C'), (3, 'default2'), (4, 'default1'), (5, 'B'), (6, 'A'), (7, 'default1'), (8, NULL), (9, 'C'), (10, 'A'), (11, 'A'), (12, 'C'), (13, 'default2'), (14, 'B'), (15, 'A'), (16, 'B'), (17, 'B'), (18, NULL), (19, 'B'), (20, 'default1'), (21, 'A'), (22, 'B'), (23, 'C'), (24, 'default1'), (25, NULL), (26, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 6, 'default1'), (0, 10, 'default2'), (-1, 4, 'A'), (2, 11, 'C'), (3, 11, 'B'), (4, 0, 'A'), (5, -1, 'B'), (6, 10, 'B'), (7, 8, 'A'), (8, 15, 'B'), (9, 22, 'B'), (10, 0, 'C'), (11, 11, 'default2'), (12, NULL, 'default2'), (13, 16, 'default1'), (14, 0, 'default1'), (15, 1, 'default1'), (16, 16, 'B'), (17, 3, 'default1'), (18, 11, 'default1'), (19, 9, 'default1'), (20, 1, 'default1'), (21, 10, 'A'), (22, 25, 'A'), (23, 18, 'default1'), (24, 20, NULL), (25, 11, 'A'), (26, 6, NULL), (27, 11, 'default1'), (28, 23, 'A'), (29, 23, 'B'), (30, 17, 'A'), (31, 25, 'C'), (32, 20, 'default1'), (33, 23, NULL), (34, NULL, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(10, 'A')
(23, 'C')
*/

-- Prediction Query
SELECT DISTINCT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O ON O.CUSTOMER_ID = C.CUSTOMER_ID WHERE C.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME IN ('A', 'B') GROUP BY CUSTOMER_ID HAVING COUNT(*) > 1) AND NOT C.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
*/