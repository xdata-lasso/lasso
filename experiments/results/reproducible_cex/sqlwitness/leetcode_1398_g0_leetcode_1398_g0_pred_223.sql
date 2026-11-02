-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'B'), (0, 'B'), (1, 'B'), (2, NULL), (3, 'C'), (4, 'default1'), (5, 'default1'), (6, 'B'), (7, 'B'), (8, 'C'), (9, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 0, 'default2'), (-1, 7, 'A'), (2, 2, 'A'), (0, NULL, 'C'), (3, 7, 'default1'), (4, NULL, 'C'), (5, 0, 'A'), (6, 5, 'default1'), (7, 0, 'B'), (8, 9, 'A'), (9, 0, 'default1'), (10, 3, NULL), (11, 6, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH T AS (SELECT CUSTOMER_ID, CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END AS AFLAG, CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END AS BFLAG, CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END AS CFLAG FROM ORDERS) SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM T JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = T.CUSTOMER_ID GROUP BY 1 HAVING SUM(AFLAG) > 0 AND SUM(BFLAG) > 0 AND SUM(CFLAG) = 0;

/*
Prediction Result:
(0, 'B')
*/