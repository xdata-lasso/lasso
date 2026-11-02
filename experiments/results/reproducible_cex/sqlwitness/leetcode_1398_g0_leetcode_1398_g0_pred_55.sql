-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'default1'), (0, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 0, 'C'), (-1, 1, 'B'), (1, 1, 'default2'), (2, NULL, NULL), (3, 0, 'default2'), (4, 0, 'C'), (5, NULL, 'A'), (6, 0, 'C'), (7, 0, NULL), (8, NULL, 'default2'), (9, 1, NULL), (10, 1, 'default1'), (11, NULL, 'A'), (12, NULL, 'A'), (13, 1, 'A'), (14, NULL, 'B'), (15, 0, NULL), (16, 0, 'C'), (17, 1, 'C'), (18, 0, 'B'), (19, 0, 'C'), (20, 0, 'A'), (21, 0, 'B'), (22, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT O.CUSTOMER_ID, C.CUSTOMER_NAME FROM ORDERS AS O LEFT JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID GROUP BY O.CUSTOMER_ID HAVING SUM(O.PRODUCT_NAME = 'A') > 0 AND SUM(O.PRODUCT_NAME = 'B') > 0 AND SUM(O.PRODUCT_NAME = 'C') = 0 ORDER BY O.CUSTOMER_ID, C.CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
(None, None)
*/