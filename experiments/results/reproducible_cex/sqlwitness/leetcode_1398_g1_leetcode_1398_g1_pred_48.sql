-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'B'), (0, '%A%'), (2, 'A'), (1, 'default1'), (3, '%A%'), (4, '%B%'), (5, NULL), (6, 'A'), (7, '%B%'), (8, '%C%'), (9, NULL), (10, '%A%'), (11, '%A%'), (12, 'default1'), (13, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 11, 'default2'), (0, 12, '%C%'), (2, 9, 'A'), (1, 7, 'A'), (3, 3, 'C'), (4, 12, 'C'), (5, 1, '%B%'), (6, 1, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS JOIN CUSTOMERS USING (CUSTOMER_ID) GROUP BY CUSTOMER_ID HAVING GROUP_CONCAT(PRODUCT_NAME) LIKE '%A%' AND GROUP_CONCAT(PRODUCT_NAME) LIKE '%B%' AND GROUP_CONCAT(PRODUCT_NAME) NOT LIKE '%C%';

/*
Prediction Result:
(1, 'default1')
*/