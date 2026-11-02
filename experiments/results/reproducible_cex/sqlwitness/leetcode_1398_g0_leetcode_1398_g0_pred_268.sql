-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default1'), (-1, 'default2'), (2, 'C'), (1, 'A'), (3, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, -1, 'B'), (3, -1, 'C'), (1, 2, 'C'), (0, 2, 'A'), (-1, -1, 'A'), (4, 3, 'B'), (5, 1, 'B'), (6, NULL, 'B'), (7, 0, 'B'), (8, NULL, 'C'), (9, 3, 'A'), (10, 2, 'A'), (11, 0, NULL), (12, NULL, 'default1'), (13, -1, 'default1'), (14, -1, 'default1'), (15, 3, NULL), (16, 1, NULL), (17, 2, 'A'), (18, 1, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT A.CUSTOMER_ID, A.CUSTOMER_NAME FROM CUSTOMERS AS A CROSS JOIN ORDERS AS B WHERE A.CUSTOMER_ID = B.CUSTOMER_ID GROUP BY 1, 2 HAVING SUM(B.PRODUCT_NAME = 'B') <> 0 AND SUM(B.PRODUCT_NAME = 'A') <> 0 AND SUM(B.PRODUCT_NAME = 'C') = 0;

/*
Prediction Result:
(3, 'default1')
*/