-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'default1'), (0, 'A'), (2, 'B'), (3, 'A'), (4, NULL), (5, 'default2'), (6, NULL), (7, 'B'), (8, NULL), (9, 'B'), (10, 'default2'), (11, 'default2'), (12, 'A'), (13, 'B'), (14, 'default1'), (15, 'A'), (16, 'B'), (17, 'default1'), (18, 'C'), (19, 'C'), (20, 'B'), (21, 'default2'), (22, 'A'), (23, 'default2'), (24, 'default2'), (25, 'default2'), (26, 'C'), (27, 'default1'), (28, 'A'), (29, 'B'), (30, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 30, 'C'), (0, 20, 'C'), (2, 7, NULL), (3, NULL, 'default1'), (4, 1, 'B'), (5, NULL, 'default2'), (6, 2, 'C'), (7, 3, 'default1'), (8, 7, 'default2'), (9, 26, 'A'), (10, 21, 'B'), (11, 18, 'C'), (12, 17, 'default1'), (13, 29, NULL), (14, 5, 'A'), (15, 9, 'C'), (16, 21, 'A'), (17, 6, 'C'), (18, 22, 'default1'), (19, 24, 'default2'), (20, 19, NULL), (21, 14, 'A'), (22, 10, NULL), (23, 1, NULL), (24, 27, 'B'), (25, 4, 'default2'), (26, 3, 'default1'), (27, 14, 'B'), (28, 15, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(14, 'default1')
(21, 'default2')
*/

-- Prediction Query
SELECT DISTINCT ORDERS.CUSTOMER_ID, CUSTOMERS.CUSTOMER_NAME FROM ORDERS INNER JOIN CUSTOMERS ON ORDERS.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID WHERE ORDERS.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND ORDERS.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT ORDERS.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(21, 'default2')
(14, 'default1')
*/