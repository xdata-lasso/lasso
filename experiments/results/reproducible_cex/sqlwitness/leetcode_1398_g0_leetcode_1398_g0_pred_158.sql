-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'A'), (0, 'C'), (2, 'default1'), (3, NULL), (4, 'B'), (5, 'B'), (6, NULL), (7, NULL), (8, 'B'), (9, 'default1'), (10, NULL), (11, 'A'), (12, 'B'), (13, 'C'), (14, 'C'), (15, 'A'), (16, 'default2'), (17, 'B'), (18, NULL), (19, NULL), (20, NULL), (21, 'B'), (22, 'default1'), (23, 'default1'), (24, 'C'), (25, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 10, 'default1'), (0, 12, 'default1'), (2, 21, 'B'), (3, 13, 'default1'), (4, 18, 'B'), (5, 2, 'B'), (6, 10, NULL), (7, 21, 'default2'), (8, 5, 'B'), (9, 14, NULL), (10, 24, 'B'), (11, 21, 'default2'), (12, 10, 'A'), (13, 17, 'B'), (14, NULL, 'B'), (15, 14, 'C'), (16, 21, 'B'), (17, 2, 'B'), (18, 9, 'A'), (19, NULL, 'B'), (20, 25, 'A'), (21, 24, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(24, 'C')
*/

-- Prediction Query
SELECT DISTINCT C.CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS AS C CROSS JOIN ORDERS AS O WHERE C.CUSTOMER_ID = O.CUSTOMER_ID AND PRODUCT_NAME = 'A' AND CUSTOMER_NAME IN (SELECT DISTINCT CUSTOMER_NAME FROM CUSTOMERS AS C CROSS JOIN ORDERS AS O WHERE C.CUSTOMER_ID = O.CUSTOMER_ID AND PRODUCT_NAME = 'B') AND NOT CUSTOMER_NAME IN (SELECT DISTINCT CUSTOMER_NAME FROM CUSTOMERS AS C CROSS JOIN ORDERS AS O WHERE C.CUSTOMER_ID = O.CUSTOMER_ID AND PRODUCT_NAME = 'C');

/*
Prediction Result:
(9, 'default1')
*/