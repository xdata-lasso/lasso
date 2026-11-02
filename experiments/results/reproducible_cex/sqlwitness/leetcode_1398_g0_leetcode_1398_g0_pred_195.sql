-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default1'), (1, 'default2'), (2, NULL), (3, 'A'), (4, 'default1'), (5, 'A'), (6, 'default1'), (7, 'B'), (8, 'default2'), (9, 'C'), (10, NULL), (11, 'A'), (12, 'default1'), (13, NULL), (14, 'default1'), (15, 'default1'), (16, 'C'), (17, 'B'), (18, 'default2'), (19, 'A'), (20, NULL), (21, 'C'), (22, 'B'), (23, 'C'), (24, 'B'), (25, 'default1'), (26, 'B'), (27, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 5, 'C'), (1, 6, NULL), (2, 7, 'default1'), (3, 1, NULL), (4, 26, 'B'), (5, 19, 'default1'), (6, 9, 'default2'), (7, 0, 'A'), (8, 2, 'A'), (9, 19, 'default2'), (10, 23, 'default1'), (11, 4, 'B'), (12, 7, 'C'), (13, 21, 'C'), (14, 11, 'B'), (15, 9, 'B'), (16, 13, NULL), (17, 26, 'default1'), (18, 18, 'A'), (19, 18, 'B'), (20, 16, 'C'), (21, 21, NULL), (22, 1, 'default2'), (23, 8, 'default1'), (24, 11, 'B'), (25, 9, 'A'), (26, NULL, NULL), (27, 21, 'B'), (28, 23, 'C'), (29, 21, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(9, 'C')
(18, 'default2')
*/

-- Prediction Query
WITH BOUGHT_A AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A'), BOUGHT_B AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B'), BOUGHT_C AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') SELECT BOUGHT_A.CUSTOMER_ID, CUSTOMERS.CUSTOMER_NAME FROM BOUGHT_A INNER JOIN BOUGHT_B USING (CUSTOMER_ID) INNER JOIN CUSTOMERS USING (CUSTOMER_ID) WHERE NOT BOUGHT_A.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM BOUGHT_C);

/*
Prediction Result:
(18, 'default2')
(9, 'C')
*/