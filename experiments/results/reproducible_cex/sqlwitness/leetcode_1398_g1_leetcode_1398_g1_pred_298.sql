-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'B'), (-1, 'B'), (1, 'A'), (0, 'A'), (3, 'B'), (4, NULL), (5, 'A'), (6, 'default1'), (7, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 5, 'C'), (-1, NULL, 'A'), (1, 1, NULL), (2, 3, 'C'), (3, 0, 'B'), (4, 1, NULL), (5, 5, NULL), (6, 4, 'default2'), (7, 0, 'A'), (8, 5, 'B'), (9, NULL, 'C'), (10, 0, 'B'), (11, 2, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(0, 'A')
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A' GROUP BY CUSTOMER_ID HAVING COUNT(*) > 0) AND CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B' GROUP BY CUSTOMER_ID HAVING COUNT(*) > 0) AND NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C' GROUP BY CUSTOMER_ID HAVING COUNT(*) > 0) ORDER BY CUSTOMER_ID;

/*
Prediction Result:
*/