-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, ''), (0, ''), (1, 'default2'), (2, '%C%'), (3, '%A%'), (4, ''), (5, 'C'), (6, 'A'), (7, 'C'), (8, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 7, 'C'), (1, 5, '%B%'), (-1, 1, 'A'), (2, NULL, 'default2'), (3, NULL, ''), (4, 3, ''), (5, 1, ''), (6, 4, 'default1'), (7, 1, '%B%'), (8, 4, '%A%');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT * FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM (SELECT CUSTOMER_ID, GROUP_CONCAT(PRODUCT_NAME, '') AS PRODUCTS FROM ORDERS GROUP BY CUSTOMER_ID) AS T1 WHERE PRODUCTS NOT LIKE '%C%' AND PRODUCTS LIKE '%A%' AND PRODUCTS LIKE '%B%');

/*
Prediction Result:
(1, 'default2')
*/