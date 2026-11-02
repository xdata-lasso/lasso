-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default1'), (1, 'B'), (2, 'B'), (3, NULL), (4, 'A'), (5, 'default1'), (6, 'A'), (7, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 3, 'default1'), (1, 4, 'A'), (0, 3, 'A'), (3, 7, 'B'), (4, 2, NULL), (5, 1, 'C'), (6, 4, 'A'), (7, 6, 'default2'), (8, 1, 'default1'), (9, 2, NULL), (10, 1, 'A'), (11, 6, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT X.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C INNER JOIN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') AND PRODUCT_NAME IN ('A', 'B') GROUP BY 1 HAVING COUNT(*) > 1) AS X ON X.CUSTOMER_ID = C.CUSTOMER_ID;

/*
Prediction Result:
(4, 'A')
*/