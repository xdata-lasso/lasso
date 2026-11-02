-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'C'), (0, 'B'), (2, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 2, 'default2'), (1, 0, 'default1'), (2, NULL, 'C'), (3, 0, 'default2'), (4, 0, 'C'), (5, NULL, 'default1'), (6, 2, 'B'), (7, 0, 'default2'), (8, 1, 'B'), (9, 1, 'default2'), (10, NULL, 'B'), (11, 1, 'default2'), (12, 0, 'default2'), (13, 2, 'B'), (14, 2, 'A'), (15, 0, 'default2'), (16, 0, 'default1'), (17, 1, NULL), (18, 0, 'default2'), (19, 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH A AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A'), B AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B'), C AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C'), RES AS (SELECT A.CUSTOMER_ID FROM A INNER JOIN B ON A.CUSTOMER_ID = B.CUSTOMER_ID), ORD AS (SELECT RES.CUSTOMER_ID FROM RES LEFT JOIN C ON RES.CUSTOMER_ID = C.CUSTOMER_ID WHERE C.CUSTOMER_ID IS NULL) SELECT * FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORD);

/*
Prediction Result:
(2, 'default2')
*/