-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, '%B%'), (2, 'B'), (3, '%A%'), (1, 'A'), (4, 'A'), (5, '%A%'), (6, '%A%');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (3, 5, 'A'), (1, 4, '%B%'), (2, 5, '%B%'), (0, NULL, '%A%'), (4, 2, 'default2'), (5, NULL, '%C%'), (6, 1, 'default1'), (7, 6, '%C%');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH T1 AS (SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME, GROUP_CONCAT(PRODUCT_NAME) AS PRODUCTS FROM CUSTOMERS AS C INNER JOIN ORDERS AS O ON O.CUSTOMER_ID = C.CUSTOMER_ID GROUP BY 1, 2) SELECT CUSTOMER_ID, CUSTOMER_NAME FROM T1 WHERE PRODUCTS LIKE '%A%' AND PRODUCTS LIKE '%B%' AND PRODUCTS NOT LIKE '%C%';

/*
Prediction Result:
(5, '%A%')
*/