-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'default1'), (2, NULL), (0, 'C'), (1, 'A'), (3, 'A'), (4, 'C'), (5, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 4, 'default1'), (0, -1, 'A'), (-1, -1, 'A'), (2, 3, 'C'), (3, -1, 'B'), (4, 0, 'A'), (5, 1, 'A'), (6, 3, 'A'), (7, -1, 'A'), (8, 4, 'default1'), (9, 5, 'C'), (10, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(-1, 'default1')
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS JOIN CUSTOMERS USING (CUSTOMER_ID) GROUP BY CUSTOMER_ID HAVING SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) = 1 AND SUM(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) = 1 AND SUM(CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) = 0;

/*
Prediction Result:
*/