-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, NULL), (0, NULL), (2, 'default1'), (3, 'default1'), (4, 'default1'), (5, 'default1'), (6, NULL), (7, 'C'), (8, 'default1'), (9, 'default1'), (10, 'B'), (11, 'default1'), (12, NULL), (13, 'C'), (14, 'A'), (15, 'A'), (16, 'default2'), (17, 'B'), (18, 'default1'), (19, 'C'), (20, 'B'), (21, 'C'), (22, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 18, 'C'), (0, 7, 'default1'), (2, NULL, 'default2'), (3, 19, 'default1'), (4, 18, 'C'), (5, 5, 'A'), (6, 3, 'B'), (7, NULL, 'A'), (8, 5, 'C'), (9, 5, 'B'), (10, 18, 'default2'), (11, 13, 'A'), (12, 11, 'C'), (13, 11, 'A'), (14, 9, 'B'), (15, 7, NULL), (16, 21, NULL), (17, 3, NULL), (18, 3, 'A'), (19, 4, 'C'), (20, 17, NULL), (21, NULL, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT A.CUSTOMER_ID, A.CUSTOMER_NAME FROM CUSTOMERS AS A JOIN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME IN ('A')) AS AB ON A.CUSTOMER_ID = AB.CUSTOMER_ID JOIN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME IN ('B')) AS AB2 ON A.CUSTOMER_ID = AB2.CUSTOMER_ID LEFT JOIN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') AS C ON AB.CUSTOMER_ID = C.CUSTOMER_ID WHERE C.CUSTOMER_ID IS NULL;

/*
Prediction Result:
(3, 'default1')
*/