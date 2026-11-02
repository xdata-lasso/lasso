-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'A'), (1, 'B'), (-1, 'B'), (2, 'default2'), (3, 'A'), (4, 'C'), (5, NULL), (6, 'A'), (7, 'default1'), (8, 'B'), (9, 'C'), (10, 'default2'), (11, 'default2'), (12, 'default2'), (13, 'C'), (14, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 3, 'default2'), (-1, 11, 'default1'), (1, NULL, 'A'), (2, 14, 'C'), (3, 0, 'B'), (4, 13, 'A'), (5, 4, 'A'), (6, 7, 'C'), (7, 5, 'A'), (8, 3, 'default2'), (9, 5, 'C'), (10, NULL, 'default2'), (11, 13, 'B'), (12, 12, 'default2'), (13, 4, 'B'), (14, 11, 'default1'), (15, 10, 'default2'), (16, 0, 'default1'), (17, 13, 'default1'), (18, NULL, 'B'), (19, 12, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(4, 'C')
(13, 'C')
*/

-- Prediction Query
WITH T1 AS (SELECT T_A.CUSTOMER_ID FROM (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AS T_A JOIN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AS T_B ON T_A.CUSTOMER_ID = T_B.CUSTOMER_ID) SELECT DISTINCT T1.CUSTOMER_ID, CUSTOMER_NAME FROM T1 JOIN CUSTOMERS AS C ON T1.CUSTOMER_ID = C.CUSTOMER_ID AND NOT T1.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(13, 'C')
(4, 'C')
*/