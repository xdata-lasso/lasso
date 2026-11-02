-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'C'), (-1, 'default1'), (2, NULL), (1, NULL), (3, 'default2'), (4, NULL), (5, 'A'), (6, 'B'), (7, 'default2'), (8, 'default1'), (9, 'A'), (10, 'B'), (11, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 8, NULL), (-1, 1, 'A'), (0, -1, 'B'), (1, 7, 'default1'), (3, 6, 'A'), (4, 0, 'C'), (5, 0, 'default1'), (6, 4, 'C'), (7, 4, 'default2'), (8, 9, 'C'), (9, 2, 'B'), (10, NULL, 'default2'), (11, 11, 'B'), (12, 8, 'default2'), (13, 7, 'default1'), (14, NULL, 'default2'), (15, 6, 'B'), (16, NULL, 'default1'), (17, 3, NULL), (18, 10, NULL), (19, 9, 'B'), (20, 9, 'B'), (21, 9, 'B'), (22, NULL, 'C'), (23, 8, 'A'), (24, 6, 'B'), (25, 10, 'default1'), (26, 5, 'A'), (27, 0, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(6, 'B')
*/

-- Prediction Query
SELECT DISTINCT A1.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM ((SELECT CUSTOMER_ID FROM ORDERS WHERE NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C')) AS A1 JOIN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AS A2 ON A1.CUSTOMER_ID = A2.CUSTOMER_ID JOIN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AS A3 ON A1.CUSTOMER_ID = A3.CUSTOMER_ID) JOIN CUSTOMERS AS C ON A1.CUSTOMER_ID = C.CUSTOMER_ID;

/*
Prediction Result:
*/