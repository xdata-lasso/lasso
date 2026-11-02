-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, '%A%'), (1, '%B%'), (-1, '%B%'), (2, '%A%'), (3, 'default2'), (4, '%B%'), (5, 'default2'), (6, 'default1'), (7, 'default2'), (8, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, NULL, '%A%'), (1, 6, 'B'), (-1, 3, 'C'), (0, 2, 'B'), (3, 8, NULL), (4, 0, '%A%'), (5, 7, 'A'), (6, 0, 'B'), (7, 4, 'B'), (8, 2, '%B%'), (9, 8, 'default2'), (10, 5, 'B'), (11, 6, 'C'), (12, NULL, 'C'), (13, NULL, 'A'), (14, 3, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT CUSTOMERS.CUSTOMER_ID, CUSTOMERS.CUSTOMER_NAME FROM CUSTOMERS LEFT JOIN (SELECT CUSTOMER_ID, GROUP_CONCAT(PRODUCT_NAME) AS SHOPLIST FROM ORDERS GROUP BY CUSTOMER_ID) AS T1 ON CUSTOMERS.CUSTOMER_ID = T1.CUSTOMER_ID WHERE SHOPLIST LIKE '%A%' AND SHOPLIST LIKE '%B%' AND SHOPLIST NOT LIKE '%C%';

/*
Prediction Result:
(0, '%A%')
*/