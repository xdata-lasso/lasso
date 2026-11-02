-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default2'), (1, '%B%'), (2, 'default1'), (-1, 'default1'), (3, 'B'), (4, 'C'), (5, '%C%');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, -1, '%A%'), (0, NULL, '%C%'), (1, 5, 'B'), (-1, 2, '%B%'), (3, 1, 'default2'), (4, 0, '%B%'), (5, 0, 'B'), (6, 5, '%C%'), (7, 4, '%B%'), (8, 1, 'A'), (9, 4, '%A%'), (10, 3, 'C'), (11, 0, 'C'), (12, 2, NULL), (13, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, GROUP_CONCAT(PRODUCT_NAME) AS PRODUCT_NAMES FROM ORDERS AS O GROUP BY 1 HAVING PRODUCT_NAMES LIKE '%A%' AND PRODUCT_NAMES LIKE '%B%' AND PRODUCT_NAMES NOT LIKE '%C%') AS O JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = O.CUSTOMER_ID;

/*
Prediction Result:
(4, 'C')
*/