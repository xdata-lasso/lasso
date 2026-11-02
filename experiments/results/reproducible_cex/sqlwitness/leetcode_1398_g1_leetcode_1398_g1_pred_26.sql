-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, NULL), (1, 'A'), (-1, 'default2'), (2, 'C'), (3, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 3, 'default2'), (-1, 1, 'B'), (1, 2, NULL), (2, 1, NULL), (3, 2, 'default2'), (4, 2, 'default2'), (5, 3, NULL), (6, 0, 'C'), (7, 3, 'B'), (8, 2, 'default1'), (9, 3, NULL), (10, 2, 'C'), (11, 2, 'A'), (12, -1, 'default1'), (13, -1, 'C'), (14, 3, NULL), (15, 3, NULL), (16, 3, 'default2'), (17, 1, NULL), (18, 3, 'A'), (19, 2, 'A'), (20, NULL, 'default1'), (21, -1, 'A'), (22, 3, 'default1'), (23, 0, 'default2'), (24, 0, 'C'), (25, 0, 'A'), (26, 0, 'C'), (27, NULL, 'C'), (28, -1, 'default2'), (29, 3, 'B'), (30, NULL, NULL), (31, 1, 'C'), (32, 0, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(3, 'C')
*/

-- Prediction Query
SELECT A.CUSTOMER_ID, CUST.CUSTOMER_NAME FROM (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AS A INNER JOIN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID INNER JOIN CUSTOMERS AS CUST ON A.CUSTOMER_ID = CUST.CUSTOMER_ID WHERE NOT A.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
*/