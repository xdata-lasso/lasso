-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'A'), (1, 'default1'), (0, 'C'), (-1, NULL), (3, 'C'), (4, 'default2'), (5, NULL), (6, NULL), (7, 'B'), (8, 'default1'), (9, 'A'), (10, 'B'), (11, 'B'), (12, 'A'), (13, 'default2'), (14, NULL), (15, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 13, 'C'), (3, 9, 'default2'), (4, 8, 'C'), (0, 4, 'default1'), (1, NULL, 'C'), (2, 5, 'A'), (5, 5, 'default2'), (6, 3, 'A'), (7, 6, 'default1'), (8, 9, NULL), (9, 0, 'A'), (10, 7, 'default2'), (11, 9, 'default2'), (12, 5, 'B'), (13, 8, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT A.CUSTOMER_ID, CUSTOMER_NAME, SUM(CASE WHEN PRODUCT_NAME IN ('A', 'B') THEN 1 WHEN PRODUCT_NAME = 'C' THEN 3 ELSE 0 END) AS CNT FROM CUSTOMERS AS A JOIN (SELECT DISTINCT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS) AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID GROUP BY 1, 2) AS A WHERE CNT = 2 ORDER BY 1, CUSTOMER_ID NULLS LAST, CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
(5, None)
*/