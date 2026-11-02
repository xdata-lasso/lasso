-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'B'), (0, 'A'), (2, 'A'), (3, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 0, 'A'), (1, 2, 'default1'), (2, 1, 'B'), (3, 2, 'default1'), (4, 3, 'C'), (5, 3, 'A'), (6, 2, 'default1'), (7, 3, 'default1'), (8, 1, NULL), (9, NULL, 'B'), (10, 3, 'default1'), (11, 2, 'C'), (12, 2, 'default1'), (13, 3, 'A'), (14, 2, 'C'), (15, 1, 'default1'), (16, 0, 'B'), (17, NULL, NULL), (18, 0, 'default1'), (19, NULL, 'C'), (20, 2, 'A'), (21, 2, 'B'), (22, 0, 'default1'), (23, NULL, NULL), (24, 0, NULL), (25, NULL, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID AND O.PRODUCT_NAME = 'A' JOIN ORDERS AS O2 ON C.CUSTOMER_ID = O2.CUSTOMER_ID AND O2.PRODUCT_NAME = 'B' LEFT OUTER JOIN ORDERS AS O3 ON C.CUSTOMER_ID = O3.CUSTOMER_ID AND O3.PRODUCT_NAME = 'C' WHERE O3.ORDER_ID IS NULL ORDER BY C.CUSTOMER_ID, C.CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
(0, 'A')
*/