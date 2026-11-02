-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, NULL), (-1, 'default1'), (1, NULL), (0, 'A'), (3, 'default1'), (4, 'default1'), (5, 'C'), (6, 'C'), (7, 'C'), (8, 'C'), (9, 'default2'), (10, 'A'), (11, 'B'), (12, NULL), (13, NULL), (14, 'B'), (15, 'C'), (16, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 2, 'A'), (-1, 15, 'A'), (1, 8, 'default2'), (2, 5, NULL), (3, 3, 'A'), (4, 1, 'default2'), (5, -1, 'default2'), (6, 12, 'default2'), (7, 2, 'B'), (8, 9, 'default2'), (9, -1, 'C'), (10, 4, 'B'), (11, 14, 'B'), (12, 15, NULL), (13, 12, 'B'), (14, 3, 'C'), (15, 8, 'B'), (16, 14, NULL), (17, 8, 'default1'), (18, 14, 'default2'), (19, 13, 'default2'), (20, 1, 'default2'), (21, 9, 'C'), (22, 9, 'B'), (23, 11, 'B'), (24, 3, 'C'), (25, 9, NULL), (26, NULL, 'C'), (27, -1, 'default2'), (28, 11, NULL), (29, 11, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID GROUP BY C.CUSTOMER_ID HAVING SUM(O.PRODUCT_NAME = 'A') > 0 AND SUM(O.PRODUCT_NAME = 'B') > 0 AND SUM(O.PRODUCT_NAME = 'C') = 0 ORDER BY 1, C.CUSTOMER_ID NULLS LAST, C.CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
(2, None)
*/