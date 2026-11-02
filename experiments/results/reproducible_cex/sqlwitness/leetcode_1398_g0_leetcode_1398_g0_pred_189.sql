-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'A'), (1, NULL), (2, NULL), (3, 'default1'), (4, 'C'), (5, 'C'), (6, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 4, 'B'), (1, 5, 'default1'), (2, 1, 'default2'), (3, NULL, 'default1'), (4, 5, 'B'), (5, 0, 'B'), (6, 3, NULL), (7, 5, 'B'), (8, 1, 'default2'), (9, 4, 'C'), (10, NULL, 'default2'), (11, 5, 'A'), (12, 5, 'default2'), (13, 6, 'A'), (14, 0, 'C'), (15, 6, 'C'), (16, 2, 'A'), (17, 6, 'B'), (18, 1, 'A'), (19, 1, 'default2'), (20, 1, 'B'), (21, NULL, 'default2'), (22, NULL, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, None)
(5, 'C')
*/

-- Prediction Query
WITH A AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A'), B AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') SELECT A.CUSTOMER_ID, C.CUSTOMER_NAME FROM A JOIN B ON A.CUSTOMER_ID = B.CUSTOMER_ID JOIN CUSTOMERS AS C ON A.CUSTOMER_ID = C.CUSTOMER_ID AND NOT A.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(5, 'C')
(5, 'C')
(1, None)
*/