-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'default1'), (0, 'default1'), (2, 'default1'), (3, 'B'), (4, 'B'), (5, 'C'), (6, 'default2'), (7, 'C'), (8, 'C'), (9, 'A'), (10, 'C'), (11, 'B'), (12, 'B'), (13, 'B'), (14, 'C'), (15, 'default2'), (16, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 15, 'A'), (1, 1, 'default2'), (2, 2, NULL), (3, 8, NULL), (4, 14, 'B'), (5, 2, 'C'), (6, 13, 'B'), (7, 8, 'A'), (8, 2, 'B'), (9, 2, 'B'), (10, NULL, 'default2'), (11, 0, 'C'), (12, 11, 'A'), (13, 10, 'default1'), (14, 9, NULL), (15, 5, NULL), (16, 0, NULL), (17, 12, 'B'), (18, 2, 'A'), (19, 7, 'A'), (20, 3, 'default1'), (21, 0, 'C'), (22, 16, 'B'), (23, 11, 'A'), (24, 11, 'B'), (25, 2, 'default2'), (26, 13, 'B'), (27, 16, 'B'), (28, NULL, 'default1'), (29, 13, 'B'), (30, 8, 'default1'), (31, 7, 'A'), (32, 5, 'A'), (33, 7, 'B'), (34, 3, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(7, 'C')
(11, 'B')
*/

-- Prediction Query
WITH CTE AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A'), CTE1 AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B'), CTE2 AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') SELECT DISTINCT CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS AS O JOIN CUSTOMERS AS C USING (CUSTOMER_ID) WHERE CUSTOMER_ID IN (SELECT * FROM CTE) AND CUSTOMER_ID IN (SELECT * FROM CTE1) AND NOT CUSTOMER_ID IN (SELECT * FROM CTE2);

/*
Prediction Result:
(11, 'B')
(7, 'C')
*/