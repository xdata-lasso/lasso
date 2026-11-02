-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default2'), (1, 'B'), (2, 'default1'), (3, NULL), (4, NULL), (5, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 3, 'A'), (0, 4, 'A'), (2, 4, 'C'), (3, 2, 'C'), (4, NULL, NULL), (5, NULL, NULL), (6, 2, 'C'), (7, 5, 'default1'), (8, 3, 'C'), (9, 2, NULL), (10, 3, 'C'), (11, NULL, 'B'), (12, 3, 'C'), (13, 5, 'default1'), (14, 1, 'B'), (15, 2, NULL), (16, 4, 'default2'), (17, NULL, NULL), (18, 3, 'C'), (19, 4, NULL), (20, 1, 'A'), (21, 0, 'B'), (22, 1, 'default2'), (23, 5, 'B'), (24, 3, 'A'), (25, 2, 'B'), (26, 2, 'A'), (27, 4, 'B'), (28, 0, 'default1'), (29, 0, 'A'), (30, NULL, NULL), (31, 2, 'default1'), (32, 4, 'B'), (33, 3, NULL), (34, NULL, 'default1'), (35, 2, 'default2'), (36, 5, NULL), (37, 3, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(0, 'default2')
(1, 'B')
*/

-- Prediction Query
WITH A AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A' AND CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C')) SELECT DISTINCT A.CUSTOMER_ID, C.CUSTOMER_NAME FROM A LEFT JOIN CUSTOMERS AS C ON A.CUSTOMER_ID = C.CUSTOMER_ID;

/*
Prediction Result:
(1, 'B')
(0, 'default2')
*/