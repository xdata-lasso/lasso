-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, NULL), (2, 'A'), (-1, '%B%'), (1, 'C'), (3, 'C'), (4, 'B'), (5, '%C%'), (6, '%C%'), (7, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 7, 'default1'), (2, -1, 'A'), (-1, NULL, 'C'), (1, NULL, NULL), (3, 6, '%B%'), (4, 2, 'C'), (5, 7, 'A'), (6, 5, 'A'), (7, 5, '%B%'), (8, 6, NULL), (9, NULL, '%A%'), (10, 0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH TABLE1 AS (SELECT CUSTOMER_ID, GROUP_CONCAT(PRODUCT_NAME) AS TOTAL_PRODUCT FROM ORDERS GROUP BY 1) SELECT TABLE1.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME AS CUSTOMER_NAME FROM TABLE1 LEFT JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = TABLE1.CUSTOMER_ID WHERE TOTAL_PRODUCT LIKE '%A%' AND TOTAL_PRODUCT LIKE '%B%' AND TOTAL_PRODUCT NOT LIKE '%C%';

/*
Prediction Result:
(5, '%C%')
*/