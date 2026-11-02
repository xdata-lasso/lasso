-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, NULL), (1, 'A'), (2, 'default2'), (3, 'default1'), (4, 'default2'), (5, 'C'), (6, 'default1'), (7, 'A'), (8, 'C'), (9, NULL), (10, NULL), (11, 'default1'), (12, 'A'), (13, 'default2'), (14, 'default2'), (15, 'A'), (16, 'default2'), (17, 'default2'), (18, 'C'), (19, NULL), (20, 'default2'), (21, 'A'), (22, 'A'), (23, 'default1'), (24, 'default1'), (25, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, NULL, 'default1'), (1, 18, 'default1'), (2, 1, 'A'), (3, 20, 'default2'), (4, 16, NULL), (5, 13, 'A'), (6, 1, NULL), (7, 20, 'C'), (8, 5, 'default1'), (9, 7, 'A'), (10, 18, 'A'), (11, 0, 'B'), (12, 9, 'B'), (13, 2, 'C'), (14, 21, NULL), (15, 14, NULL), (16, 0, 'A'), (17, 10, 'A'), (18, 20, NULL), (19, 1, 'B'), (20, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(0, None)
(1, 'A')
*/

-- Prediction Query
SELECT DISTINCT C.CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE PRODUCT_NAME IN ('A') AND C.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS AS O WHERE PRODUCT_NAME IN ('B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS AS O WHERE PRODUCT_NAME IN ('C')));

/*
Prediction Result:
(1, 'A')
(0, None)
*/