-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'A'), (0, 'default1'), (2, 'default2'), (3, 'default1'), (4, 'C'), (5, 'default2'), (6, 'default1'), (7, 'B'), (8, 'A'), (9, 'default1'), (10, 'A'), (11, 'default2'), (12, 'default2'), (13, 'A'), (14, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 11, 'default1'), (0, 6, 'default2'), (2, 0, 'C'), (3, 5, NULL), (4, NULL, 'B'), (5, 6, 'default1'), (6, 9, 'A'), (7, 10, 'A'), (8, 7, NULL), (9, 5, 'B'), (10, 12, 'C'), (11, 9, 'B'), (12, 12, 'default1'), (13, 8, 'A'), (14, 8, 'B'), (15, 3, 'C'), (16, 3, 'default2'), (17, NULL, NULL), (18, 11, 'B'), (19, 4, NULL), (20, 0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(8, 'A')
(9, 'default1')
*/

-- Prediction Query
SELECT DISTINCT A.CUSTOMER_ID, B.CUSTOMER_NAME FROM (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A' AND CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C')) AS A LEFT JOIN CUSTOMERS AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID;

/*
Prediction Result:
(9, 'default1')
(8, 'A')
*/