-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, NULL), (3, 'default1'), (0, 'default1'), (-1, 'default1'), (2, 'C'), (4, 'A'), (5, 'default1'), (6, 'B'), (7, 'C'), (8, 'B'), (9, 'C'), (10, 'B'), (11, 'C'), (12, NULL), (13, 'default1'), (14, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 8, 'default2'), (3, 11, NULL), (-1, 8, 'A'), (0, 13, NULL), (2, 12, 'default2'), (4, 13, NULL), (5, 12, 'A'), (6, 12, 'A'), (7, 3, 'C'), (8, 14, 'B'), (9, 8, 'default1'), (10, 6, NULL), (11, 3, 'A'), (12, 2, NULL), (13, 4, 'B'), (14, NULL, 'A'), (15, 0, 'C'), (16, 12, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT C.CUSTOMER_ID, CUSTOMER_NAME, SUM(CNT) AS TC FROM (SELECT CUSTOMER_ID, CASE WHEN PRODUCT_NAME = 'A' THEN 1 WHEN PRODUCT_NAME = 'B' THEN 1 WHEN PRODUCT_NAME = 'C' THEN -1 ELSE 0 END AS CNT FROM ORDERS) AS T JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = T.CUSTOMER_ID GROUP BY C.CUSTOMER_ID) AS T1 WHERE TC >= 2;

/*
Prediction Result:
(12, None)
*/