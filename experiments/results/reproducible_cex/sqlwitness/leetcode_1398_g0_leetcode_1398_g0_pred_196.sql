-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'C'), (0, 'default1'), (1, 'default2'), (3, 'default2'), (4, NULL), (5, 'default2'), (6, 'A'), (7, 'A'), (8, 'C'), (9, 'default2'), (10, 'B'), (11, NULL), (12, NULL), (13, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 6, 'C'), (1, 1, 'B'), (3, 4, 'B'), (0, 1, 'B'), (4, 12, 'B'), (5, 11, NULL), (6, 12, 'default1'), (7, NULL, NULL), (8, 1, 'default2'), (9, 3, 'C'), (10, 8, 'C'), (11, 3, 'default2'), (12, 0, 'default1'), (13, 6, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH BOUGHT_AB AS (SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C LEFT JOIN ORDERS AS O USING (CUSTOMER_ID) WHERE PRODUCT_NAME = 'A' OR PRODUCT_NAME = 'B' GROUP BY 1, 2 HAVING COUNT(PRODUCT_NAME) >= 2) SELECT CUSTOMER_ID, CUSTOMER_NAME FROM BOUGHT_AB WHERE NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(1, 'default2')
*/