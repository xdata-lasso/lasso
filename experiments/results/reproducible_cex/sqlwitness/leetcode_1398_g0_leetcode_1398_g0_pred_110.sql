-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'A'), (0, 'B'), (2, 'A'), (3, 'A'), (4, 'default1'), (5, 'B'), (6, 'default1'), (7, NULL), (8, 'A'), (9, 'B'), (10, 'B'), (11, 'A'), (12, 'B'), (13, NULL), (14, 'C'), (15, 'default2'), (16, 'A'), (17, NULL), (18, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 8, 'default1'), (1, 9, NULL), (2, 10, 'C'), (3, 7, 'default2'), (4, 14, 'B'), (5, 14, 'A'), (6, 0, 'C'), (7, 6, 'A'), (8, 7, NULL), (9, 8, 'B'), (10, 8, 'B'), (11, 11, 'default1'), (12, 16, 'default1'), (13, 14, 'B'), (14, 9, 'default2'), (15, 8, 'default2'), (16, 6, 'default1'), (17, 11, 'default1'), (18, 11, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(14, 'C')
*/

-- Prediction Query
SELECT A.CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS AS A JOIN ORDERS AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID JOIN CUSTOMERS AS C ON A.CUSTOMER_ID = C.CUSTOMER_ID WHERE A.PRODUCT_NAME = 'A' AND B.PRODUCT_NAME = 'B' AND NOT A.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(14, 'C')
(14, 'C')
*/