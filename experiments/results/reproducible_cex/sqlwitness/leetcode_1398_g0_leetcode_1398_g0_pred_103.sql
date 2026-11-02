-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, NULL), (0, 'A'), (2, NULL), (3, 'A'), (4, 'B'), (5, 'A'), (6, NULL), (7, 'default2'), (8, 'default1'), (9, 'A'), (10, 'default2'), (11, NULL), (12, 'B'), (13, 'B'), (14, 'A'), (15, 'default1'), (16, 'C'), (17, 'A'), (18, 'default1'), (19, 'default1'), (20, 'default1'), (21, NULL), (22, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 19, 'A'), (0, 5, 'A'), (2, 15, 'default1'), (3, 15, NULL), (4, NULL, 'B'), (5, 22, NULL), (6, 8, 'A'), (7, 14, NULL), (8, 22, 'default2'), (9, 0, 'B'), (10, NULL, 'B'), (11, 8, 'B'), (12, 0, 'A'), (13, 14, 'default1'), (14, 10, 'C'), (15, 2, 'default2'), (16, 12, 'C'), (17, 6, 'default2'), (18, 19, 'default2'), (19, 3, 'default2'), (20, 12, 'default1'), (21, 5, 'default2'), (22, 6, 'B'), (23, 11, 'default2'), (24, 17, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(0, 'A')
(8, 'default1')
*/

-- Prediction Query
SELECT A.CUSTOMER_ID, CUSTOMERS.CUSTOMER_NAME FROM (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AS A JOIN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID LEFT JOIN CUSTOMERS ON A.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID WHERE NOT A.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(8, 'default1')
(0, 'A')
*/