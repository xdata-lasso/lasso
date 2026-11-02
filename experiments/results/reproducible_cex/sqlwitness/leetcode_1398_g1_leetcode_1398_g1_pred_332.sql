-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (3, NULL), (1, 'default2'), (2, 'B'), (-1, 'A'), (0, 'C'), (4, 'C'), (5, 'default2'), (6, 'B'), (7, 'C'), (8, NULL), (9, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 7, 'C'), (2, 0, 'B'), (1, 0, NULL), (3, 8, NULL), (0, NULL, 'default1'), (4, 8, 'A'), (5, 2, 'A'), (6, 1, 'B'), (7, 4, NULL), (8, 6, 'A'), (9, 9, 'B'), (10, -1, 'C'), (11, 8, 'default2'), (12, 3, 'default2'), (13, -1, 'default1'), (14, 6, 'C'), (15, 2, 'default1'), (16, 3, NULL), (17, 7, 'C'), (18, 3, 'C'), (19, 6, 'default2'), (20, 1, 'B'), (21, 8, 'default1'), (22, 5, NULL), (23, 3, 'default1'), (24, 0, 'C'), (25, 9, 'C'), (26, 2, 'B'), (27, 6, 'B'), (28, 0, 'B'), (29, NULL, 'C'), (30, 9, NULL), (31, 8, 'A'), (32, 1, 'C'), (33, 4, 'B'), (34, 0, NULL), (35, 6, 'C'), (36, 4, NULL), (37, 6, 'B'), (38, 2, 'B'), (39, NULL, 'B'), (40, NULL, 'C'), (41, 8, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(2, 'B')
(8, None)
*/

-- Prediction Query
SELECT * FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT C.CUSTOMER_ID FROM CUSTOMERS AS C LEFT JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE PRODUCT_NAME = 'A' OR PRODUCT_NAME = 'B' GROUP BY C.CUSTOMER_ID HAVING COUNT(DISTINCT PRODUCT_NAME) = 2) AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Prediction Result:
*/