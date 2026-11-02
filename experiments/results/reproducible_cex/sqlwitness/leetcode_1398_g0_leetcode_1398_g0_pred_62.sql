-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'C'), (-1, 'C'), (2, 'default2'), (3, NULL), (1, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, NULL, 'default1'), (3, 2, NULL), (0, 2, NULL), (2, 2, NULL), (-1, 3, 'default2'), (4, 3, 'C'), (5, 1, NULL), (6, 3, 'B'), (7, 1, 'default1'), (8, 0, 'default2'), (9, 2, 'C'), (10, 1, 'default2'), (11, 3, 'default2'), (12, 3, NULL), (13, 1, 'default2'), (14, 0, 'default2'), (15, -1, 'C'), (16, -1, NULL), (17, 0, NULL), (18, 0, NULL), (19, NULL, 'C'), (20, -1, 'A'), (21, NULL, 'default1'), (22, 0, 'default2'), (23, 3, NULL), (24, 1, 'B'), (25, 3, NULL), (26, 3, 'A'), (27, 3, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT A.CUSTOMER_ID, CUSTOMER_NAME, SUM(A.TYPE_COUNT) OVER (PARTITION BY A.CUSTOMER_ID) AS TYPE_VALUE FROM (SELECT O.CUSTOMER_ID, C.CUSTOMER_NAME, CASE WHEN O.PRODUCT_NAME = 'A' THEN 1 WHEN O.PRODUCT_NAME = 'B' THEN 1 WHEN O.PRODUCT_NAME = 'C' THEN -1 ELSE 0 END AS TYPE_COUNT FROM ORDERS AS O INNER JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID) AS A) AS BB WHERE TYPE_VALUE = 2 GROUP BY CUSTOMER_ID;

/*
Prediction Result:
(3, None)
*/