-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'A'), (-1, 'default1'), (3, 'C'), (0, 'default2'), (2, 'B'), (4, 'C'), (5, 'C'), (6, NULL), (7, 'C'), (8, 'B'), (9, 'default1'), (10, 'A'), (11, 'C'), (12, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (3, NULL, 'A'), (-1, 6, 'C'), (0, 2, 'B'), (1, 7, 'B'), (2, 11, NULL), (4, 7, 'default2'), (5, 11, 'A'), (6, 3, 'A'), (7, 0, NULL), (8, 0, 'default2'), (9, 2, 'default1'), (10, 0, 'A'), (11, 0, 'C'), (12, 2, 'default2'), (13, 8, 'A'), (14, NULL, 'B'), (15, 12, 'default2'), (16, 1, 'C'), (17, 2, 'B'), (18, 6, 'A'), (19, 11, 'C'), (20, 7, 'A'), (21, 11, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(7, 'C')
*/

-- Prediction Query
WITH SUBTABLE AS (SELECT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS GROUP BY CUSTOMER_ID, PRODUCT_NAME), TABLE2 AS (SELECT CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 WHEN PRODUCT_NAME = 'B' THEN 1 WHEN PRODUCT_NAME = 'C' THEN -1 ELSE 0 END) AS PERSON_VALUE FROM SUBTABLE GROUP BY CUSTOMER_ID) SELECT T.CUSTOMER_ID, C.CUSTOMER_NAME FROM TABLE2 AS T LEFT JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = T.CUSTOMER_ID WHERE PERSON_VALUE = 2;

/*
Prediction Result:
(None, None)
(7, 'C')
*/