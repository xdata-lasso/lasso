-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'B'), (1, 'B'), (2, 'default2'), (3, 'default1'), (4, 'default2'), (5, 'default1'), (6, 'A'), (7, 'default1'), (8, NULL), (9, 'B'), (10, 'default2'), (11, 'B'), (12, 'C'), (13, 'default1'), (14, 'B'), (15, 'C'), (16, 'default1'), (17, NULL), (18, 'B'), (19, 'A'), (20, 'default2'), (21, 'C'), (22, 'C'), (23, 'B'), (24, 'B'), (25, 'C'), (26, 'B'), (27, 'B'), (28, 'A'), (29, 'default2'), (30, 'default1'), (31, 'A'), (32, 'A'), (33, NULL), (34, 'C'), (35, 'A'), (36, 'default2'), (37, 'default2'), (38, 'B'), (39, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 35, 'C'), (0, 6, 'B'), (2, 27, 'A'), (3, 29, 'A'), (4, 32, 'C'), (5, 7, 'C'), (6, 8, 'B'), (7, 33, 'C'), (8, 23, 'default2'), (9, 1, 'A'), (10, 33, NULL), (11, 38, NULL), (12, 26, 'A'), (13, 10, NULL), (14, 16, 'B'), (15, 23, 'default1'), (16, 2, 'A'), (17, 1, 'B'), (18, 2, 'default1'), (19, 12, 'default1'), (20, 29, 'default1'), (21, 11, 'C'), (22, 23, 'B'), (23, 12, 'C'), (24, 6, 'default1'), (25, 26, 'B'), (26, 30, 'default1'), (27, 21, 'default1'), (28, 24, 'A'), (29, 5, 'A'), (30, 28, 'default1'), (31, 34, 'default2'), (32, 13, NULL), (33, 26, NULL), (34, 3, NULL), (35, 8, NULL), (36, 12, 'default1'), (37, 5, 'B'), (38, 26, 'C'), (39, 9, NULL), (40, 21, NULL), (41, 29, NULL), (42, 15, 'B'), (43, 20, 'A'), (44, 27, 'B'), (45, NULL, 'default2'), (46, 26, 'default2'), (47, 34, 'C'), (48, 3, 'C'), (49, 24, 'A'), (50, 0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'B')
(5, 'default1')
(27, 'B')
*/

-- Prediction Query
WITH A AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A'), B AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') SELECT CUSTOMERS.CUSTOMER_ID, CUSTOMERS.CUSTOMER_NAME FROM A CROSS JOIN B CROSS JOIN CUSTOMERS WHERE A.CUSTOMER_ID = B.CUSTOMER_ID AND A.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID AND NOT CUSTOMERS.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(27, 'B')
(1, 'B')
(5, 'default1')
*/