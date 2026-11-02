-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'B'), (1, NULL), (-1, NULL), (0, NULL), (3, 'default2'), (4, 'default1'), (5, 'B'), (6, 'B'), (7, 'A'), (8, 'A'), (9, 'C'), (10, 'B'), (11, 'A'), (12, 'C'), (13, 'B'), (14, 'A'), (15, 'A'), (16, 'B'), (17, 'default1'), (18, 'default1'), (19, 'C'), (20, 'C'), (21, 'B'), (22, 'default2'), (23, 'default2'), (24, 'A'), (25, 'default2'), (26, 'default2'), (27, 'B'), (28, 'A'), (29, 'default2'), (30, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 28, 'C'), (-1, 26, 'default2'), (1, 16, 'default2'), (2, 26, 'C'), (3, 4, 'C'), (4, 28, 'C'), (5, 0, NULL), (6, 9, 'B'), (7, 22, 'default2'), (8, 10, 'B'), (9, 2, 'B'), (10, 9, 'A'), (11, 12, 'B'), (12, 23, 'default2'), (13, 15, 'B'), (14, 11, 'default2'), (15, 10, NULL), (16, 21, 'C'), (17, 22, 'C'), (18, 17, 'B'), (19, 5, 'C'), (20, 19, NULL), (21, 17, 'default1'), (22, 28, 'C'), (23, 5, 'C'), (24, NULL, 'C'), (25, 2, 'default1'), (26, 20, 'A'), (27, 28, 'B'), (28, 13, 'A'), (29, 18, 'C'), (30, 30, 'B'), (31, 26, 'B'), (32, 14, 'default2'), (33, 25, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(9, 'C')
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME IN ('C')) ORDER BY CUSTOMER_ID;

/*
Prediction Result:
*/