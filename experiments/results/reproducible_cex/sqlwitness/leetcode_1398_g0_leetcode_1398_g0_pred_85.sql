-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'C'), (2, 'B'), (0, 'default1'), (3, 'C'), (4, 'A'), (5, 'C'), (6, 'A'), (7, NULL), (8, NULL), (9, 'A'), (10, 'C'), (11, 'default2'), (12, 'default1'), (13, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 9, 'default1'), (0, 3, 'B'), (3, 9, 'default2'), (2, 1, 'C'), (4, 9, 'default1'), (5, 3, 'A'), (6, 1, 'B'), (7, 9, 'C'), (8, 7, 'default1'), (9, 8, 'default1'), (10, 11, 'B'), (11, 2, 'A'), (12, NULL, 'default2'), (13, 3, 'A'), (14, 3, 'default1'), (15, 8, 'C'), (16, NULL, 'C'), (17, 11, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH BOUGHTS AS (SELECT CUSTOMER_ID, COUNT(DISTINCT PRODUCT_NAME) AS CNT FROM ORDERS WHERE PRODUCT_NAME IN ('A', 'B') GROUP BY CUSTOMER_ID), NOTS AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C' GROUP BY CUSTOMER_ID) SELECT B.CUSTOMER_ID, C.CUSTOMER_NAME FROM BOUGHTS AS B INNER JOIN CUSTOMERS AS C ON B.CUSTOMER_ID = C.CUSTOMER_ID LEFT JOIN NOTS AS N ON B.CUSTOMER_ID = N.CUSTOMER_ID WHERE N.CUSTOMER_ID IS NULL AND B.CNT = 2;

/*
Prediction Result:
(3, 'C')
(11, 'default2')
*/