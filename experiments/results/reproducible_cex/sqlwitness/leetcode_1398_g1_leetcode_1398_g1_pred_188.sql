-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'C'), (0, 'default2'), (2, NULL), (-1, 'default1'), (3, NULL), (4, 'C'), (5, 'B'), (6, 'A'), (7, 'C'), (8, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, NULL, 'default1'), (0, NULL, 'A'), (1, 5, NULL), (2, 4, 'default2'), (3, 0, 'C'), (4, 2, 'A'), (5, 7, NULL), (6, 7, 'B'), (7, 7, NULL), (8, 0, 'B'), (9, -1, NULL), (10, 2, NULL), (11, 2, 'B'), (12, 0, 'A'), (13, 5, 'default2'), (14, -1, 'C'), (15, 3, 'default1'), (16, 2, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(2, None)
*/

-- Prediction Query
WITH AB AS (SELECT C.CUSTOMER_ID AS ID, C.CUSTOMER_NAME AS NAME FROM CUSTOMERS AS C JOIN ORDERS AS O ON O.CUSTOMER_ID = C.CUSTOMER_ID JOIN ORDERS AS O2 ON O2.CUSTOMER_ID = C.CUSTOMER_ID WHERE O.PRODUCT_NAME = 'A' AND O2.PRODUCT_NAME = 'B'), HAVEC AS (SELECT C2.CUSTOMER_ID AS ID2, C2.CUSTOMER_NAME AS NAME2 FROM CUSTOMERS AS C2 JOIN ORDERS AS O4 ON O4.CUSTOMER_ID = C2.CUSTOMER_ID WHERE O4.PRODUCT_NAME = 'C'), JOINER AS (SELECT * FROM AB LEFT JOIN HAVEC ON AB.ID = HAVEC.ID2) SELECT ID AS CUSTOMER_ID, NAME AS CUSTOMER_NAME FROM JOINER WHERE ID2 IS NULL;

/*
Prediction Result:
(2, None)
(2, None)
*/