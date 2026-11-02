-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'A'), (0, 'default2'), (2, 'C'), (3, 'default1'), (4, 'B'), (5, 'default1'), (6, 'default2'), (7, 'A'), (8, 'default1'), (9, 'default1'), (10, 'A'), (11, 'default2'), (12, 'default1'), (13, 'B'), (14, 'A'), (15, 'C'), (16, 'B'), (17, NULL), (18, 'default2'), (19, 'default1'), (20, 'A'), (21, NULL), (22, 'A'), (23, NULL), (24, 'default1'), (25, 'B'), (26, 'A'), (27, NULL), (28, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 15, 'C'), (1, 23, 'A'), (2, 16, 'default2'), (3, 21, 'B'), (4, 20, 'B'), (5, 16, 'default2'), (6, 5, 'default1'), (7, 2, 'default2'), (8, 4, 'B'), (9, 28, 'B'), (10, 2, 'default2'), (11, 10, 'default1'), (12, 8, 'B'), (13, 23, 'B'), (14, 8, 'C'), (15, 24, 'C'), (16, 21, 'C'), (17, 2, NULL), (18, 13, 'default2'), (19, 18, 'default1'), (20, 6, 'default2'), (21, 12, 'B'), (22, 18, 'default1'), (23, 27, NULL), (24, 7, 'default2'), (25, 15, 'A'), (26, 4, 'default2'), (27, 17, 'default1'), (28, 4, 'B'), (29, 19, 'B'), (30, 3, 'C'), (31, 15, 'default1'), (32, 23, 'default2'), (33, 28, 'A'), (34, 5, 'default1'), (35, 2, 'A'), (36, 4, 'default2'), (37, NULL, 'B'), (38, 3, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(23, None)
(28, None)
*/

-- Prediction Query
WITH CTE AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') AND PRODUCT_NAME = 'A') SELECT CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS JOIN CUSTOMERS USING (CUSTOMER_ID) WHERE CUSTOMER_ID IN (SELECT * FROM CTE) AND PRODUCT_NAME = 'B';

/*
Prediction Result:
(28, None)
(23, None)
*/