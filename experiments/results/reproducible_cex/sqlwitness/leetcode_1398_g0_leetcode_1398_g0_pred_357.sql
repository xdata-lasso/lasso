-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (3, 'default1'), (0, 'default1'), (1, 'default1'), (2, 'A'), (-1, 'default1'), (4, 'C'), (5, NULL), (6, NULL), (7, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, NULL, NULL), (1, 6, 'default2'), (0, NULL, 'default2'), (3, 5, 'C'), (2, 3, 'B'), (4, -1, 'B'), (5, 3, 'default2'), (6, 3, 'B'), (7, 3, NULL), (8, NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT ORD.CUSTOMER_ID, CUS.CUSTOMER_NAME, SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 WHEN PRODUCT_NAME = 'B' THEN 1 WHEN PRODUCT_NAME = 'C' THEN -1 ELSE 0 END) AS SCORE FROM ORDERS AS ORD JOIN CUSTOMERS AS CUS ON ORD.CUSTOMER_ID = CUS.CUSTOMER_ID GROUP BY 1) AS A WHERE SCORE >= 2;

/*
Prediction Result:
(3, 'default1')
*/