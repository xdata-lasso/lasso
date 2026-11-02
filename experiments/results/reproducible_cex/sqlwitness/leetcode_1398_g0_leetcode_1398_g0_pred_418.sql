-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'default2'), (0, 'B'), (-1, 'A'), (2, NULL), (3, 'B'), (4, 'default1'), (5, 'A'), (6, 'B'), (7, 'default2'), (8, 'default2'), (9, 'default1'), (10, 'default1'), (11, 'default2'), (12, 'C'), (13, 'C'), (14, NULL), (15, 'default1'), (16, 'C'), (17, NULL), (18, NULL), (19, 'default2'), (20, 'default1'), (21, 'default2'), (22, NULL), (23, 'C'), (24, 'A'), (25, NULL), (26, 'default2'), (27, 'B'), (28, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 22, 'C'), (-1, 3, 'A'), (0, 12, NULL), (2, 7, 'B'), (3, 5, NULL), (4, 10, 'default1'), (5, 6, 'C'), (6, 26, 'default2'), (7, 20, 'B'), (8, 19, NULL), (9, 14, 'default2'), (10, 8, NULL), (11, 3, NULL), (12, 3, 'B'), (13, -1, 'C'), (14, 26, NULL), (15, 2, 'default1'), (16, 19, 'A'), (17, 10, 'default1'), (18, 22, NULL), (19, 21, 'default2'), (20, 1, 'B'), (21, 18, 'default2'), (22, NULL, 'C'), (23, 7, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT A.CUSTOMER_ID, A.CUSTOMER_NAME FROM CUSTOMERS AS A LEFT JOIN ORDERS AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID GROUP BY A.CUSTOMER_ID HAVING SUM(B.PRODUCT_NAME = 'A') > 0 AND SUM(B.PRODUCT_NAME = 'B') > 0 AND SUM(B.PRODUCT_NAME = 'C') = 0;

/*
Prediction Result:
(3, 'B')
*/