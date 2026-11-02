-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default2'), (2, 'B'), (1, NULL), (-1, 'C'), (3, 'default2'), (4, 'B'), (5, 'A'), (6, 'A'), (7, 'A'), (8, NULL), (9, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, NULL, 'A'), (-1, -1, NULL), (0, NULL, 'default2'), (2, -1, NULL), (3, 0, 'default1'), (4, 0, 'default2'), (5, 4, 'B'), (6, 8, 'default1'), (7, 3, 'A'), (8, NULL, 'C'), (9, 6, NULL), (10, -1, 'default1'), (11, 5, 'default1'), (12, 4, 'A'), (13, 5, 'A'), (14, 5, 'default1'), (15, 4, 'default2'), (16, NULL, 'B'), (17, 3, NULL), (18, 7, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_NAME, B.CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) AS A, SUM(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) AS B, SUM(CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) AS C FROM ORDERS AS A LEFT JOIN CUSTOMERS AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID GROUP BY CUSTOMER_NAME) AS T WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID, CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
(4, 'B')
*/