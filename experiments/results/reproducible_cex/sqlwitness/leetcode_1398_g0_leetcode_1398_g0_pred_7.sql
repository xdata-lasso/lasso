-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'A'), (0, 'B'), (2, 'B'), (3, 'A'), (4, 'default2'), (5, 'default2'), (6, 'default1'), (7, NULL), (8, 'default1'), (9, 'A'), (10, 'C'), (11, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 11, 'A'), (0, 4, 'default1'), (2, NULL, 'B'), (3, 11, 'A'), (4, 4, 'B'), (5, 9, NULL), (6, 7, NULL), (7, 5, 'B'), (8, 2, NULL), (9, 8, NULL), (10, 3, 'default1'), (11, 0, NULL), (12, 6, 'B'), (13, 6, 'default1'), (14, 0, 'default2'), (15, 5, 'C'), (16, 4, 'B'), (17, 7, 'A'), (18, 6, NULL), (19, 1, NULL), (20, 10, NULL), (21, 2, 'C'), (22, 5, 'C'), (23, 10, 'default1'), (24, 7, 'default2'), (25, 0, NULL), (26, 11, 'B'), (27, 11, 'default1'), (28, 6, 'default2'), (29, NULL, 'C'), (30, 5, 'B'), (31, 7, NULL), (32, 5, 'B'), (33, 9, 'B'), (34, 11, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE C.CUSTOMER_ID IN (SELECT D.CUSTOMER_ID FROM CUSTOMERS AS D JOIN ORDERS AS E ON D.CUSTOMER_ID = E.CUSTOMER_ID WHERE E.PRODUCT_NAME = 'A') AND C.CUSTOMER_ID IN (SELECT D.CUSTOMER_ID FROM CUSTOMERS AS D JOIN ORDERS AS E ON D.CUSTOMER_ID = E.CUSTOMER_ID WHERE E.PRODUCT_NAME = 'B') AND NOT C.CUSTOMER_ID IN (SELECT D.CUSTOMER_ID FROM CUSTOMERS AS D JOIN ORDERS AS E ON D.CUSTOMER_ID = E.CUSTOMER_ID WHERE E.PRODUCT_NAME = 'C') ORDER BY C.CUSTOMER_ID, C.CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
(11, None)
*/