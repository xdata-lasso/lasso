-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'C'), (0, 'default1'), (2, NULL), (3, NULL), (4, 'default1'), (5, 'default1'), (6, 'default2'), (7, 'C'), (8, 'default1'), (9, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 9, NULL), (1, 8, 'default2'), (2, 0, NULL), (3, 3, NULL), (4, 8, 'default1'), (5, 1, 'C'), (6, 1, 'B'), (7, 2, 'B'), (8, 6, NULL), (9, 6, 'A'), (10, 7, 'A'), (11, 8, 'C'), (12, 9, 'default1'), (13, 9, 'default2'), (14, 9, NULL), (15, 8, 'C'), (16, 5, 'A'), (17, 7, NULL), (18, 9, 'A'), (19, 0, 'default2'), (20, 9, 'C'), (21, NULL, 'B'), (22, 7, NULL), (23, 4, 'C'), (24, 1, 'B'), (25, 1, 'default2'), (26, 0, 'default2'), (27, 0, 'default1'), (28, 2, 'A'), (29, 6, 'B'), (30, 0, 'B'), (31, 7, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(2, None)
(6, 'default2')
*/

-- Prediction Query
SELECT DISTINCT A.CUSTOMER_ID, A.CUSTOMER_NAME FROM (SELECT O.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS AS O LEFT JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID WHERE PRODUCT_NAME IN ('A')) AS A JOIN (SELECT O.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS AS O LEFT JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID WHERE PRODUCT_NAME IN ('B')) AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID WHERE NOT A.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME IN ('C'));

/*
Prediction Result:
(6, 'default2')
(2, None)
*/