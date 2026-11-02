-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default2'), (1, 'default1'), (-1, 'A'), (2, 'A'), (3, 'default1'), (4, 'A'), (5, 'default2'), (6, 'default1'), (7, 'A'), (8, 'B'), (9, NULL), (10, 'default1'), (11, 'A'), (12, 'A'), (13, 'default1'), (14, NULL), (15, NULL), (16, 'C'), (17, 'B'), (18, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 7, 'C'), (1, 6, 'A'), (-1, 18, NULL), (0, 6, 'B'), (3, -1, 'B'), (4, 17, 'C'), (5, NULL, 'C'), (6, 7, 'C'), (7, 1, 'C'), (8, 6, 'default2'), (9, 11, 'B'), (10, 7, 'default2'), (11, NULL, NULL), (12, 1, NULL), (13, 13, 'B'), (14, 5, 'B'), (15, 15, 'default2'), (16, 15, 'C'), (17, 13, 'default2'), (18, 0, 'B'), (19, 8, 'default1'), (20, 7, 'default2'), (21, 2, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(6, 'default1')
*/

-- Prediction Query
SELECT DISTINCT A.CUSTOMER_ID, B.CUSTOMER_NAME FROM (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A' AND CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C')) AS A LEFT JOIN CUSTOMERS AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID;

/*
Prediction Result:
*/