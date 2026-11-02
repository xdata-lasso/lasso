-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'A'), (1, 'default1'), (-1, 'B'), (0, NULL), (3, NULL), (4, 'C'), (5, 'C'), (6, 'B'), (7, 'A'), (8, 'default2'), (9, 'B'), (10, 'default1'), (11, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 3, 'default1'), (0, 3, 'B'), (-1, -1, 'A'), (2, -1, 'default2'), (3, 4, 'C'), (4, 3, 'A'), (5, 0, 'default2'), (6, 9, 'default1'), (7, 4, 'C'), (8, 11, 'B'), (9, 4, 'default2'), (10, 6, 'default1'), (11, 1, NULL), (12, NULL, 'C'), (13, 9, 'default2'), (14, 4, 'B'), (15, 2, 'A'), (16, 9, 'B'), (17, 4, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH PROD_BUY AS (SELECT CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) AS BOUGHT_A, SUM(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) AS BOUGHT_B, SUM(CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) AS BOUGHT_C FROM ORDERS GROUP BY 1) SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM PROD_BUY WHERE BOUGHT_A > 0 AND BOUGHT_B > 0 AND BOUGHT_C = 0);

/*
Prediction Result:
(3, None)
*/