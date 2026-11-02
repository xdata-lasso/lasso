-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'B'), (0, 'default1'), (3, 'B'), (-1, 'B'), (1, 'B'), (4, 'B'), (5, 'default1'), (6, 'default1'), (7, 'C'), (8, NULL), (9, NULL), (10, 'default1'), (11, NULL), (12, 'B'), (13, 'A'), (14, 'B'), (15, 'A'), (16, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 8, 'C'), (1, 6, 'default2'), (-1, 16, 'B'), (3, 10, 'default1'), (0, 3, 'default1'), (4, 13, 'C'), (5, 8, NULL), (6, 6, 'A'), (7, 6, 'B'), (8, 5, 'default2'), (9, 3, 'default1'), (10, 6, 'A'), (11, -1, NULL), (12, -1, 'A'), (13, 4, 'A'), (14, NULL, 'C'), (15, -1, 'A'), (16, -1, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT B.CUSTOMER_ID, C.CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(FLAG) AS FLAGS FROM (SELECT CUSTOMER_ID, CASE WHEN PRODUCT_NAME = 'C' THEN -1 WHEN PRODUCT_NAME = 'A' THEN 1 WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END AS FLAG FROM (SELECT DISTINCT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS WHERE PRODUCT_NAME = 'A' OR PRODUCT_NAME = 'B' OR PRODUCT_NAME = 'C') AS D) AS A GROUP BY CUSTOMER_ID) AS B LEFT JOIN CUSTOMERS AS C ON B.CUSTOMER_ID = C.CUSTOMER_ID WHERE FLAGS = 2;

/*
Prediction Result:
(6, 'default1')
*/