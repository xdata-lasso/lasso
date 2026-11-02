-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, NULL), (1, NULL), (100, 'default1'), (3, 'A'), (0, 'default2'), (101, 'B'), (-1, NULL), (99, 'default2'), (4, 'C'), (5, NULL), (6, 'default2'), (7, 'B'), (8, 'A'), (9, 'default1'), (10, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 7, 'A'), (1, 7, NULL), (3, 4, 'A'), (2, 0, 'C'), (101, -1, 'A'), (0, 99, NULL), (100, 2, 'default2'), (99, 101, NULL), (4, 6, 'A'), (5, 3, NULL), (6, 7, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME = 'A' OR PRODUCT_NAME = 'B' THEN 1 WHEN PRODUCT_NAME = 'C' THEN -100 ELSE 0 END) AS SCORE FROM ORDERS GROUP BY 1) AS A LEFT JOIN CUSTOMERS AS C ON A.CUSTOMER_ID = C.CUSTOMER_ID WHERE SCORE >= 2;

/*
Prediction Result:
(7, 'B')
*/