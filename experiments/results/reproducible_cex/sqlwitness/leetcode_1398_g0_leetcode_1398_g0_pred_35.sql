-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, '%B%'), (1, '%A%'), (2, '%A%'), (3, 'C'), (4, NULL), (5, 'C'), (6, 'B'), (7, NULL), (8, 'default1'), (9, 'A'), (10, '%C%'), (11, '%B%');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 1, 'default2'), (0, 0, 'default1'), (2, NULL, 'B'), (3, 1, 'C'), (4, 9, '%A%'), (5, 7, '%A%'), (6, 5, '%C%'), (7, 7, '%A%'), (8, 5, '%C%'), (9, 0, '%B%'), (10, 5, '%A%');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS AS C LEFT JOIN (SELECT CUSTOMER_ID, GROUP_CONCAT(PRODUCT_NAME) AS PRODUCTS FROM ORDERS GROUP BY CUSTOMER_ID) AS CC ON CC.CUSTOMER_ID = C.CUSTOMER_ID WHERE PRODUCTS LIKE '%A%' AND PRODUCTS LIKE '%B%' AND PRODUCTS NOT LIKE '%C%';

/*
Prediction Result:
(0, '%B%')
*/