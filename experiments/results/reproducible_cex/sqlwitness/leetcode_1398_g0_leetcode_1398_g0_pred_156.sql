-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 1, 'A'), (1, 1, 'default1'), (3, NULL, 'default2'), (0, NULL, 'B'), (2, NULL, 'C'), (4, 1, 'A'), (5, NULL, 'A'), (6, 1, 'default2'), (7, NULL, 'default2'), (8, 1, 'A'), (9, 1, NULL), (10, 1, 'default1'), (11, NULL, 'B'), (12, 1, 'A'), (13, NULL, 'C'), (14, NULL, 'C'), (15, 1, 'default1'), (16, NULL, 'B'), (17, NULL, 'A'), (18, 1, 'default2'), (19, 1, NULL), (20, NULL, 'B'), (21, 1, 'B'), (22, NULL, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT A.CUSTOMER_ID, B.CUSTOMER_NAME FROM ORDERS AS A INNER JOIN CUSTOMERS AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID GROUP BY 1, 2 HAVING MAX(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) = 1 AND MAX(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) = 1 AND MAX(CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) = 0;

/*
Prediction Result:
(1, 'A')
*/