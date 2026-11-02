-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default2'), (-1, 'A,B%'), (2, 'default2'), (1, NULL), (3, 'C'), (4, '%C%'), (5, '%C%'), (6, '%C%'), (7, 'C'), (8, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, -1, NULL), (-1, 1, NULL), (0, 2, 'A,B%'), (1, 5, 'default2'), (3, 5, 'default2'), (4, 6, '%C%'), (5, 7, 'B'), (6, 7, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS NATURAL JOIN ORDERS GROUP BY CUSTOMER_ID, CUSTOMER_NAME HAVING GROUP_CONCAT(DISTINCT PRODUCT_NAME) LIKE 'A,B%' AND GROUP_CONCAT(DISTINCT PRODUCT_NAME) NOT LIKE '%C%';

/*
Prediction Result:
(2, 'default2')
*/