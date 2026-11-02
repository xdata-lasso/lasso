-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'C'), (2, 'B'), (0, 'C'), (1, 'default2'), (3, 'default1'), (4, 'A'), (5, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 4, 'A'), (0, 0, 'default1'), (2, 2, 'A'), (-1, NULL, 'B'), (3, NULL, NULL), (4, 2, 'B'), (5, 0, 'A'), (6, 3, 'default2'), (7, NULL, 'B'), (8, 4, 'A'), (9, 4, 'B'), (10, 5, 'default1'), (11, 3, 'A'), (12, NULL, 'C'), (13, 5, 'default2'), (14, -1, NULL), (15, 0, 'default1'), (16, 2, NULL), (17, -1, 'A'), (18, 3, 'C'), (19, NULL, 'default2'), (20, 5, NULL), (21, NULL, 'default1'), (22, 4, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE_IS_BOUGHT AS (SELECT S.CUSTOMER_ID, S.CUSTOMER_NAME, MAX(CASE WHEN O.PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) AS IS_BOUGHT_A, MAX(CASE WHEN O.PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) AS IS_BOUGHT_B, MAX(CASE WHEN O.PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) AS IS_BOUGHT_C FROM CUSTOMERS AS S INNER JOIN ORDERS AS O ON O.CUSTOMER_ID = S.CUSTOMER_ID GROUP BY S.CUSTOMER_ID, S.CUSTOMER_NAME) SELECT DISTINCT CUSTOMER_ID, CUSTOMER_NAME FROM CTE_IS_BOUGHT WHERE IS_BOUGHT_A = 1 AND IS_BOUGHT_B = 1 AND IS_BOUGHT_C = 0 ORDER BY CUSTOMER_ID, CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
(2, 'B')
(4, 'A')
*/