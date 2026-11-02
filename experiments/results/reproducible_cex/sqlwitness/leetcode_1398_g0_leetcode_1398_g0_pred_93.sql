-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'A'), (-1, 'C'), (1, NULL), (0, 'default2'), (3, 'default1'), (4, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, NULL, 'A'), (1, 3, 'B'), (-1, 3, 'default1'), (2, 0, 'C'), (3, 2, NULL), (4, 1, 'default1'), (5, 3, 'default2'), (6, 3, 'default2'), (7, -1, 'default1'), (8, 2, 'default1'), (9, NULL, 'C'), (10, -1, 'default2'), (11, 3, 'default1'), (12, 4, 'default2'), (13, 4, 'default2'), (14, 4, 'C'), (15, 2, 'default2'), (16, -1, 'A'), (17, 2, NULL), (18, 1, NULL), (19, 3, 'A'), (20, -1, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT * FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS AS O GROUP BY CUSTOMER_ID HAVING SUM(CASE WHEN O.PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN O.PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN O.PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) = 0);

/*
Prediction Result:
(3, 'default1')
*/