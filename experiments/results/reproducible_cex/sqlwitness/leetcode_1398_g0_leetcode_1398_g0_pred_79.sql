-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (3, 'default2'), (2, 'B'), (0, 'A'), (-1, 'A'), (1, 'B'), (4, NULL), (5, NULL), (6, 'default1'), (7, 'C'), (8, 'A'), (9, 'B'), (10, 'default1'), (11, 'default2'), (12, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 1, 'default2'), (0, -1, 'C'), (-1, 11, 'default2'), (3, 5, 'default2'), (1, 3, NULL), (4, 6, 'C'), (5, 2, NULL), (6, 9, 'A'), (7, 12, 'C'), (8, 2, 'A'), (9, NULL, 'C'), (10, 2, 'A'), (11, 1, 'default1'), (12, 6, NULL), (13, 6, NULL), (14, 2, 'B'), (15, 1, 'default1'), (16, 3, 'default1'), (17, 4, 'C'), (18, 8, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH STAGING AS (SELECT CUSTOMER_ID, COUNT(DISTINCT (CASE WHEN PRODUCT_NAME IN ('A', 'B') THEN PRODUCT_NAME ELSE NULL END)) AS AANDBCOUNT, COUNT(DISTINCT (CASE WHEN PRODUCT_NAME = 'C' THEN PRODUCT_NAME ELSE NULL END)) AS CCOUNT FROM ORDERS GROUP BY CUSTOMER_ID) SELECT CUSTOMERS.CUSTOMER_ID, CUSTOMERS.CUSTOMER_NAME FROM STAGING JOIN CUSTOMERS ON STAGING.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID WHERE AANDBCOUNT >= 2 AND CCOUNT = 0;

/*
Prediction Result:
(2, 'B')
*/