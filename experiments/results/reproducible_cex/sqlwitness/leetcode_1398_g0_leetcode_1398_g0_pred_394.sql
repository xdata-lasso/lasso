-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'A'), (3, NULL), (2, NULL), (1, 'A'), (0, 'A'), (4, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 4, NULL), (-1, 2, 'A'), (1, 1, 'default2'), (3, NULL, 'C'), (2, 1, 'B'), (4, 4, 'default2'), (5, 3, 'A'), (6, 0, 'A'), (7, 1, 'C'), (8, 1, 'C'), (9, 4, 'default2'), (10, -1, NULL), (11, 4, 'B'), (12, -1, 'default1'), (13, 2, 'B'), (14, 1, 'default1'), (15, 1, 'B'), (16, 0, 'B'), (17, 3, 'default2'), (18, 0, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT A.CUSTOMER_ID, A.CUSTOMER_NAME FROM CUSTOMERS AS A LEFT JOIN (SELECT ORDER_ID, CUSTOMER_ID, PRODUCT_NAME FROM ORDERS) AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID GROUP BY 1, 2 HAVING SUM(B.PRODUCT_NAME = 'A') > 0 AND SUM(B.PRODUCT_NAME = 'B') > 0 AND SUM(B.PRODUCT_NAME = 'C') = 0;

/*
Prediction Result:
(0, 'A')
(2, None)
*/