-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, NULL), (0, NULL), (2, 'default2'), (3, 'default1'), (4, 'default1'), (5, 'default2'), (6, 'C'), (7, 'B'), (8, 'A'), (9, NULL), (10, 'A'), (11, 'B'), (12, 'B'), (13, 'C'), (14, NULL), (15, 'A'), (16, 'C'), (17, 'B'), (18, 'default1'), (19, 'B'), (20, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 15, 'default2'), (1, 20, 'default2'), (2, 6, 'C'), (3, 16, NULL), (4, 14, 'A'), (5, 11, 'B'), (6, 13, 'B'), (7, 13, 'A'), (8, 20, 'default1'), (9, 19, 'C'), (10, 10, 'default2'), (11, 11, NULL), (12, 3, NULL), (13, 17, NULL), (14, 8, 'default1'), (15, 15, 'C'), (16, 6, 'default1'), (17, 6, 'default2'), (18, 8, 'A'), (19, 9, 'default1'), (20, 8, 'B'), (21, 3, 'C'), (22, 0, NULL), (23, 17, 'default1'), (24, 2, 'A'), (25, 3, 'B'), (26, 2, 'default1'), (27, 5, 'default1'), (28, 9, 'default2'), (29, 1, NULL), (30, 15, 'B'), (31, 12, 'default2'), (32, 6, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(8, 'A')
(13, 'C')
*/

-- Prediction Query
SELECT DISTINCT SUB.A AS CUSTOMER_ID, SUB.B AS CUSTOMER_NAME FROM (SELECT O.CUSTOMER_ID AS A, C.CUSTOMER_NAME AS B, O.PRODUCT_NAME AS C FROM CUSTOMERS AS C JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE C.CUSTOMER_ID IN (SELECT O1.CUSTOMER_ID FROM (SELECT CUSTOMER_ID FROM ORDERS AS O WHERE PRODUCT_NAME = 'A') AS O1 JOIN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AS T1 ON O1.CUSTOMER_ID = T1.CUSTOMER_ID) AND NOT C.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C')) AS SUB;

/*
Prediction Result:
(13, 'C')
(8, 'A')
*/