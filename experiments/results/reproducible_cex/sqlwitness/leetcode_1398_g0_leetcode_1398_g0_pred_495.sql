-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, NULL), (1, 'default1'), (2, NULL), (-1, 'A'), (3, NULL), (4, 'default2'), (5, 'C'), (6, 'B'), (7, 'default2'), (8, 'C'), (9, 'C'), (10, 'C'), (11, 'default1'), (12, 'B'), (13, 'default1'), (14, 'C'), (15, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 12, 'default2'), (2, 5, 'B'), (1, 11, 'C'), (0, 12, 'B'), (3, 14, 'A'), (4, 7, 'B'), (5, 8, 'A'), (6, NULL, 'C'), (7, 9, 'C'), (8, 3, 'default1'), (9, 0, 'default1'), (10, 7, NULL), (11, 4, 'A'), (12, 2, 'C'), (13, 8, 'default1'), (14, 2, 'default1'), (15, 7, 'A'), (16, 3, 'C'), (17, 7, 'C'), (18, 5, 'A'), (19, 11, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE1 AS (SELECT CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) AS A, SUM(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) AS B, SUM(CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) AS C FROM ORDERS GROUP BY 1) SELECT A.CUSTOMER_ID, B.CUSTOMER_NAME FROM CTE1 AS A INNER JOIN CUSTOMERS AS B ON TRUE WHERE A.CUSTOMER_ID = B.CUSTOMER_ID AND (A >= 1 AND B >= 1 AND C = 0);

/*
Prediction Result:
(5, 'C')
*/