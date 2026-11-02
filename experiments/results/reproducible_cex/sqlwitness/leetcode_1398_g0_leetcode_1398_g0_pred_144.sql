-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'B'), (0, 'default1'), (2, 'B'), (3, 'default1'), (4, 'C'), (5, NULL), (6, NULL), (7, 'C'), (8, 'C'), (9, 'B'), (10, 'default1'), (11, 'B'), (12, 'default1'), (13, 'C'), (14, 'default2'), (15, 'default1'), (16, NULL), (17, 'default1'), (18, NULL), (19, 'A'), (20, 'default1'), (21, 'default1'), (22, 'C'), (23, 'B'), (24, 'A'), (25, 'C'), (26, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 19, 'default1'), (1, 24, 'default2'), (2, 24, 'C'), (3, 16, 'A'), (4, 17, 'B'), (5, 8, 'B'), (6, 15, 'A'), (7, 6, 'C'), (8, 17, 'default2'), (9, 22, 'B'), (10, 13, 'A'), (11, 14, 'C'), (12, 6, 'default1'), (13, 15, 'B'), (14, 15, 'C'), (15, 11, 'C'), (16, 14, 'default2'), (17, 17, 'default1'), (18, 2, NULL), (19, 15, 'default2'), (20, 9, 'C'), (21, 4, 'A'), (22, NULL, 'default2'), (23, 2, 'default1'), (24, 23, NULL), (25, 2, 'B'), (26, 26, 'default2'), (27, 24, 'B'), (28, 0, NULL), (29, 9, 'A'), (30, 6, NULL), (31, 21, 'A'), (32, 2, NULL), (33, 2, 'A'), (34, 2, 'default1'), (35, 25, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(2, 'B')
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT A.CUSTOMER_ID FROM (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AS A INNER JOIN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID WHERE NOT A.CUSTOMER_ID IN ((SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C')));

/*
Prediction Result:
(2, 'B')
(15, 'default1')
*/