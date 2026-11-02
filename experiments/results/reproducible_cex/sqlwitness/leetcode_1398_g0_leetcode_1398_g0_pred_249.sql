-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'B'), (0, 'A'), (2, 'A'), (3, 'B'), (4, 'B'), (5, 'B'), (6, 'default1'), (7, NULL), (8, 'C'), (9, 'A'), (10, 'default1'), (11, 'default2'), (12, 'C'), (13, 'A'), (14, 'B'), (15, 'C'), (16, 'A'), (17, 'A'), (18, 'B'), (19, 'A'), (20, NULL), (21, 'default1'), (22, NULL), (23, 'A'), (24, 'B'), (25, 'default2'), (26, 'C'), (27, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 13, 'A'), (1, 14, 'A'), (2, 21, NULL), (3, 8, NULL), (4, 6, NULL), (5, 17, 'default1'), (6, 14, NULL), (7, 16, 'A'), (8, 27, 'A'), (9, 17, 'default1'), (10, 11, 'C'), (11, 12, 'default2'), (12, 19, NULL), (13, 22, 'C'), (14, 19, 'C'), (15, 0, 'default2'), (16, NULL, 'C'), (17, 27, 'B'), (18, 16, 'default1'), (19, 16, NULL), (20, 16, NULL), (21, 13, NULL), (22, 2, 'default2'), (23, 7, 'B'), (24, 25, 'B'), (25, 19, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT O.CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS AS O JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE PRODUCT_NAME = 'A' AND EXISTS(SELECT CUSTOMER_ID FROM ORDERS WHERE CUSTOMER_ID = O.CUSTOMER_ID AND PRODUCT_NAME = 'B') AND NOT EXISTS(SELECT CUSTOMER_ID FROM ORDERS WHERE CUSTOMER_ID = O.CUSTOMER_ID AND PRODUCT_NAME = 'C');

/*
Prediction Result:
(27, 'C')
*/