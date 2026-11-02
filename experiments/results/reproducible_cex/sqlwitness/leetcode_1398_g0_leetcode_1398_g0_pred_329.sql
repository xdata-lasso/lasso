-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'default2'), (0, 'A'), (1, 'A'), (2, 'default2'), (3, 'C'), (4, 'A'), (5, 'B'), (6, NULL), (7, NULL), (8, NULL), (9, NULL), (10, 'default1'), (11, NULL), (12, 'A'), (13, 'A'), (14, 'default1'), (15, NULL), (16, 'C'), (17, 'default1'), (18, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 3, 'default2'), (0, 3, 'default1'), (-1, 17, NULL), (2, 10, 'A'), (3, 13, 'default1'), (4, 1, 'default2'), (5, 1, 'default2'), (6, 11, 'default1'), (7, 15, 'B'), (8, 7, 'B'), (9, 11, 'default2'), (10, 18, 'B'), (11, 12, 'default2'), (12, 8, 'default2'), (13, 1, 'default1'), (14, 4, 'C'), (15, 18, 'default1'), (16, 3, 'B'), (17, 7, 'A'), (18, 15, 'A'), (19, 12, 'C'), (20, 18, 'B'), (21, NULL, 'C'), (22, 6, 'default2'), (23, 0, 'B'), (24, 1, 'default1'), (25, 5, 'B'), (26, 1, 'A'), (27, 10, 'B'), (28, 15, 'C'), (29, 12, 'B'), (30, 0, 'default1'), (31, 16, 'A'), (32, 7, 'A'), (33, 1, NULL), (34, 5, 'default1'), (35, 9, 'C'), (36, -1, 'default1'), (37, 9, 'default1'), (38, 8, 'default2'), (39, 8, 'B'), (40, 14, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT CUSTOMERS.CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS JOIN CUSTOMERS ON ORDERS.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID GROUP BY ORDERS.CUSTOMER_ID HAVING (SUM(PRODUCT_NAME = 'A') > 0 AND SUM(PRODUCT_NAME = 'B') > 0 AND SUM(PRODUCT_NAME = 'C') = 0);

/*
Prediction Result:
(7, None)
(10, 'default1')
*/