-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default2'), (2, 'B'), (1, 'default1'), (3, 'default1'), (4, 'C'), (5, 'B'), (6, 'B'), (7, NULL), (8, 'B'), (9, 'B'), (10, 'default2'), (11, 'default1'), (12, 'A'), (13, 'default2'), (14, 'default1'), (15, 'C'), (16, NULL), (17, 'default2'), (18, 'default2'), (19, 'default2'), (20, 'C'), (21, 'A'), (22, 'default2'), (23, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 15, 'C'), (2, 7, 'A'), (1, 18, 'C'), (3, 1, 'B'), (4, 1, 'default2'), (5, 4, 'default2'), (6, 10, 'B'), (7, 7, 'A'), (8, 21, NULL), (9, 7, 'B'), (10, 21, 'B'), (11, NULL, 'A'), (12, 9, 'default2'), (13, 10, 'A'), (14, 16, 'C'), (15, 21, 'default2'), (16, 12, 'C'), (17, 5, 'B'), (18, 19, 'B'), (19, 9, NULL), (20, 4, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(7, None)
(10, 'default2')
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM ORDERS AS O INNER JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID WHERE PRODUCT_NAME IN ('A', 'B') AND NOT C.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') GROUP BY C.CUSTOMER_ID, C.CUSTOMER_NAME HAVING COUNT(C.CUSTOMER_NAME) = 2;

/*
Prediction Result:
(10, 'default2')
*/