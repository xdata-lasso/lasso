-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'B'), (2, 'C'), (1, 'A'), (-1, 'C'), (3, 'A'), (4, 'C'), (5, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 4, 'C'), (0, 5, 'default1'), (3, 5, 'default2'), (-1, 3, 'A'), (2, 0, 'B'), (4, 2, 'default1'), (5, 4, 'default1'), (6, 5, 'default1'), (7, 0, 'default1'), (8, 1, 'default2'), (9, -1, NULL), (10, 3, 'A'), (11, NULL, 'C'), (12, 1, NULL), (13, 3, 'B'), (14, 0, 'A'), (15, 0, 'default1'), (16, 0, 'B'), (17, 2, 'B'), (18, 3, 'C'), (19, 5, 'A'), (20, 1, 'C'), (21, 2, 'default1'), (22, -1, 'B'), (23, 1, 'C'), (24, 2, 'B'), (25, 3, 'C'), (26, 4, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT A.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME = 'A' OR PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) AS ABCNT, COALESCE(SUM(CASE WHEN PRODUCT_NAME = 'C' THEN 1 END), 0) AS CCNT FROM ORDERS AS ORDERS GROUP BY CUSTOMER_ID) AS A JOIN CUSTOMERS AS CUSTOMERS ON A.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID WHERE ABCNT >= 2 AND CCNT = 0;

/*
Prediction Result:
(0, 'B')
(2, 'C')
*/