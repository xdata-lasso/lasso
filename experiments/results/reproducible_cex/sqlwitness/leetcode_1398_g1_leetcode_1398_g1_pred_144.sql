-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default1'), (1, 'C'), (2, 'A'), (-1, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, -1, 'default1'), (2, 1, 'B'), (1, 2, NULL), (0, 1, 'A'), (3, 2, 'C'), (4, NULL, 'B'), (5, 1, 'C'), (6, 1, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT A.CUSTOMER_ID FROM (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AS A INNER JOIN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID WHERE NOT A.CUSTOMER_ID IN ((SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C')));

/*
Prediction Result:
(1, 'C')
*/