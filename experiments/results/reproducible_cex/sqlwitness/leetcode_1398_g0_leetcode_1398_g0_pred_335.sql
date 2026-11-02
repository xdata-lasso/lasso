-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default2'), (1, 'A'), (2, 'default1'), (-1, 'C'), (3, 'default2'), (4, 'C'), (5, 'default2'), (6, 'B'), (7, 'default1'), (8, 'B'), (9, 'default2'), (10, 'default2'), (11, 'C'), (12, 'B'), (13, NULL), (14, 'default1'), (15, 'default1'), (16, NULL), (17, 'A'), (18, 'default2'), (19, 'default2'), (20, 'default1'), (21, 'default1'), (22, 'C'), (23, 'default1'), (24, 'C'), (25, 'default1'), (26, 'A'), (27, 'A'), (28, 'C'), (29, 'B'), (30, 'default1'), (31, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, NULL, 'default1'), (1, 27, 'B'), (2, 5, 'default1'), (0, 26, NULL), (3, 3, 'A'), (4, 3, 'B'), (5, 4, 'default1'), (6, 25, 'A'), (7, 1, 'default2'), (8, NULL, 'C'), (9, 26, NULL), (10, NULL, 'default2'), (11, 3, 'A'), (12, 10, NULL), (13, 23, 'default1'), (14, 23, NULL), (15, 23, NULL), (16, 26, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH TB AS (SELECT CUSTOMER_ID, IIF(PRODUCT_NAME = 'A', 1, 0) AS A, IIF(PRODUCT_NAME = 'B', 1, 0) AS B, IIF(PRODUCT_NAME = 'C', 1, 0) AS C FROM ORDERS), TB1 AS (SELECT CUSTOMER_ID FROM TB GROUP BY CUSTOMER_ID HAVING SUM(A) > 0 AND SUM(B) > 0 AND SUM(C) = 0) SELECT CUSTOMERS.* FROM CUSTOMERS JOIN TB1 USING (CUSTOMER_ID);

/*
Prediction Result:
(3, 'default2')
*/