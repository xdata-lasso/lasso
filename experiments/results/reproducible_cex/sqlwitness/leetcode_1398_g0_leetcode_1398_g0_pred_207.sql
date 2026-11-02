-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'A'), (1, 'default2'), (2, 'default1'), (3, NULL), (4, 'default2'), (5, NULL), (6, 'A'), (7, 'A'), (8, NULL), (9, 'default1'), (10, 'A'), (11, 'default1'), (12, 'B'), (13, 'B'), (14, NULL), (15, 'A'), (16, NULL), (17, 'default2'), (18, 'default2'), (19, 'A'), (20, 'default1'), (21, 'default1'), (22, 'A'), (23, 'B'), (24, 'B'), (25, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 25, 'B'), (0, 2, NULL), (2, NULL, NULL), (3, 0, 'default2'), (4, 13, 'default1'), (5, 24, 'B'), (6, NULL, 'default2'), (7, 22, 'C'), (8, 13, NULL), (9, 10, 'default1'), (10, 12, 'C'), (11, 12, 'B'), (12, NULL, 'A'), (13, 15, 'A'), (14, 12, 'default2'), (15, 24, 'A'), (16, 22, 'B'), (17, 7, 'default2'), (18, 15, 'B'), (19, 0, 'C'), (20, 13, 'default2'), (21, 7, 'default2'), (22, 1, 'default2'), (23, 10, 'A'), (24, 11, 'A'), (25, 7, 'B'), (26, 8, 'default1'), (27, 4, 'A'), (28, 13, 'default1'), (29, 4, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(15, 'A')
(24, 'B')
*/

-- Prediction Query
WITH CTE AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A'), CTE2 AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B'), CTE3 AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') SELECT DISTINCT CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS JOIN CUSTOMERS AS C USING (CUSTOMER_ID) WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM CTE) AND CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM CTE2) AND NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM CTE3);

/*
Prediction Result:
(24, 'B')
(15, 'A')
*/