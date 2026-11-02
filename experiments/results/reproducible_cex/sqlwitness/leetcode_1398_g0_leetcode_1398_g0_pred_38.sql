-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (3, 'B'), (0, 'default1'), (2, 'A'), (1, 'A'), (4, 'default2'), (5, 'A'), (6, 'B'), (7, 'default2'), (8, 'B'), (9, 'A'), (10, 'B'), (11, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 3, 'default1'), (2, 7, 'default2'), (3, 3, NULL), (1, 3, 'default1'), (4, 3, 'B'), (5, NULL, 'A'), (6, 3, 'A'), (7, 8, 'A'), (8, 10, 'B'), (9, 5, 'A'), (10, 9, 'B'), (11, 4, 'default1'), (12, 11, 'A'), (13, 6, 'default2'), (14, NULL, 'default2'), (15, 4, 'C'), (16, 8, 'A'), (17, 2, 'B'), (18, 2, 'C'), (19, 0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(3, 'B')
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME, SUM(CASE WHEN PRODUCT_NAME IN ('A', 'B') THEN 1 WHEN PRODUCT_NAME IN ('C') THEN -1 END) AS SCORE FROM CUSTOMERS AS C LEFT JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID GROUP BY 1, 2) AS A WHERE SCORE = 2;

/*
Prediction Result:
(3, 'B')
(8, 'B')
*/