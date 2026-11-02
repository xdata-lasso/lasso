-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'A'), (2, NULL), (-1, NULL), (0, 'C'), (3, 'B'), (4, NULL), (5, 'default2'), (6, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 6, 'default2'), (2, 0, 'A'), (0, 6, 'A'), (1, 5, 'default2'), (3, -1, 'A'), (4, 5, 'default2'), (5, 3, 'C'), (6, 0, 'C'), (7, 0, 'B'), (8, -1, NULL), (9, 5, 'default1'), (10, NULL, 'C'), (11, NULL, 'default2'), (12, -1, 'default2'), (13, 2, 'B'), (14, 5, 'B'), (15, 6, 'default2'), (16, NULL, 'B'), (17, 4, 'B'), (18, NULL, 'C'), (19, -1, NULL), (20, 1, 'C'), (21, 2, NULL), (22, 2, 'B'), (23, 6, 'B'), (24, 0, 'B'), (25, 4, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH CUSTAB_C AS (SELECT CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) AS A, SUM(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) AS B, SUM(CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) AS C FROM ORDERS GROUP BY CUSTOMER_ID HAVING A > 0 AND B > 0 AND C = 0) SELECT CO.CUSTOMER_ID, CO.CUSTOMER_NAME FROM CUSTOMERS AS CO JOIN (SELECT CUSTOMER_ID FROM CUSTAB_C) AS A ON CO.CUSTOMER_ID = A.CUSTOMER_ID;

/*
Prediction Result:
(6, 'default2')
*/