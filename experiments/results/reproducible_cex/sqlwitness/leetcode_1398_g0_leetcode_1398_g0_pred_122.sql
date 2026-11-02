-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'A'), (1, 'B'), (2, NULL), (0, 'default1'), (3, 'A'), (4, 'default2'), (5, 'A'), (6, 'B'), (7, NULL), (8, 'default1'), (9, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 1, 'B'), (1, 1, 'B'), (0, 7, NULL), (2, 1, 'default2'), (3, 7, 'C'), (4, 6, NULL), (5, 1, 'A'), (6, 6, 'default2'), (7, 6, 'default2'), (8, 7, 'B'), (9, 3, 'C'), (10, 6, 'C'), (11, 3, NULL), (12, NULL, 'default2'), (13, 6, 'default2'), (14, 8, 'A'), (15, 9, 'default2'), (16, 6, 'default2'), (17, 6, NULL), (18, NULL, 'default2'), (19, 5, 'default1'), (20, 1, 'default2'), (21, 5, 'B'), (22, 4, NULL), (23, -1, 'C'), (24, 9, 'B'), (25, 3, 'C'), (26, 5, 'default2'), (27, 0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'B')
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID GROUP BY 1 HAVING SUM(O.PRODUCT_NAME = 'A') = 1 AND SUM(O.PRODUCT_NAME = 'B') = 1 AND SUM(O.PRODUCT_NAME = 'C') = 0 ORDER BY 1, C.CUSTOMER_ID NULLS LAST, C.CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
*/