-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'B'), (-1, 'A'), (1, 'A'), (2, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 1, 'B'), (0, 0, NULL), (1, 0, 'default2'), (2, -1, 'default1'), (3, 0, NULL), (4, 2, 'C'), (5, 0, 'B'), (6, 1, 'A'), (7, 1, 'default2'), (8, 2, 'C'), (9, 0, 'default2'), (10, NULL, 'C'), (11, -1, 'default2'), (12, NULL, 'default1'), (13, NULL, 'C'), (14, -1, 'B'), (15, NULL, 'C'), (16, NULL, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT A.CUSTOMER_ID, A.CUSTOMER_NAME FROM CUSTOMERS AS A JOIN ORDERS AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID GROUP BY B.CUSTOMER_ID HAVING SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) > 0 AND SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) > 0 AND SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) = 0;

/*
Prediction Result:
(1, 'A')
*/