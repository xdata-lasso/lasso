-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'C'), (1, 'C'), (0, 'default1'), (2, NULL), (3, 'default2'), (4, 'B'), (5, 'default2'), (6, 'default2'), (7, 'default1'), (8, 'default2'), (9, 'default1'), (10, 'C'), (11, 'A'), (12, 'A'), (13, 'C'), (14, 'A'), (15, 'C'), (16, 'A'), (17, 'A'), (18, 'default1'), (19, 'C'), (20, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 0, 'A'), (-1, 9, 'B'), (0, NULL, 'A'), (2, 15, NULL), (3, 4, 'A'), (4, 12, 'default1'), (5, 6, 'default1'), (6, 13, 'default2'), (7, 7, 'B'), (8, 3, 'C'), (9, 5, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID GROUP BY C.CUSTOMER_NAME HAVING SUM(PRODUCT_NAME = 'A') > 0 AND SUM(PRODUCT_NAME = 'B') > 0 AND SUM(PRODUCT_NAME = 'C') = 0;

/*
Prediction Result:
(9, 'default1')
*/