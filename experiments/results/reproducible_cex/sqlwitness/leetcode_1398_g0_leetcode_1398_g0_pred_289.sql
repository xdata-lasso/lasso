-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'B'), (1, 'C'), (0, NULL), (2, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, NULL, 'default1'), (1, 2, 'B'), (-1, NULL, 'default1'), (2, 0, 'A'), (3, NULL, 'C'), (4, NULL, 'B'), (5, -1, 'default2'), (6, 0, NULL), (7, 1, 'C'), (8, 0, 'C'), (9, 1, 'default1'), (10, 0, 'default1'), (11, 1, 'A'), (12, 1, 'C'), (13, NULL, 'default2'), (14, -1, 'default1'), (15, -1, 'default1'), (16, 0, 'default2'), (17, 2, 'C'), (18, 2, 'default2'), (19, 1, 'default2'), (20, NULL, 'default1'), (21, 1, 'default2'), (22, 1, 'B'), (23, NULL, NULL), (24, 0, 'A'), (25, -1, 'B'), (26, -1, 'default2'), (27, -1, 'A'), (28, 0, 'A'), (29, 2, 'default1'), (30, -1, 'default2'), (31, NULL, 'default2'), (32, 1, NULL), (33, 2, 'B'), (34, 0, 'default1'), (35, NULL, 'default1'), (36, 2, 'C'), (37, 1, 'default1'), (38, 1, 'C'), (39, 1, NULL), (40, 0, 'A'), (41, 0, 'default1'), (42, 2, 'default1'), (43, 1, 'default1'), (44, 1, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT C.* FROM (SELECT O.CUSTOMER_ID, SUM(O.PRODUCT_NAME = 'A') AS A, SUM(O.PRODUCT_NAME = 'B') AS B, SUM(O.PRODUCT_NAME = 'C') AS C FROM ORDERS AS O GROUP BY O.CUSTOMER_ID) AS OO LEFT OUTER JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = OO.CUSTOMER_ID WHERE OO.A > 0 AND OO.B > 0 AND OO.C = 0;

/*
Prediction Result:
(-1, 'B')
*/