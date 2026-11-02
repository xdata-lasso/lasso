-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'C'), (1, 'B'), (2, 'default2'), (0, 'default2'), (3, NULL), (4, 'A'), (5, 'default2'), (6, 'default2'), (7, 'A'), (8, 'default1'), (9, 'default2'), (10, 'C'), (11, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, NULL, 'A'), (0, 9, 'A'), (1, 9, 'A'), (2, NULL, 'default2'), (3, 7, 'C'), (4, 0, 'B'), (5, 10, 'A'), (6, 2, 'A'), (7, 5, 'default1'), (8, 6, 'A'), (9, 0, NULL), (10, 9, 'C'), (11, 2, 'A'), (12, 11, NULL), (13, 1, 'default1'), (14, -1, 'B'), (15, 7, 'A'), (16, 10, NULL), (17, 1, 'C'), (18, 6, 'default1'), (19, NULL, 'B'), (20, 3, NULL), (21, 10, 'C'), (22, 6, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT O.CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS AS O LEFT JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID GROUP BY O.CUSTOMER_ID HAVING SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) = 0 ORDER BY O.CUSTOMER_ID, CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
(None, None)
*/