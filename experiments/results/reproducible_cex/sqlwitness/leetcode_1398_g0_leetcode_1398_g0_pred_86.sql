-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, NULL), (2, '0'), (1, NULL), (-1, 'default1'), (3, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 1, '0'), (1, 2, 'C'), (2, NULL, '1'), (-1, NULL, '1'), (3, 2, 'C'), (4, NULL, 'default2'), (5, NULL, NULL), (6, 0, NULL), (7, 0, NULL), (8, NULL, 'default2'), (9, -1, '1'), (10, -1, NULL), (11, -1, NULL), (12, 1, 'A'), (13, 1, 'A'), (14, 2, NULL), (15, 0, 'default2'), (16, 3, 'A'), (17, -1, 'default1'), (18, 3, 'B'), (19, 0, NULL), (20, -1, '0'), (21, -1, 'default2'), (22, NULL, 'C'), (23, 1, NULL), (24, 1, NULL), (25, -1, '1'), (26, 3, NULL), (27, 0, 'C'), (28, -1, 'B'), (29, NULL, '0');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT O.CUSTOMER_ID, C.CUSTOMER_NAME, O.PRODUCT_NAME, SUM(IIF(PRODUCT_NAME = 'A', '1', '0')) AS A, SUM(IIF(PRODUCT_NAME = 'B', '1', '0')) AS B, SUM(IIF(PRODUCT_NAME = 'C', '1', '0')) AS C FROM CUSTOMERS AS C LEFT JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID GROUP BY 1) SELECT CTE.CUSTOMER_ID, CTE.CUSTOMER_NAME FROM CTE WHERE A = 1 AND B = 1 AND C = 0;

/*
Prediction Result:
(3, None)
*/