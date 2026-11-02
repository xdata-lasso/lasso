-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, NULL), (1, 'A'), (2, NULL), (0, 'A'), (3, 'A'), (4, 'A'), (5, 'C'), (6, 'C'), (7, 'default2'), (8, 'A'), (9, 'B'), (10, 'default2'), (11, 'default2'), (12, NULL), (13, 'A'), (14, 'B'), (15, 'B'), (16, 'default1'), (17, 'A'), (18, NULL), (19, 'default2'), (20, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 11, 'A'), (-1, 17, 'default2'), (1, 10, 'B'), (0, 16, 'B'), (3, 8, NULL), (4, 4, 'B'), (5, 1, 'C'), (6, 11, 'B'), (7, 3, NULL), (8, 8, NULL), (9, 13, 'default1'), (10, 15, 'C'), (11, 10, 'C'), (12, 16, NULL), (13, 12, 'default1'), (14, 3, NULL), (15, 13, 'B'), (16, 4, 'default1'), (17, 20, NULL), (18, 13, 'default2'), (19, 2, 'default1'), (20, 14, NULL), (21, 15, 'A'), (22, 7, 'A'), (23, 19, 'C'), (24, 3, 'A'), (25, 14, 'default2'), (26, 3, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(3, 'A')
(11, 'default2')
*/

-- Prediction Query
WITH BOUGHT_A AS (SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME, O.PRODUCT_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE O.PRODUCT_NAME = 'A'), BOUGHT_B AS (SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME, O.PRODUCT_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE O.PRODUCT_NAME = 'B'), BOUGHT_C AS (SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME, O.PRODUCT_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE O.PRODUCT_NAME = 'C') SELECT DISTINCT A.CUSTOMER_ID, A.CUSTOMER_NAME FROM BOUGHT_A AS A JOIN BOUGHT_B AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID WHERE NOT A.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM BOUGHT_C WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(11, 'default2')
(3, 'A')
*/