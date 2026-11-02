-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'C'), (2, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, NULL, 'A'), (-1, NULL, 'A'), (2, 2, 'C'), (1, 2, 'C'), (3, 0, 'B'), (4, 2, 'C'), (5, NULL, 'A'), (6, NULL, 'C'), (7, 0, 'default1'), (8, NULL, 'C'), (9, 0, 'default2'), (10, 2, 'C'), (11, 0, 'B'), (12, NULL, NULL), (13, 2, NULL), (14, 0, 'default1'), (15, 0, 'A'), (16, 0, 'B'), (17, 2, NULL), (18, NULL, 'default2'), (19, 2, 'C'), (20, 2, 'default1'), (21, 0, 'default1'), (22, 2, 'default1'), (23, 2, 'C'), (24, NULL, 'B'), (25, 2, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID GROUP BY C.CUSTOMER_ID HAVING SUM(IIF(O.PRODUCT_NAME = 'A', 1, 0)) > 0 AND SUM(IIF(O.PRODUCT_NAME = 'B', 1, 0)) > 0 AND SUM(IIF(O.PRODUCT_NAME = 'C', 1, 0)) = 0;

/*
Prediction Result:
(0, 'C')
*/