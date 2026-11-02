-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, NULL), (-1, 'default1'), (2, 'A,B%'), (0, 'B'), (3, 'A'), (4, 'B'), (5, '%C%'), (6, 'default2'), (7, 'A,B%'), (8, 'C'), (9, 'A,B%'), (10, NULL), (11, 'C'), (12, 'B'), (13, 'A,B%');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 2, 'C'), (2, 7, NULL), (-1, 2, 'B'), (0, 8, 'A,B%'), (3, 7, '%C%'), (4, 8, 'A,B%'), (5, 1, 'default1'), (6, NULL, 'default2'), (7, 5, 'default2'), (8, 8, 'A'), (9, 5, '%C%'), (10, 2, 'B'), (11, 7, '%C%'), (12, 4, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT O.CUSTOMER_ID, C.CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, GROUP_CONCAT(DISTINCT PRODUCT_NAME) AS LIST FROM ORDERS GROUP BY 1) AS O JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID AND O.LIST LIKE 'A,B%' AND O.LIST NOT LIKE '%C%' ORDER BY 1, C.customer_id NULLS LAST;

/*
Prediction Result:
(8, 'C')
*/