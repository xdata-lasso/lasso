-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'C'), (2, 'A'), (-1, 'C'), (1, 'A'), (3, 'B'), (4, 'B'), (5, NULL), (6, NULL), (7, 'A'), (8, 'C'), (9, 'default1'), (10, 'default1'), (11, 'default2'), (12, NULL), (13, 'A'), (14, 'default2'), (15, 'A'), (16, 'C'), (17, 'B'), (18, 'default1'), (19, 'B'), (20, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 14, 'default2'), (1, 11, NULL), (2, 17, NULL), (0, 16, 'default1'), (3, 1, NULL), (4, 1, 'C'), (5, 7, 'A'), (6, 11, 'B'), (7, 5, 'default2'), (8, 15, 'C'), (9, 9, 'C'), (10, 12, NULL), (11, 19, 'C'), (12, 14, 'C'), (13, 14, 'B'), (14, 10, 'A'), (15, 12, 'C'), (16, 10, 'B'), (17, 18, NULL), (18, 13, 'default2'), (19, 12, 'default2'), (20, 12, 'A'), (21, NULL, 'B'), (22, 12, NULL), (23, 14, NULL), (24, 4, 'A'), (25, 11, 'B'), (26, 19, NULL), (27, 14, 'C'), (28, 10, 'B'), (29, 17, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(10, 'default1')
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM (SELECT CUSTOMER_ID, COUNT(CASE WHEN PRODUCT_NAME = 'A' THEN 1 END) AS PROD_A, COUNT(CASE WHEN PRODUCT_NAME = 'B' THEN 1 END) AS PROD_B, COUNT(CASE WHEN PRODUCT_NAME = 'C' THEN 1 END) AS PROD_C FROM ORDERS GROUP BY 1) AS X WHERE PROD_A = 1 AND PROD_B = 1 AND PROD_C = 0);

/*
Prediction Result:
*/