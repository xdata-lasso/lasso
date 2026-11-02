-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, NULL), (2, 'C'), (0, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 1, 'default1'), (1, NULL, 'B'), (2, 1, 'B'), (3, 2, 'A'), (0, 2, 'default2'), (4, 1, NULL), (5, 1, 'default1'), (6, 2, 'C'), (7, NULL, 'B'), (8, 1, 'default2'), (9, 0, 'default1'), (10, 1, 'A'), (11, NULL, 'A'), (12, 2, NULL), (13, NULL, 'C'), (14, 0, 'default2'), (15, 0, NULL), (16, 0, 'default2'), (17, 0, 'A'), (18, 0, NULL), (19, NULL, NULL), (20, 2, 'C'), (21, 1, 'default2'), (22, NULL, 'A'), (23, 0, 'A'), (24, NULL, 'C'), (25, 2, 'B'), (26, 1, NULL), (27, NULL, NULL), (28, NULL, 'A'), (29, 1, 'B'), (30, 0, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM ORDERS AS O LEFT JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID GROUP BY 1, 2 HAVING SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) = 0 ORDER BY 1, C.CUSTOMER_ID NULLS LAST, C.CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
(0, 'C')
(1, None)
*/