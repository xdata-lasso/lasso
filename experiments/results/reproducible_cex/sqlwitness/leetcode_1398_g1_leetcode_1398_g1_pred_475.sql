-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'default2'), (3, NULL), (2, 'default2'), (0, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, NULL, NULL), (-1, NULL, NULL), (0, NULL, 'default1'), (2, 3, 'B'), (3, 2, 'A'), (4, 0, 'default1'), (5, 1, 'B'), (6, 0, 'A'), (7, NULL, NULL), (8, 0, 'default1'), (9, NULL, 'A'), (10, 1, NULL), (11, 2, 'B'), (12, 2, NULL), (13, NULL, 'default1'), (14, 0, 'C'), (15, 1, 'B'), (16, 3, NULL), (17, 3, 'B'), (18, 1, 'default1'), (19, 2, 'default1'), (20, NULL, 'B'), (21, 3, NULL), (22, 2, 'B'), (23, 0, 'C'), (24, 1, 'default1'), (25, 1, 'A'), (26, NULL, 'C'), (27, 2, NULL), (28, 1, 'default1'), (29, 3, 'default2'), (30, 0, 'C'), (31, 2, 'A'), (32, 3, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'default2')
(2, 'default2')
*/

-- Prediction Query
SELECT O.CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS AS O JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID WHERE 1 = 1 AND NOT O.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') AND O.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND O.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') GROUP BY 1, 2;

/*
Prediction Result:
*/