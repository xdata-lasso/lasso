-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (3, 'default2'), (2, NULL), (0, 'default2'), (1, 'default1'), (4, 'C'), (5, NULL), (6, 'B'), (7, 'C'), (8, 'default2'), (9, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, NULL, 'C'), (1, 5, NULL), (3, 8, 'default2'), (2, 1, 'C'), (4, 2, 'default1'), (5, 8, NULL), (6, 9, NULL), (7, 8, 'C'), (8, 7, NULL), (9, 6, 'B'), (10, 1, 'B'), (11, 7, 'default2'), (12, NULL, NULL), (13, 0, 'A'), (14, 7, 'B'), (15, 2, 'A'), (16, 8, 'default2'), (17, 1, 'A'), (18, 3, 'B'), (19, 5, 'C'), (20, 6, 'default1'), (21, 3, NULL), (22, 1, 'default2'), (23, 0, 'A'), (24, 2, 'B'), (25, 9, 'A'), (26, 9, 'C'), (27, 8, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT A.CUSTOMER_ID, C.CUSTOMER_NAME FROM (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME IN ('A', 'B') GROUP BY CUSTOMER_ID HAVING COUNT(DISTINCT PRODUCT_NAME) = 2) AS A JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = A.CUSTOMER_ID WHERE NOT A.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME IN ('A', 'B', 'C') GROUP BY CUSTOMER_ID HAVING COUNT(DISTINCT PRODUCT_NAME) = 3);

/*
Prediction Result:
(2, None)
*/