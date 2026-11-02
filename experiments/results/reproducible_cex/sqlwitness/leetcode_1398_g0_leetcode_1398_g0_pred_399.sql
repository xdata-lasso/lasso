-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'A'), (1, NULL), (2, 'B'), (3, 'C'), (4, 'default1'), (5, 'default2'), (6, NULL), (7, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 7, 'A'), (0, 0, 'default1'), (2, 6, NULL), (3, 2, 'default2'), (4, 7, 'default1'), (5, 1, 'B'), (6, 7, 'default2'), (7, 1, 'C'), (8, 1, 'B'), (9, 6, 'B'), (10, 6, NULL), (11, 7, 'A'), (12, 1, 'default2'), (13, 4, 'B'), (14, 4, 'C'), (15, 6, 'A'), (16, 4, 'default1'), (17, 7, 'B'), (18, 3, NULL), (19, 2, 'B'), (20, 1, 'C'), (21, 4, NULL), (22, 1, 'A'), (23, 3, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(6, None)
(7, 'C')
*/

-- Prediction Query
SELECT TMP.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C JOIN (SELECT TMP1.CUSTOMER_ID FROM (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AS TMP1 JOIN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AS TMP2 ON TMP1.CUSTOMER_ID = TMP2.CUSTOMER_ID) AS TMP ON TMP.CUSTOMER_ID = C.CUSTOMER_ID WHERE NOT TMP.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(7, 'C')
(6, None)
*/