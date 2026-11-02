-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, NULL), (-1, 'B'), (0, 'C'), (2, 'C'), (3, 'A'), (4, NULL), (5, 'C'), (6, 'B'), (7, 'A'), (8, 'B'), (9, 'B'), (10, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 1, 'A'), (1, 9, NULL), (-1, 0, NULL), (2, 1, 'default2'), (3, 9, 'B'), (4, 6, 'A'), (5, 7, 'A'), (6, 4, 'A'), (7, 9, 'B'), (8, 7, NULL), (9, 8, 'A'), (10, 1, NULL), (11, 1, 'C'), (12, NULL, NULL), (13, 3, 'A'), (14, 0, 'default1'), (15, 10, 'default1'), (16, 3, 'A'), (17, NULL, 'C'), (18, 1, 'default2'), (19, 5, 'C'), (20, 3, 'A'), (21, 5, 'B'), (22, 1, 'default1'), (23, 4, 'B'), (24, 3, 'B'), (25, 8, 'C'), (26, -1, 'default1'), (27, 0, 'default2'), (28, 1, 'default2'), (29, 5, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS GROUP BY CUSTOMER_ID HAVING SUM(PRODUCT_NAME = 'A') > 0 AND SUM(PRODUCT_NAME = 'B') > 0 AND SUM(PRODUCT_NAME = 'C') = 0);

/*
Prediction Result:
(3, 'A')
(4, None)
*/