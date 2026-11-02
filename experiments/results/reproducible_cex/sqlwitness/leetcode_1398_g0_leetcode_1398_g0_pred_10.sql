-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'C'), (1, 'default1'), (2, 'default2'), (3, NULL), (4, 'default2'), (5, 'B'), (6, 'C'), (7, NULL), (8, NULL), (9, 'default1'), (10, 'default2'), (11, 'default2'), (12, 'default2'), (13, 'B'), (14, 'default2'), (15, 'default1'), (16, 'B'), (17, 'B'), (18, 'B'), (19, 'B'), (20, 'default1'), (21, 'B'), (22, 'B'), (23, 'A'), (24, NULL), (25, NULL), (26, 'default2'), (27, NULL), (28, 'default2'), (29, 'default1'), (30, 'A'), (31, 'C'), (32, NULL), (33, 'B'), (34, 'default2'), (35, NULL), (36, 'default1'), (37, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 1, NULL), (1, 25, 'B'), (2, 21, 'B'), (3, 5, 'default1'), (4, 32, NULL), (5, 29, NULL), (6, 35, 'A'), (7, 17, NULL), (8, 16, 'default2'), (9, 25, 'A'), (10, 30, 'C'), (11, 25, 'C'), (12, 11, 'B'), (13, 3, 'default1'), (14, 5, NULL), (15, 16, NULL), (16, 23, 'default1'), (17, 2, NULL), (18, 3, 'A'), (19, 35, 'B'), (20, 11, 'A'), (21, 35, 'default2'), (22, 3, 'default1'), (23, 8, 'default2'), (24, 8, 'default2'), (25, 23, 'default2'), (26, 2, 'C'), (27, 11, NULL), (28, 9, NULL), (29, 33, 'C'), (30, 19, 'default1'), (31, 31, NULL), (32, 5, NULL), (33, 11, 'B'), (34, 3, 'B'), (35, 33, 'default2'), (36, 0, NULL), (37, 32, 'default2'), (38, 13, NULL), (39, 26, NULL), (40, 37, 'C'), (41, 3, 'default2'), (42, 22, 'C'), (43, 35, 'B'), (44, 0, 'C'), (45, 2, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(3, None)
(11, 'default2')
(35, None)
*/

-- Prediction Query
SELECT DISTINCT A.CUSTOMER_ID, C.CUSTOMER_NAME FROM (SELECT O1.CUSTOMER_ID FROM ORDERS AS O1 WHERE O1.PRODUCT_NAME = 'A') AS A JOIN (SELECT O2.CUSTOMER_ID FROM ORDERS AS O2 WHERE O2.PRODUCT_NAME = 'B') AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID JOIN CUSTOMERS AS C ON A.CUSTOMER_ID = C.CUSTOMER_ID WHERE NOT A.CUSTOMER_ID IN (SELECT O3.CUSTOMER_ID FROM ORDERS AS O3 WHERE O3.PRODUCT_NAME = 'C');

/*
Prediction Result:
(35, None)
(3, None)
(11, 'default2')
*/