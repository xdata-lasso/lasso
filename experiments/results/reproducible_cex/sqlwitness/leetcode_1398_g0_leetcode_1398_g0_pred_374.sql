-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'C'), (3, 'default2'), (0, 'B'), (-1, 'C'), (2, 'B'), (4, 'B'), (5, 'default2'), (6, NULL), (7, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (3, 3, 'B'), (2, 4, 'default1'), (0, 7, 'A'), (1, 2, 'B'), (-1, 2, 'B'), (4, 1, NULL), (5, 5, 'B'), (6, NULL, 'C'), (7, 3, 'default2'), (8, 5, 'B'), (9, 0, NULL), (10, 6, 'C'), (11, 0, 'C'), (12, 6, NULL), (13, 6, 'C'), (14, 0, 'A'), (15, 6, NULL), (16, 5, 'A'), (17, 3, 'default2'), (18, 5, 'A'), (19, 4, 'default1'), (20, 0, NULL), (21, NULL, 'C'), (22, 4, 'C'), (23, 3, 'default1'), (24, 1, 'default2'), (25, 1, 'C'), (26, 3, 'default2'), (27, 1, 'A'), (28, 0, 'C'), (29, 4, 'A'), (30, NULL, 'default2'), (31, 7, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT O1.CUSTOMER_ID, C1.CUSTOMER_NAME, SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) AS CA, SUM(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) AS CB, SUM(CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) AS CC FROM ORDERS AS O1 JOIN CUSTOMERS AS C1 ON C1.CUSTOMER_ID = O1.CUSTOMER_ID GROUP BY 1, 2) AS CT WHERE CA >= 1 AND CB >= 1 AND CC = 0 ORDER BY 1, CUSTOMER_ID NULLS LAST, CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
(5, 'default2')
*/