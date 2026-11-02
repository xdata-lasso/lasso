-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'A'), (1, 'C'), (-1, 'C'), (2, 'default2'), (3, 'default1'), (4, 'A'), (5, 'C'), (6, 'B'), (7, 'C'), (8, 'A'), (9, 'A'), (10, 'default1'), (11, 'default2'), (12, 'A'), (13, NULL), (14, 'default2'), (15, 'default1'), (16, 'default1'), (17, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 14, NULL), (-1, NULL, 'C'), (1, 3, 'B'), (2, 2, 'default2'), (3, 15, 'default1'), (4, 2, 'default1'), (5, 6, NULL), (6, 3, 'default2'), (7, 10, 'A'), (8, 10, 'A'), (9, -1, 'A'), (10, 3, 'default2'), (11, 6, NULL), (12, 4, 'B'), (13, 10, 'B'), (14, 3, 'default2'), (15, 10, 'A'), (16, 16, NULL), (17, 5, 'B'), (18, 12, 'default1'), (19, 11, 'A'), (20, 8, 'default2'), (21, 4, 'A'), (22, 3, 'default1'), (23, 14, 'C'), (24, 17, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS JOIN CUSTOMERS USING (CUSTOMER_ID) GROUP BY CUSTOMER_ID HAVING SUM(PRODUCT_NAME = 'A') > 0 AND SUM(PRODUCT_NAME = 'B') > 0 AND SUM(PRODUCT_NAME = 'C') = 0;

/*
Prediction Result:
(4, 'A')
(10, 'default1')
*/