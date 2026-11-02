-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default2'), (-1, 'default2'), (1, 'C'), (2, 'A'), (3, 'default1'), (4, 'default1'), (5, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 1, 'C'), (0, 3, 'default1'), (-1, 4, 'default2'), (2, 4, 'default2'), (3, NULL, 'C'), (4, 2, 'C'), (5, 3, 'default2'), (6, 5, 'C'), (7, 2, 'C'), (8, -1, NULL), (9, 2, 'B'), (10, NULL, 'C'), (11, -1, NULL), (12, 1, 'B'), (13, 1, 'A'), (14, 4, 'A'), (15, -1, 'default1'), (16, 0, NULL), (17, -1, NULL), (18, 1, 'A'), (19, -1, 'A'), (20, -1, 'default1'), (21, 4, 'C'), (22, NULL, 'default1'), (23, 3, NULL), (24, -1, 'B'), (25, 3, 'default2'), (26, 5, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O USING (CUSTOMER_ID) GROUP BY C.CUSTOMER_ID, C.CUSTOMER_NAME HAVING SUM(PRODUCT_NAME = 'A') > 0 AND SUM(PRODUCT_NAME = 'B') > 0 AND SUM(PRODUCT_NAME = 'C') = 0;

/*
Prediction Result:
(-1, 'default2')
*/