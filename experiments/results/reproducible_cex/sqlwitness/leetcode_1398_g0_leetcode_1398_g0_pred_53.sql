-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'C'), (2, 'C'), (-1, 'default1'), (0, 'default2'), (3, 'C'), (4, 'B'), (5, 'A'), (6, 'default2'), (7, NULL), (8, 'default1'), (9, 'A'), (10, 'B'), (11, 'C'), (12, 'default2'), (13, 'A'), (14, 'A'), (15, 'default2'), (16, 'B'), (17, NULL), (18, 'C'), (19, 'A'), (20, 'A'), (21, NULL), (22, 'A'), (23, 'default2'), (24, 'default2'), (25, 'B'), (26, NULL), (27, NULL), (28, 'default2'), (29, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (3, 1, 'default2'), (0, 13, 'A'), (2, 15, 'default1'), (1, NULL, 'C'), (-1, 19, 'default1'), (4, 27, 'A'), (5, 18, 'A'), (6, 29, 'A'), (7, 15, NULL), (8, 14, 'A'), (9, 13, 'B'), (10, 13, NULL), (11, 0, 'B'), (12, 6, 'default1'), (13, -1, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT O.CUSTOMER_ID, C.CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME IN ('A', 'B') THEN 1 WHEN PRODUCT_NAME = 'C' THEN -1 ELSE 0 END) AS PRODUCT_COUNT FROM (SELECT DISTINCT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS) AS T1 GROUP BY CUSTOMER_ID) AS O INNER JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE O.PRODUCT_COUNT = 2;

/*
Prediction Result:
(13, 'A')
*/