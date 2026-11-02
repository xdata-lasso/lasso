-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'B'), (1, 'default1'), (0, 'C'), (2, 'C'), (3, 'C'), (4, 'A'), (5, 'default1'), (6, 'default1'), (7, 'A'), (8, 'default2'), (9, 'C'), (10, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 10, 'default2'), (-1, 10, 'C'), (0, 7, 'C'), (2, 6, 'B'), (3, 0, 'B'), (4, NULL, 'default2'), (5, -1, 'B'), (6, NULL, 'C'), (7, NULL, 'default2'), (8, 3, 'B'), (9, 0, 'B'), (10, 1, 'C'), (11, -1, 'A'), (12, 10, 'A'), (13, 6, NULL), (14, 4, 'C'), (15, 1, 'default1'), (16, -1, 'default2'), (17, 9, 'default2'), (18, 10, 'default1'), (19, 10, 'B'), (20, 0, 'default1'), (21, 9, 'C'), (22, 9, 'A'), (23, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS AS C WHERE C.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM (SELECT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS GROUP BY CUSTOMER_ID HAVING SUM(PRODUCT_NAME = 'A') > 0 AND SUM(PRODUCT_NAME = 'B') > 0 AND SUM(PRODUCT_NAME = 'C') = 0) AS O);

/*
Prediction Result:
(-1, 'B')
*/