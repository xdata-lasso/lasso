-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'A'), (2, 'default2'), (0, 'default1'), (-1, 'C'), (3, NULL), (4, 'C'), (5, 'default1'), (6, 'B'), (7, NULL), (8, 'default1'), (9, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 9, 'A'), (0, 1, NULL), (-1, 6, 'B'), (2, NULL, 'C'), (3, -1, 'C'), (4, NULL, 'C'), (5, 3, 'C'), (6, 1, 'A'), (7, 7, 'B'), (8, 4, NULL), (9, 8, 'A'), (10, 8, 'C'), (11, 9, 'default1'), (12, 6, 'B'), (13, 2, 'B'), (14, 0, 'A'), (15, 3, 'C'), (16, 9, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C INNER JOIN (SELECT CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 WHEN PRODUCT_NAME = 'B' THEN 1 WHEN PRODUCT_NAME = 'C' THEN -1 ELSE 0 END) AS TOT FROM ORDERS GROUP BY CUSTOMER_ID HAVING TOT > 1) AS O ON TRUE WHERE C.CUSTOMER_ID = O.CUSTOMER_ID;

/*
Prediction Result:
(6, 'B')
(9, None)
*/