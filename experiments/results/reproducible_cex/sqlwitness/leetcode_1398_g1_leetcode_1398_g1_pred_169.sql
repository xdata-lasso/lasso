-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'C'), (-1, 'C'), (1, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, NULL, 'A'), (-1, NULL, 'default2'), (0, -1, 'A'), (2, -1, 'B'), (3, NULL, 'default2'), (4, 1, 'default1'), (5, 1, 'B'), (6, 1, NULL), (7, 0, 'default2'), (8, NULL, 'default2'), (9, NULL, 'C'), (10, -1, 'A'), (11, 1, 'C'), (12, 1, 'B'), (13, 1, 'C'), (14, NULL, 'default1'), (15, 1, 'A'), (16, -1, 'default2'), (17, 1, 'C'), (18, NULL, 'C'), (19, 0, 'C'), (20, -1, 'default1'), (21, 1, 'B'), (22, 1, 'default1'), (23, -1, 'B'), (24, -1, 'default1'), (25, -1, 'A'), (26, -1, NULL), (27, -1, 'B'), (28, -1, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(-1, 'C')
*/

-- Prediction Query
SELECT DISTINCT T.CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS AS T JOIN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AS A USING (CUSTOMER_ID) WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
*/