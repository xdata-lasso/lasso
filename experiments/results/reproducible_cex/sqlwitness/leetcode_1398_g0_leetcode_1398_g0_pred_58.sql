-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default1'), (1, 'default2'), (2, '%B%'), (3, NULL), (4, '%A%'), (5, 'default2'), (6, '%A%');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 0, 'B'), (1, 3, 'B'), (2, 1, NULL), (3, 3, 'default2'), (4, NULL, '%C%'), (5, 0, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(0, 'default1')
*/

-- Prediction Query
SELECT T2.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C JOIN (SELECT CUSTOMER_ID, GROUP_CONCAT(PRODUCT_NAME) AS PRODUCTS FROM ORDERS GROUP BY CUSTOMER_ID) AS T2 ON C.CUSTOMER_ID = T2.CUSTOMER_ID WHERE T2.PRODUCTS NOT LIKE '%C%' AND T2.PRODUCTS LIKE '%A%' AND T2.PRODUCTS LIKE '%B%';

/*
Prediction Result:
(0, 'default1')
(3, None)
*/