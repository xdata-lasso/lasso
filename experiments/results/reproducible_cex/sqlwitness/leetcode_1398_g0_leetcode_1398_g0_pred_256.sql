-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default2'), (1, NULL), (3, 'A'), (-1, NULL), (2, 'C'), (4, 'B'), (5, 'A'), (6, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 6, 'B'), (0, 3, 'C'), (3, 0, 'default1'), (1, 1, 'default2'), (2, NULL, 'A'), (4, 5, 'default2'), (5, -1, 'A'), (6, 5, NULL), (7, 0, NULL), (8, 4, 'default1'), (9, 2, 'B'), (10, 0, 'A'), (11, -1, 'C'), (12, 5, NULL), (13, 0, 'C'), (14, 5, 'default1'), (15, 0, NULL), (16, 4, 'C'), (17, NULL, 'default2'), (18, -1, 'A'), (19, 1, 'C'), (20, 5, 'B'), (21, -1, 'default2'), (22, 1, NULL), (23, 1, 'A'), (24, 5, 'A'), (25, 4, 'C'), (26, NULL, 'B'), (27, 4, 'default1'), (28, 6, 'C'), (29, 1, 'C'), (30, 5, 'default1'), (31, 2, 'default2'), (32, NULL, 'C'), (33, 0, 'A'), (34, -1, 'A'), (35, 1, NULL), (36, 6, 'default2'), (37, 3, 'default1'), (38, 1, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT * FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM (SELECT DISTINCT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS) AS TMP GROUP BY CUSTOMER_ID HAVING SUM(CASE WHEN PRODUCT_NAME IN ('A', 'B') THEN 1 WHEN PRODUCT_NAME IN ('C') THEN -2 ELSE 0 END) = 2);

/*
Prediction Result:
(5, 'A')
*/