-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'default1'), (2, 'B'), (10, 'default2'), (111, NULL), (101, 'default2'), (109, 'B'), (100, 'default1'), (11, 'C'), (9, 'B'), (1, NULL), (0, 'default1'), (99, 'default2'), (110, 'A'), (3, NULL), (4, 'C'), (5, 'default2'), (6, NULL), (7, 'default2'), (8, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (111, -1, 'A'), (2, 0, NULL), (110, 1, 'B'), (1, 111, 'A'), (9, 2, 'A'), (100, 10, NULL), (99, 5, 'default2'), (-1, 99, 'B'), (11, 101, 'default1'), (0, 6, 'default1'), (109, 2, 'A'), (101, 2, NULL), (10, NULL, 'C'), (3, -1, 'B'), (4, 1, 'default1'), (5, 101, 'A'), (6, 101, 'default1'), (7, 0, NULL), (8, 5, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT O.CUSTOMER_ID, C.CUSTOMER_NAME, SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 100 WHEN PRODUCT_NAME = 'B' THEN 10 WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) AS PRODUCT_INDEX FROM ORDERS AS O JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID GROUP BY O.CUSTOMER_ID, C.CUSTOMER_NAME) AS TMP WHERE PRODUCT_INDEX = 110;

/*
Prediction Result:
(-1, 'default1')
*/