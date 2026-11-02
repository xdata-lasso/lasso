-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'B'), (0, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 0, 'B'), (-1, NULL, 'A'), (0, 0, 'default2'), (2, NULL, 'default2'), (3, 0, 'A'), (4, NULL, 'C'), (5, 0, NULL), (6, -1, 'C'), (7, -1, 'default1'), (8, NULL, 'B'), (9, NULL, 'default1'), (10, NULL, 'C'), (11, -1, NULL), (12, 0, 'default2'), (13, NULL, NULL), (14, 0, NULL), (15, 0, 'default1'), (16, -1, 'A'), (17, NULL, 'A'), (18, -1, 'default2'), (19, NULL, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C LEFT JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID GROUP BY C.CUSTOMER_ID, C.CUSTOMER_NAME HAVING SUM(O.PRODUCT_NAME = 'C') = 0 AND SUM(O.PRODUCT_NAME = 'A') > 0 AND SUM(O.PRODUCT_NAME = 'B') > 0;

/*
Prediction Result:
(0, None)
*/