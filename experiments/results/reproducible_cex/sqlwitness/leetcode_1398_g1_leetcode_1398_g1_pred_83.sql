-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'C'), (1, 'B'), (2, 'C'), (0, 'default2'), (3, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 2, 'B'), (-1, 3, 'A'), (0, -1, 'A'), (1, 2, NULL), (3, -1, NULL), (4, 1, 'default1'), (5, 3, NULL), (6, 3, 'B'), (7, NULL, 'default2'), (8, -1, 'C'), (9, 2, 'A'), (10, 2, 'default1'), (11, 1, 'C'), (12, -1, 'default1'), (13, 0, 'B'), (14, 0, 'B'), (15, NULL, NULL), (16, 2, 'A'), (17, 3, 'default2'), (18, 1, 'C'), (19, NULL, 'A'), (20, NULL, 'default2'), (21, 2, 'A'), (22, 1, 'A'), (23, 1, 'default2'), (24, 2, 'B'), (25, 1, 'C'), (26, 3, 'B'), (27, 2, 'default2'), (28, 0, 'default1'), (29, 1, 'default1'), (30, 1, 'B'), (31, 3, 'B'), (32, 1, NULL), (33, -1, 'B'), (34, -1, NULL), (35, NULL, 'C'), (36, -1, 'A'), (37, 3, 'A'), (38, 0, 'B'), (39, 1, 'default1'), (40, 3, 'B'), (41, 1, NULL), (42, -1, 'default1'), (43, NULL, 'default1'), (44, 3, 'B'), (45, 3, 'A'), (46, NULL, NULL), (47, 0, 'A'), (48, -1, 'default2'), (49, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(0, 'default2')
(2, 'C')
(3, 'C')
*/

-- Prediction Query
WITH A AS (SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE O.PRODUCT_NAME = 'A'), B AS (SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE O.PRODUCT_NAME = 'B'), C AS (SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE O.PRODUCT_NAME = 'C') SELECT A.CUSTOMER_ID, A.CUSTOMER_NAME FROM A JOIN B ON A.CUSTOMER_ID = B.CUSTOMER_ID LEFT JOIN C ON A.CUSTOMER_ID = C.CUSTOMER_ID WHERE C.CUSTOMER_ID IS NULL;

/*
Prediction Result:
(3, 'C')
(3, 'C')
(3, 'C')
(3, 'C')
(3, 'C')
(2, 'C')
(2, 'C')
(2, 'C')
(2, 'C')
(2, 'C')
(2, 'C')
(3, 'C')
(3, 'C')
(3, 'C')
(3, 'C')
(3, 'C')
(3, 'C')
(3, 'C')
(3, 'C')
(3, 'C')
(3, 'C')
(0, 'default2')
(0, 'default2')
(0, 'default2')
*/