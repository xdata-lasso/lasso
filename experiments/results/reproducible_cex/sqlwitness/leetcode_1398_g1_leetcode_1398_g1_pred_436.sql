-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, '%C%'), (3, 'A'), (1, '%A%'), (0, '%C%'), (-1, '%A%'), (4, '%C%'), (5, 'B'), (6, 'A'), (7, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 6, NULL), (0, 7, '%B%'), (2, 7, 'B'), (-1, -1, '%B%'), (3, 6, '%C%'), (4, 7, 'B'), (5, -1, 'A'), (6, 6, 'default1'), (7, 2, 'A'), (8, 1, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH PRODUCTS AS (SELECT O.CUSTOMER_ID, C.CUSTOMER_NAME, GROUP_CONCAT(O.PRODUCT_NAME) AS PRODUCTS FROM ORDERS AS O JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = O.CUSTOMER_ID GROUP BY 1, 2) SELECT DISTINCT CUSTOMER_ID, CUSTOMER_NAME FROM PRODUCTS WHERE PRODUCTS LIKE '%A%' AND PRODUCTS LIKE '%B%' AND PRODUCTS NOT LIKE '%C%' ORDER BY 1, CUSTOMER_ID NULLS LAST, CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
(-1, '%A%')
*/