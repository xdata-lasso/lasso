-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'B'), (0, 'default2'), (2, 'B'), (3, 'B'), (4, NULL), (5, 'default1'), (6, 'default1'), (7, 'A'), (8, 'B'), (9, NULL), (10, 'B'), (11, 'B'), (12, 'default2'), (13, NULL), (14, 'B'), (15, 'default1'), (16, NULL), (17, 'default1'), (18, 'B'), (19, 'default1'), (20, 'default1'), (21, 'A'), (22, 'B'), (23, 'C'), (24, 'default1'), (25, 'A'), (26, 'default1'), (27, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 25, 'A'), (0, 23, 'A'), (2, 27, NULL), (3, 17, NULL), (4, 26, 'default1'), (5, 18, 'default2'), (6, 18, 'C'), (7, 1, 'B'), (8, 12, 'B'), (9, 27, 'A'), (10, 25, 'B'), (11, NULL, 'default2'), (12, 13, NULL), (13, 25, 'C'), (14, 22, 'C'), (15, 12, 'A'), (16, 27, 'B'), (17, 11, 'default2'), (18, 13, NULL), (19, 19, 'A'), (20, 26, 'C'), (21, 26, 'default1'), (22, 23, 'B'), (23, NULL, NULL), (24, 22, 'B'), (25, 15, 'default2'), (26, 12, 'B'), (27, 3, NULL), (28, 21, NULL), (29, 6, NULL), (30, 4, 'default2'), (31, 13, 'A'), (32, 2, 'C'), (33, 2, 'A'), (34, 0, 'C'), (35, 7, 'default1'), (36, 23, 'default2'), (37, 16, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(12, 'default2')
(23, 'C')
(27, 'A')
*/

-- Prediction Query
SELECT DISTINCT ORDERS.CUSTOMER_ID, CUSTOMERS.CUSTOMER_NAME FROM ORDERS JOIN CUSTOMERS ON ORDERS.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID WHERE PRODUCT_NAME = 'A' AND ORDERS.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT ORDERS.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(23, 'C')
(27, 'A')
(12, 'default2')
*/