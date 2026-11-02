-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default1'), (1, 'B'), (2, 'B'), (3, 'A'), (4, 'B'), (5, 'A'), (6, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 3, 'A'), (0, NULL, 'default1'), (2, 1, 'B'), (3, 1, NULL), (4, 2, 'B'), (5, 0, 'A'), (6, 3, 'default1'), (7, 4, 'A'), (8, 5, 'A'), (9, 1, 'A'), (10, 4, 'default1'), (11, 3, 'default2'), (12, 5, 'default2'), (13, 6, 'A'), (14, 2, 'C'), (15, 0, 'A'), (16, 0, 'B'), (17, NULL, NULL), (18, 6, 'A'), (19, 3, 'default1'), (20, 1, 'B'), (21, 6, 'C'), (22, 1, 'default2'), (23, 6, 'default1'), (24, 5, 'B'), (25, 4, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(0, 'default1')
(1, 'B')
(5, 'A')
*/

-- Prediction Query
SELECT DISTINCT A.CUSTOMER_ID, C.CUSTOMER_NAME FROM ORDERS AS A JOIN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = A.CUSTOMER_ID WHERE PRODUCT_NAME = 'A' AND NOT A.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(0, 'default1')
(5, 'A')
(1, 'B')
*/