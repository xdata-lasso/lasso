-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'C'), (1, NULL), (2, NULL), (3, 'A'), (4, 'A'), (5, 'A'), (6, 'B'), (7, 'default1'), (8, 'C'), (9, 'C'), (10, NULL), (11, NULL), (12, NULL), (13, 'default2'), (14, 'B'), (15, 'C'), (16, 'B'), (17, 'A'), (18, 'default2'), (19, 'default1'), (20, 'default2'), (21, 'C'), (22, 'default1'), (23, 'default2'), (24, 'default2'), (25, NULL), (26, 'C'), (27, NULL), (28, NULL), (29, 'default1'), (30, 'default1'), (31, 'A'), (32, 'A'), (33, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 24, 'default1'), (1, 29, 'B'), (2, 11, 'A'), (3, 11, 'C'), (4, 19, 'default2'), (5, 13, 'A'), (6, 14, 'default1'), (7, 24, 'default2'), (8, 8, NULL), (9, 33, 'B'), (10, 8, 'default1'), (11, 11, 'B'), (12, 27, 'default2'), (13, 15, 'A'), (14, 18, 'default2'), (15, 9, NULL), (16, 31, 'B'), (17, 0, 'C'), (18, 21, 'B'), (19, 31, 'A'), (20, 11, 'default1'), (21, 32, 'default1'), (22, 18, NULL), (23, 16, NULL), (24, 12, NULL), (25, 14, 'B'), (26, 3, 'C'), (27, 16, 'A'), (28, 24, 'default2'), (29, 3, 'C'), (30, 21, 'A'), (31, 27, 'B'), (32, 5, 'default2'), (33, 17, NULL), (34, 2, 'default1'), (35, 29, 'B'), (36, 14, 'C'), (37, 30, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(21, 'C')
(31, 'A')
*/

-- Prediction Query
SELECT DISTINCT A.CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT * FROM ORDERS WHERE PRODUCT_NAME = 'A') AS A JOIN (SELECT * FROM ORDERS WHERE PRODUCT_NAME = 'B') AS B USING (CUSTOMER_ID) JOIN CUSTOMERS USING (CUSTOMER_ID) WHERE NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(31, 'A')
(21, 'C')
*/