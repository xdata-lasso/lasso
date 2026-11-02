-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'B'), (2, 'A'), (-1, NULL), (1, 'C'), (3, 'B'), (4, 'default1'), (5, 'A'), (6, 'A'), (7, 'B'), (8, 'default1'), (9, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 5, 'A'), (0, 9, 'B'), (1, 7, 'A'), (-1, 2, 'default1'), (3, 3, 'A'), (4, 4, 'A'), (5, 7, 'A'), (6, 9, NULL), (7, 3, 'B'), (8, 8, 'default1'), (9, 2, NULL), (10, 5, NULL), (11, 1, NULL), (12, 3, 'default2'), (13, NULL, 'default2'), (14, NULL, 'C'), (15, 3, 'default1'), (16, 9, 'A'), (17, 1, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(3, 'B')
(9, 'B')
*/

-- Prediction Query
SELECT DISTINCT A.CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT * FROM ORDERS WHERE PRODUCT_NAME = 'A') AS A JOIN (SELECT * FROM ORDERS WHERE PRODUCT_NAME = 'B') AS B USING (CUSTOMER_ID) JOIN CUSTOMERS USING (CUSTOMER_ID) WHERE NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
*/