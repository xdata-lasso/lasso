-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'A'), (2, 'C'), (0, 'C'), (-1, 'default2'), (3, NULL), (4, NULL), (5, 'A'), (6, 'B'), (7, 'C'), (8, NULL), (9, 'default1'), (10, NULL), (11, 'A'), (12, 'B'), (13, 'C'), (14, 'A'), (15, NULL), (16, 'default2'), (17, 'A'), (18, 'B'), (19, 'B'), (20, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 9, 'A'), (0, 11, 'default2'), (1, 2, 'A'), (2, 11, 'B'), (3, 19, 'default2'), (4, 2, 'B'), (5, 20, NULL), (6, 1, 'C'), (7, 12, 'A'), (8, 14, 'default1'), (9, NULL, 'C'), (10, 0, 'A'), (11, 20, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT O.CUSTOMER_ID, C.CUSTOMER_NAME FROM ORDERS AS O INNER JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID GROUP BY O.CUSTOMER_ID, C.CUSTOMER_NAME HAVING SUM(CASE WHEN O.PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN O.PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN O.PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) = 0;

/*
Prediction Result:
(2, 'C')
*/