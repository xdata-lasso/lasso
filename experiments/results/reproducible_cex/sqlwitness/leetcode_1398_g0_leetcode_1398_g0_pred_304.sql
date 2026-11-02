-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'C'), (1, 'C'), (0, 'B'), (2, 'C'), (3, 'B'), (4, 'C'), (5, 'B'), (6, 'default1'), (7, 'A'), (8, 'B'), (9, 'A'), (10, 'C'), (11, 'default2'), (12, 'default2'), (13, 'B'), (14, 'C'), (15, 'default1'), (16, 'B'), (17, 'default1'), (18, 'A'), (19, 'default1'), (20, 'default1'), (21, 'default2'), (22, 'B'), (23, 'B'), (24, 'B'), (25, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 17, 'default1'), (0, 15, 'default1'), (1, 9, 'A'), (2, 22, 'A'), (3, 24, 'A'), (4, NULL, NULL), (5, 15, 'default2'), (6, 24, 'C'), (7, 0, 'A'), (8, -1, 'C'), (9, 17, 'C'), (10, 22, 'default2'), (11, 0, 'default1'), (12, 4, NULL), (13, 12, 'default1'), (14, 19, 'B'), (15, 21, 'default1'), (16, 19, 'default2'), (17, 8, 'C'), (18, NULL, 'C'), (19, 1, NULL), (20, 8, 'default1'), (21, 0, 'default2'), (22, 22, 'B'), (23, 24, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT A.CUSTOMER_ID, A.CUSTOMER_NAME FROM CUSTOMERS AS A INNER JOIN ORDERS AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID GROUP BY A.CUSTOMER_ID HAVING SUM(B.PRODUCT_NAME = 'A') > 0 AND SUM(B.PRODUCT_NAME = 'B') > 0 AND SUM(B.PRODUCT_NAME = 'C') = 0 ORDER BY A.CUSTOMER_ID, A.CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
(22, 'B')
*/