-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default2'), (1, NULL), (2, 'default2'), (3, 'default1'), (4, 'B'), (5, 'default2'), (6, 'C'), (7, 'default2'), (8, NULL), (9, 'C'), (10, 'default1'), (11, 'B'), (12, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 3, 'A'), (0, 10, 'default2'), (2, 0, NULL), (3, 8, NULL), (4, 10, 'C'), (5, 12, 'default1'), (6, 0, 'B'), (7, 8, 'default1'), (8, 1, 'default2'), (9, 7, 'C'), (10, NULL, 'C'), (11, 5, 'A'), (12, 9, 'default1'), (13, 7, 'default2'), (14, 10, 'default2'), (15, NULL, 'A'), (16, 5, 'A'), (17, 7, 'default2'), (18, 1, 'default1'), (19, 0, 'A'), (20, 6, 'A'), (21, NULL, 'C'), (22, 1, 'C'), (23, 6, 'A'), (24, 10, 'C'), (25, 10, 'A'), (26, 4, 'B'), (27, 7, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH TEMP1 AS (SELECT DISTINCT O1.CUSTOMER_ID FROM ORDERS AS O1 CROSS JOIN ORDERS AS O2 WHERE O1.CUSTOMER_ID = O2.CUSTOMER_ID AND O1.PRODUCT_NAME = 'A' AND O2.PRODUCT_NAME = 'B'), TEMP2 AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') SELECT T1.CUSTOMER_ID, CUSTOMER_NAME FROM TEMP1 AS T1 LEFT JOIN TEMP2 AS T2 ON T1.CUSTOMER_ID = T2.CUSTOMER_ID JOIN CUSTOMERS AS C ON T1.CUSTOMER_ID = C.CUSTOMER_ID WHERE T2.CUSTOMER_ID IS NULL;

/*
Prediction Result:
(0, 'default2')
*/