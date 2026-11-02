-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'C'), (-1, 'C'), (1, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, -1, 'default2'), (-1, NULL, 'default1'), (0, -1, NULL), (1, NULL, 'C'), (3, 2, 'A'), (4, NULL, 'default1'), (5, 2, NULL), (6, 1, 'B'), (7, -1, 'B'), (8, NULL, 'B'), (9, -1, 'A'), (10, 2, NULL), (11, -1, 'C'), (12, 2, 'B'), (13, 1, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT B.* FROM CUSTOMERS AS B INNER JOIN (SELECT CUSTOMER_ID, COUNT(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE NULL END) AS A, COUNT(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE NULL END) AS B, COUNT(CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE NULL END) AS C FROM ORDERS GROUP BY 1) AS A ON A.CUSTOMER_ID = B.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0;

/*
Prediction Result:
(2, 'C')
*/