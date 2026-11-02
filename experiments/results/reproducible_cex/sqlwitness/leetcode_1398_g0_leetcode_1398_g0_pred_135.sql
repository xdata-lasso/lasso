-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, NULL), (2, 'default2'), (1, 'default1'), (3, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 1, 'C'), (3, 0, 'A'), (2, 2, 'default1'), (0, 1, 'C'), (4, 3, 'A'), (5, 1, 'default1'), (6, NULL, 'default1'), (7, 3, 'A'), (8, 3, NULL), (9, 1, 'A'), (10, 2, NULL), (11, 1, NULL), (12, 0, 'default2'), (13, 0, NULL), (14, 2, 'default2'), (15, 0, 'B'), (16, 2, 'C'), (17, 2, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(0, None)
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE (PRODUCT_NAME = 'A' OR PRODUCT_NAME = 'B') AND NOT C.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') GROUP BY C.CUSTOMER_ID, CUSTOMER_NAME HAVING COUNT(CUSTOMER_NAME) = 2 ORDER BY C.CUSTOMER_ID, CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
(3, 'default2')
*/