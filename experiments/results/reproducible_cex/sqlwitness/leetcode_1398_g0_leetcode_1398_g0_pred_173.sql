-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, NULL), (1, 'A'), (3, 'A'), (2, NULL), (4, 'C'), (5, NULL), (6, 'default1'), (7, NULL), (8, 'C'), (9, 'B'), (10, 'B'), (11, 'default1'), (12, 'C'), (13, 'C'), (14, 'B'), (15, 'A'), (16, NULL), (17, 'default1'), (18, 'C'), (19, NULL), (20, 'default1'), (21, 'C'), (22, 'C'), (23, NULL), (24, 'B'), (25, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 2, 'A'), (1, 10, 'A'), (3, 2, 'A'), (2, 24, 'default2'), (4, 9, 'default1'), (5, 8, 'A'), (6, 24, 'default1'), (7, NULL, 'default2'), (8, 9, 'default2'), (9, 19, 'default1'), (10, 25, NULL), (11, 19, 'C'), (12, 4, 'B'), (13, 22, 'default1'), (14, 12, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT O.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C LEFT JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE O.PRODUCT_NAME = 'A' OR O.PRODUCT_NAME = 'B' GROUP BY O.CUSTOMER_ID HAVING COUNT(O.PRODUCT_NAME) = 2 AND NOT O.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(2, None)
*/