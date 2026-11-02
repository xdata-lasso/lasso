-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'A'), (0, 'C'), (2, 'default1'), (3, 'B'), (4, NULL), (5, 'B'), (6, NULL), (7, 'default1'), (8, 'default2'), (9, 'default1'), (10, 'default2'), (11, 'B'), (12, 'default2'), (13, 'A'), (14, 'default2'), (15, 'A'), (16, 'C'), (17, 'A'), (18, 'C'), (19, 'default1'), (20, NULL), (21, 'default2'), (22, 'A'), (23, 'default1'), (24, 'B'), (25, 'A'), (26, 'A'), (27, 'A'), (28, NULL), (29, 'B'), (30, NULL), (31, 'B'), (32, 'B'), (33, 'B'), (34, NULL), (35, NULL), (36, NULL), (37, NULL), (38, NULL), (39, 'default2'), (40, 'B'), (41, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 25, 'default2'), (1, 7, 'B'), (2, 25, 'C'), (3, 1, 'default2'), (4, 31, 'B'), (5, 40, 'A'), (6, 15, 'C'), (7, 30, 'A'), (8, 10, 'default2'), (9, 37, 'default1'), (10, 25, 'default1'), (11, 7, 'B'), (12, 33, 'C'), (13, 1, 'B'), (14, 40, 'B'), (15, 4, 'default1'), (16, 33, NULL), (17, 3, 'A'), (18, 38, 'default1'), (19, 3, 'default2'), (20, 32, 'C'), (21, 28, 'default1'), (22, 38, 'default2'), (23, 19, 'C'), (24, 6, NULL), (25, 13, 'B'), (26, 13, 'A'), (27, 22, NULL), (28, 18, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(13, 'A')
(40, 'B')
*/

-- Prediction Query
SELECT DISTINCT O.CUSTOMER_ID, C.CUSTOMER_NAME FROM ORDERS AS O JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID WHERE (O.CUSTOMER_ID, 'A') IN (SELECT DISTINCT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS) AND (O.CUSTOMER_ID, 'B') IN (SELECT DISTINCT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS) AND NOT (O.CUSTOMER_ID, 'C') IN (SELECT DISTINCT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS);

/*
Prediction Result:
(40, 'B')
(13, 'A')
*/