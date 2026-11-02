-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, NULL), (-1, 'A'), (1, 'B'), (3, 'A'), (2, 'C'), (4, NULL), (5, 'default2'), (6, 'default1'), (7, 'B'), (8, 'C'), (9, NULL), (10, NULL), (11, 'default1'), (12, 'B'), (13, 'default2'), (14, 'A'), (15, 'C'), (16, 'C'), (17, 'default1'), (18, 'default2'), (19, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (3, 8, 'B'), (2, 17, NULL), (1, 3, 'default2'), (0, 10, 'B'), (-1, 6, NULL), (4, -1, 'C'), (5, 2, 'default1'), (6, NULL, 'C'), (7, 16, 'B'), (8, 17, 'A'), (9, 1, 'C'), (10, 4, 'default1'), (11, 15, NULL), (12, 7, NULL), (13, 14, NULL), (14, 15, 'B'), (15, 10, NULL), (16, 11, NULL), (17, 3, 'A'), (18, 2, 'default2'), (19, NULL, 'A'), (20, NULL, 'default2'), (21, 13, 'B'), (22, 14, 'B'), (23, 3, 'default1'), (24, 17, 'A'), (25, 10, 'default1'), (26, 15, 'B'), (27, 13, 'A'), (28, 7, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT A.CUSTOMER_ID, A.CUSTOMER_NAME FROM CUSTOMERS AS A JOIN ORDERS AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID GROUP BY 1, 2 HAVING SUM(B.PRODUCT_NAME = 'A') > 0 AND SUM(B.PRODUCT_NAME = 'B') > 0 AND SUM(B.PRODUCT_NAME = 'C') = 0;

/*
Prediction Result:
(13, 'default2')
*/