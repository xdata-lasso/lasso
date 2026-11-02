-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default1'), (1, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 0, 'C'), (0, 0, 'default2'), (2, 1, 'default1'), (3, NULL, 'A'), (4, NULL, '%B%'), (5, 1, '%B%'), (6, 0, '%B%'), (7, 1, '%B%'), (8, NULL, ''), (9, 1, 'B'), (10, NULL, 'default1'), (11, 0, '');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT * FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM (SELECT CUSTOMER_ID, GROUP_CONCAT(PRODUCT_NAME, '') AS PRODUCTS FROM ORDERS GROUP BY CUSTOMER_ID) AS T1 WHERE PRODUCTS NOT LIKE '%C%' AND PRODUCTS LIKE '%A%' AND PRODUCTS LIKE '%B%');

/*
Prediction Result:
(1, 'A')
*/