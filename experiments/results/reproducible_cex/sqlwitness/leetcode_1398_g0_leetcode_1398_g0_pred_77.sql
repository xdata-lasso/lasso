-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'C'), (0, 'B'), (1, 'default1'), (-1, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 1, 'C'), (0, 1, 'A'), (1, 0, 'C'), (2, 2, 'default1'), (3, -1, 'C'), (4, -1, 'default2'), (5, 1, 'default1'), (6, 1, 'default1'), (7, 1, 'default1'), (8, 0, 'C'), (9, NULL, 'B'), (10, -1, 'B'), (11, 0, 'default2'), (12, 2, 'B'), (13, 0, 'B'), (14, 1, 'default2'), (15, NULL, 'C'), (16, 1, NULL), (17, NULL, 'C'), (18, 2, NULL), (19, 1, 'default1'), (20, NULL, 'C'), (21, NULL, 'B'), (22, 0, 'A'), (23, 2, NULL), (24, -1, NULL), (25, 1, 'C'), (26, 2, 'A'), (27, 2, NULL), (28, 0, 'B'), (29, -1, 'C'), (30, -1, NULL), (31, -1, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH CANDIDATES AS (SELECT CUSTOMER_ID FROM ORDERS GROUP BY CUSTOMER_ID HAVING SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) = 0) SELECT * FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM CANDIDATES) ORDER BY CUSTOMER_ID;

/*
Prediction Result:
(2, 'C')
*/