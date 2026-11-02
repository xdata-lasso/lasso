-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'A'), (1, NULL), (0, NULL), (-1, 'C'), (3, 'C'), (4, 'default2'), (5, 'B'), (6, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 6, 'default2'), (2, 5, 'default1'), (-1, 5, 'A'), (1, -1, 'A'), (3, 1, NULL), (4, -1, 'C'), (5, NULL, 'default1'), (6, 2, 'A'), (7, 1, NULL), (8, NULL, 'C'), (9, 0, 'C'), (10, 2, NULL), (11, -1, 'default2'), (12, 5, 'default2'), (13, -1, 'C'), (14, 4, 'B'), (15, 5, NULL), (16, 5, 'B'), (17, -1, NULL), (18, 2, NULL), (19, 4, 'B'), (20, -1, 'default1'), (21, 3, 'A'), (22, 5, NULL), (23, 2, 'A'), (24, -1, 'A'), (25, 6, 'C'), (26, 0, 'C'), (27, 0, 'default2'), (28, 6, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(5, 'B')
*/

-- Prediction Query
SELECT SUB1.CUSTOMER_ID, C.CUSTOMER_NAME FROM (SELECT DISTINCT O.CUSTOMER_ID FROM ORDERS AS O WHERE PRODUCT_NAME IN ('A') AND O.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT O.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C')) AS SUB1 JOIN CUSTOMERS AS C ON SUB1.CUSTOMER_ID = C.CUSTOMER_ID;

/*
Prediction Result:
*/