-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'B'), (0, 'C'), (2, 'default2'), (3, 'C'), (4, 'C'), (5, 'default1'), (6, 'default1'), (7, 'B'), (8, 'C'), (9, 'A'), (10, 'A'), (11, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 3, 'B'), (1, 3, NULL), (2, 2, 'default1'), (3, 7, 'C'), (4, 11, NULL), (5, 9, NULL), (6, 5, 'C'), (7, 6, 'A'), (8, 1, 'default2'), (9, 2, 'default2'), (10, 4, 'A'), (11, 2, 'default2'), (12, 8, NULL), (13, 5, 'B'), (14, 10, NULL), (15, 0, 'A'), (16, 11, 'C'), (17, 6, 'C'), (18, 2, 'default1'), (19, 5, 'B'), (20, 3, 'default1'), (21, 1, 'default2'), (22, 3, 'default1'), (23, 9, 'default2'), (24, 3, 'A'), (25, NULL, 'default1'), (26, 5, 'B'), (27, 8, 'A'), (28, 9, 'A'), (29, 5, 'B'), (30, 7, 'C'), (31, NULL, 'default2'), (32, 9, 'default2'), (33, 3, 'B'), (34, 5, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(3, 'C')
*/

-- Prediction Query
WITH AB AS (SELECT C.CUSTOMER_ID AS ID, C.CUSTOMER_NAME AS NAME FROM CUSTOMERS AS C JOIN ORDERS AS O ON O.CUSTOMER_ID = C.CUSTOMER_ID JOIN ORDERS AS O2 ON O2.CUSTOMER_ID = C.CUSTOMER_ID WHERE O.PRODUCT_NAME = 'A' AND O2.PRODUCT_NAME = 'B'), HAVEC AS (SELECT C2.CUSTOMER_ID AS ID2, C2.CUSTOMER_NAME AS NAME2 FROM CUSTOMERS AS C2 JOIN ORDERS AS O4 ON O4.CUSTOMER_ID = C2.CUSTOMER_ID WHERE O4.PRODUCT_NAME = 'C'), JOINER AS (SELECT * FROM AB LEFT JOIN HAVEC ON AB.ID = HAVEC.ID2) SELECT ID AS CUSTOMER_ID, NAME AS CUSTOMER_NAME FROM JOINER WHERE ID2 IS NULL;

/*
Prediction Result:
(3, 'C')
(3, 'C')
*/