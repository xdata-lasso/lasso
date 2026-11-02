-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'C'), (1, 'B'), (2, 'default1'), (3, 'C'), (4, 'B'), (5, 'default2'), (6, NULL), (7, 'default2'), (8, 'C'), (9, 'A'), (10, 'default2'), (11, 'default2'), (12, 'B'), (13, 'default1'), (14, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 4, 'default1'), (0, 7, 'B'), (2, 5, 'C'), (3, 14, 'C'), (4, 10, NULL), (5, 0, NULL), (6, 1, 'C'), (7, 3, 'C'), (8, 11, 'default2'), (9, 13, NULL), (10, 7, 'A'), (11, 6, 'B'), (12, 9, NULL), (13, 1, 'C'), (14, 4, 'A'), (15, 6, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(6, None)
(7, 'default2')
*/

-- Prediction Query
WITH A AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A'), B AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B'), C AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C'), TEMP AS (SELECT CUSTOMER_ID FROM A WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM B) AND NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM C)) SELECT DISTINCT T.CUSTOMER_ID, C.CUSTOMER_NAME FROM TEMP AS T JOIN CUSTOMERS AS C ON T.CUSTOMER_ID = C.CUSTOMER_ID;

/*
Prediction Result:
(7, 'default2')
(6, None)
*/