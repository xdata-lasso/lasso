-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'C'), (1, 'A'), (-1, 'C'), (0, 'default2'), (3, 'C'), (4, 'default2'), (5, 'C'), (6, NULL), (7, 'B'), (8, 'default2'), (9, 'A'), (10, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 4, 'B'), (1, 1, 'C'), (-1, 4, 'B'), (0, 8, 'default2'), (3, 3, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH T AS (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A' OR PRODUCT_NAME = 'B', 1, 0)) AS AB, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) SELECT T.CUSTOMER_ID, C.CUSTOMER_NAME FROM T JOIN CUSTOMERS AS C ON T.CUSTOMER_ID = C.CUSTOMER_ID WHERE T.AB = 2 AND T.C = 0;

/*
Prediction Result:
(4, 'default2')
*/