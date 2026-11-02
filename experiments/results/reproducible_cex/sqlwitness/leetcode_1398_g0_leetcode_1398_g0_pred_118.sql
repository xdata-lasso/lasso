-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'default2'), (-1, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 1, 'A'), (0, 1, 'default2'), (1, 1, 'default2'), (2, 1, 'default1'), (3, 1, NULL), (4, -1, 'A'), (5, -1, 'A'), (6, NULL, 'C'), (7, -1, NULL), (8, 1, 'default1'), (9, -1, 'B'), (10, 1, 'default1'), (11, NULL, 'B'), (12, 1, 'C'), (13, NULL, 'default2'), (14, NULL, 'B'), (15, -1, 'default1'), (16, NULL, NULL), (17, 1, 'default2'), (18, -1, 'default1'), (19, NULL, 'A'), (20, NULL, 'default1'), (21, NULL, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C LEFT JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID GROUP BY C.CUSTOMER_ID HAVING SUM(O.PRODUCT_NAME = 'A') > 0 AND SUM(O.PRODUCT_NAME = 'B') > 0 AND SUM(O.PRODUCT_NAME = 'C') = 0;

/*
Prediction Result:
(-1, 'default1')
*/