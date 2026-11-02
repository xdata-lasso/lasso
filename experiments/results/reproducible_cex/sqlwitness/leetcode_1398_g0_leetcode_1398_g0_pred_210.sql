-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'B'), (-1, NULL), (1, 'A'), (0, 'default1'), (3, 'A'), (4, 'A'), (5, 'B'), (6, 'default1'), (7, 'default2'), (8, NULL), (9, 'default2'), (10, 'C'), (11, 'default1'), (12, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, -1, 'C'), (-1, 6, 'default2'), (1, 5, 'A'), (0, 4, NULL), (3, NULL, 'C'), (4, 0, 'A'), (5, 3, 'default2'), (6, 7, 'B'), (7, 2, 'A'), (8, -1, 'default1'), (9, 1, NULL), (10, 12, 'B'), (11, 3, 'A'), (12, 8, 'B'), (13, 5, 'C'), (14, 9, 'A'), (15, 2, 'default1'), (16, 3, 'default2'), (17, 1, 'A'), (18, 2, 'B'), (19, 5, 'default2'), (20, 9, 'A'), (21, 8, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT ORDER_ID, ORDERS.CUSTOMER_ID, CUSTOMER_NAME, CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END AS A, CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END AS B, CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END AS C FROM ORDERS LEFT JOIN CUSTOMERS ON ORDERS.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID) SELECT CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, CUSTOMER_NAME, SUM(A) AS A, SUM(B) AS B, SUM(C) AS C FROM CTE GROUP BY CUSTOMER_ID) AS T WHERE A >= 1 AND B >= 1 AND C = 0;

/*
Prediction Result:
(2, 'B')
(8, None)
*/