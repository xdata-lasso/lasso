-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'A'), (1, NULL), (2, 'A'), (0, 'C'), (3, 'A'), (4, 'default1'), (5, 'default2'), (6, 'B'), (7, 'C'), (8, 'C'), (9, NULL), (10, 'C'), (11, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 1, NULL), (-1, 2, 'B'), (2, 4, 'default1'), (1, 2, 'A'), (3, 10, 'B'), (4, 8, 'default2'), (5, 1, 'A'), (6, NULL, 'B'), (7, 3, 'default2'), (8, 5, 'B'), (9, 9, 'A'), (10, 11, NULL), (11, 4, 'default1'), (12, NULL, 'A'), (13, 3, 'C'), (14, NULL, 'default1'), (15, 0, 'C'), (16, 11, NULL), (17, 1, 'default2'), (18, 11, NULL), (19, 3, 'default2'), (20, NULL, 'A'), (21, 3, 'B'), (22, NULL, 'C'), (23, 0, 'A'), (24, 10, 'default1'), (25, 3, 'A'), (26, 0, 'A'), (27, 4, 'A'), (28, 0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS AS C LEFT JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID GROUP BY 1 HAVING SUM(CASE WHEN O.PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN O.PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN O.PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) = 0 ORDER BY 1, C.CUSTOMER_ID NULLS LAST, CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
(2, 'A')
*/