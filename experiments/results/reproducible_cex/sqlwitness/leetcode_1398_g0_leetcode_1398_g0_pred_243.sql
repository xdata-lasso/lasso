-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default1'), (1, 'B'), (-1, NULL), (2, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 0, 'default1'), (1, -1, 'C'), (-1, 2, 'A'), (2, NULL, NULL), (3, 0, 'B'), (4, NULL, 'C'), (5, NULL, 'A'), (6, 1, 'A'), (7, -1, NULL), (8, 0, 'default2'), (9, -1, 'A'), (10, 1, 'B'), (11, 0, 'A'), (12, 1, 'default2'), (13, -1, 'default2'), (14, 2, 'C'), (15, 2, NULL), (16, -1, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O USING (CUSTOMER_ID) GROUP BY C.CUSTOMER_ID HAVING (SUM(O.PRODUCT_NAME = 'A') > 0 AND SUM(O.PRODUCT_NAME = 'B') > 0 AND SUM(O.PRODUCT_NAME = 'C') = 0) ORDER BY C.CUSTOMER_ID ASC, C.CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
(0, 'default1')
(1, 'B')
*/