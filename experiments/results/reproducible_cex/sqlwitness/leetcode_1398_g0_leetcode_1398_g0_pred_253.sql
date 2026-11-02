-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'B'), (2, 'A'), (-1, NULL), (0, 'A'), (3, 'default2'), (4, NULL), (5, 'B'), (6, NULL), (7, 'default1'), (8, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, -1, 'A'), (0, 4, 'default2'), (1, 8, 'default2'), (2, 6, 'A'), (3, 4, 'default2'), (4, 4, 'default1'), (5, 1, 'B'), (6, 7, 'A'), (7, 8, 'A'), (8, 0, 'default1'), (9, 6, 'B'), (10, NULL, 'C'), (11, 1, 'B'), (12, 7, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT A.CUSTOMER_ID, B.CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, MAX(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) AS A, MAX(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) AS B, MAX(CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS A JOIN CUSTOMERS AS B USING (CUSTOMER_ID) WHERE A = 1 AND B = 1 AND C <> 1 ORDER BY A.CUSTOMER_ID, B.customer_id NULLS LAST;

/*
Prediction Result:
(6, None)
*/