-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'default1'), (0, 'B'), (2, 'B'), (3, 'default1'), (4, 'A'), (5, NULL), (6, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 3, 'B'), (0, 4, 'A'), (2, 3, NULL), (3, 1, NULL), (4, 0, 'default2'), (5, 0, 'C'), (6, 2, 'A'), (7, 3, 'B'), (8, 2, 'B'), (9, 4, 'C'), (10, 3, 'A'), (11, 4, 'default1'), (12, 6, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(2, 'B')
(3, 'default1')
*/

-- Prediction Query
SELECT B.* FROM (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') AND CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B')) AS A LEFT JOIN CUSTOMERS AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID;

/*
Prediction Result:
(3, 'default1')
(2, 'B')
*/