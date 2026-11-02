-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'B'), (0, 'default2'), (4, 'A'), (-1, NULL), (2, 'default2'), (3, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 1, 'A'), (0, 3, 'A'), (3, 4, 'A'), (4, 0, 'default1'), (1, 4, 'B'), (-1, 0, 'B'), (5, 2, 'B'), (6, 2, 'default1'), (7, -1, NULL), (8, NULL, 'default2'), (9, 3, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(4, 'A')
*/

-- Prediction Query
WITH CTE AS (SELECT DISTINCT CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME IN ('A', 'B', 'C') THEN 1 ELSE 0 END) AS CNT, SUM(CASE WHEN PRODUCT_NAME IN ('A', 'B') THEN 1 ELSE 0 END) AS CNT1 FROM ORDERS GROUP BY CUSTOMER_ID HAVING SUM(CASE WHEN PRODUCT_NAME IN ('A', 'B', 'C') THEN 1 ELSE 0 END) <> 3 AND SUM(CASE WHEN PRODUCT_NAME IN ('A', 'B') THEN 1 ELSE 0 END) = 2) SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CTE AS C1 INNER JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = C1.CUSTOMER_ID;

/*
Prediction Result:
(3, 'default1')
(4, 'A')
*/