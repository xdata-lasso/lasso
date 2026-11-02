-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'C'), (-1, 'A'), (1, 'C'), (0, 'default2'), (3, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 3, 'B'), (1, NULL, 'B'), (0, 2, 'default1'), (-1, NULL, 'A'), (3, 1, 'default2'), (4, 3, 'B'), (5, NULL, 'default2'), (6, 1, 'A'), (7, -1, 'default2'), (8, 2, 'A'), (9, NULL, 'B'), (10, 2, 'default1'), (11, 3, 'B'), (12, NULL, NULL), (13, 1, NULL), (14, 3, NULL), (15, 2, 'B'), (16, 0, 'default2'), (17, NULL, 'C'), (18, 0, 'A'), (19, 3, NULL), (20, 3, 'default2'), (21, 3, 'C'), (22, -1, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C CROSS JOIN ORDERS AS O WHERE C.CUSTOMER_ID = O.CUSTOMER_ID GROUP BY 1 HAVING SUM(O.PRODUCT_NAME = 'A') > 0 AND SUM(O.PRODUCT_NAME = 'B') > 0 AND SUM(O.PRODUCT_NAME = 'C') = 0;

/*
Prediction Result:
(2, 'C')
*/