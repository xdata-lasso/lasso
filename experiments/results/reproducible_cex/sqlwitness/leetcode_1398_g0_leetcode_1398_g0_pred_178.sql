-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, NULL), (3, 'B'), (0, 'A'), (1, 'default2'), (2, 'A'), (4, 'C'), (5, 'C'), (6, 'default1'), (7, 'B'), (8, 'A'), (9, 'B'), (10, 'C'), (11, NULL), (12, 'A'), (13, 'default2'), (14, 'default1'), (15, NULL), (16, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 6, 'A'), (1, NULL, 'default2'), (3, 0, 'default1'), (2, 3, 'B'), (0, 10, 'C'), (4, 11, 'default1'), (5, 5, NULL), (6, 12, 'default1'), (7, 5, 'default1'), (8, 13, 'default1'), (9, 5, 'default1'), (10, 11, 'A'), (11, 14, 'A'), (12, 13, NULL), (13, -1, 'default1'), (14, 13, 'B'), (15, NULL, 'C'), (16, 11, 'default1'), (17, 10, 'default2'), (18, 3, 'B'), (19, -1, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT O.CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS AS O JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID GROUP BY C.CUSTOMER_NAME, O.CUSTOMER_ID HAVING SUM(CASE WHEN O.PRODUCT_NAME IN ('A', 'B') THEN 1 WHEN O.PRODUCT_NAME IN ('C') THEN 0.5 ELSE 0 END) = 2;

/*
Prediction Result:
(3, 'B')
*/