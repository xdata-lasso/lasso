-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'B'), (0, 'A'), (-1, NULL), (1, 'C'), (3, 'A'), (4, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 3, 'C'), (-1, NULL, 'C'), (2, 2, 'default2'), (0, NULL, NULL), (3, -1, 'A'), (4, NULL, 'default2'), (5, 3, NULL), (6, 1, 'C'), (7, 4, 'A'), (8, 3, NULL), (9, 3, 'B'), (10, NULL, 'default1'), (11, 2, 'B'), (12, 4, 'B'), (13, 2, 'default1'), (14, 1, 'default2'), (15, 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(4, 'default1')
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS AS O WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS AS O WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS AS O WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
*/