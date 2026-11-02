-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'default1'), (0, NULL), (2, 'default2'), (3, 'B'), (4, NULL), (5, 'default1'), (6, NULL), (7, 'A'), (8, NULL), (9, 'default2'), (10, 'A'), (11, 'default2'), (12, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, NULL, NULL), (1, 10, 'C'), (2, 5, 'default1'), (3, 9, 'C'), (4, 6, 'default1'), (5, 7, 'default1'), (6, 10, 'A'), (7, 2, NULL), (8, 10, 'default1'), (9, 4, 'default1'), (10, 7, NULL), (11, 4, 'default1'), (12, 6, 'default1'), (13, 1, 'A'), (14, 12, 'A'), (15, 2, 'C'), (16, 1, 'default1'), (17, 8, 'A'), (18, 9, 'A'), (19, 2, 'A'), (20, 6, 'A'), (21, 5, 'default1'), (22, NULL, 'default2'), (23, 1, 'B'), (24, 0, 'B'), (25, 12, 'default2'), (26, 1, 'B'), (27, 9, NULL), (28, 8, 'C'), (29, 0, 'B'), (30, 0, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(0, None)
(1, 'default1')
*/

-- Prediction Query
WITH CTE AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A' AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B')) SELECT CTE.CUSTOMER_ID, CUSTOMERS.CUSTOMER_NAME FROM CTE LEFT JOIN CUSTOMERS ON CTE.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID WHERE NOT CTE.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(1, 'default1')
(0, None)
*/