-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'default2'), (0, 'B'), (2, 'default2'), (3, 'C'), (4, 'A'), (5, 'C'), (6, 'B'), (7, 'default2'), (8, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 5, 'C'), (1, 1, 'A'), (2, 4, 'default1'), (3, NULL, 'default2'), (4, NULL, 'C'), (5, 8, 'A'), (6, NULL, 'default1'), (7, 5, 'default1'), (8, 6, 'A'), (9, 5, 'default1'), (10, 3, 'default2'), (11, 2, 'A'), (12, 2, 'default1'), (13, 6, 'default1'), (14, 7, 'default2'), (15, 7, 'B'), (16, 6, 'B'), (17, 2, 'default1'), (18, 4, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT C.CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS AS C LEFT JOIN ORDERS AS O1 ON O1.CUSTOMER_ID = C.CUSTOMER_ID AND O1.PRODUCT_NAME = 'C' LEFT JOIN ORDERS AS O2 ON O2.CUSTOMER_ID = C.CUSTOMER_ID AND O2.PRODUCT_NAME = 'A' LEFT JOIN ORDERS AS O3 ON O3.CUSTOMER_ID = C.CUSTOMER_ID AND O3.PRODUCT_NAME = 'B' WHERE O1.CUSTOMER_ID IS NULL AND NOT O2.CUSTOMER_ID IS NULL AND NOT O3.CUSTOMER_ID IS NULL;

/*
Prediction Result:
(6, 'B')
*/