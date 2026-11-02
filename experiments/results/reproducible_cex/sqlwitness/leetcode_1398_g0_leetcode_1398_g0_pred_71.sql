-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'default1'), (3, 'default1'), (-1, 'default2'), (2, 'A'), (0, 'B'), (4, 'default2'), (5, 'C'), (6, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 0, NULL), (3, 0, 'A'), (1, NULL, 'A'), (-1, 2, 'B'), (0, 4, 'C'), (4, 3, 'C'), (5, 4, 'C'), (6, 1, 'default2'), (7, 6, 'default2'), (8, 5, NULL), (9, 1, 'default2'), (10, 3, 'C'), (11, 2, 'A'), (12, 2, 'default1'), (13, 2, NULL), (14, 0, 'default2'), (15, 1, 'B'), (16, 4, 'B'), (17, 1, 'B'), (18, 6, 'default1'), (19, 3, 'C'), (20, 0, 'default1'), (21, 5, 'A'), (22, -1, 'default1'), (23, 1, 'default2'), (24, 6, NULL), (25, 2, NULL), (26, NULL, 'default2'), (27, 0, 'B'), (28, -1, 'default2'), (29, 0, 'default1'), (30, NULL, 'default1'), (31, 3, NULL), (32, 1, 'B'), (33, 5, 'default1'), (34, NULL, 'B'), (35, 2, 'C'), (36, NULL, 'A'), (37, 4, 'C'), (38, 6, 'C'), (39, 4, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(0, 'B')
*/

-- Prediction Query
WITH CTE AS (SELECT O.CUSTOMER_ID, C.CUSTOMER_NAME, SUM(PRODUCT_NAME = 'A') AS COUNTA, SUM(PRODUCT_NAME = 'B') AS COUNTB, SUM(PRODUCT_NAME = 'C') AS COUNTC FROM ORDERS AS O LEFT JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID GROUP BY 1, 2) SELECT CTE.CUSTOMER_ID, CTE.CUSTOMER_NAME FROM CTE WHERE COUNTA > 0 AND COUNTB > 0 AND COUNTC = 0;

/*
Prediction Result:
(None, None)
(0, 'B')
*/