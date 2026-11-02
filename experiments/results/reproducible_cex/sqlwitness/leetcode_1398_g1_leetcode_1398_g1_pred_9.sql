-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, NULL), (-1, NULL), (1, 'A'), (2, 'A'), (3, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 1, 'A'), (1, 0, 'default2'), (0, NULL, 'C'), (2, 2, 'B'), (3, NULL, 'C'), (4, 1, 'default2'), (5, 0, 'B'), (6, 2, 'default1'), (7, -1, 'C'), (8, 3, 'A'), (9, 3, 'default2'), (10, 3, 'B'), (11, -1, NULL), (12, -1, 'A'), (13, NULL, 'default2'), (14, NULL, NULL), (15, 3, NULL), (16, 2, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(3, 'default2')
*/

-- Prediction Query
SELECT DISTINCT CUSTOMERS.CUSTOMER_ID, CUSTOMERS.CUSTOMER_NAME FROM ORDERS LEFT JOIN CUSTOMERS ON ORDERS.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID WHERE CUSTOMERS.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMERS.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMERS.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
*/